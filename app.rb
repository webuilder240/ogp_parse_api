require 'rubygems'
require 'json'
require 'redis'
require 'cgi'
require 'opengraph_parser'
require 'logger'
class App

  def call (env)
    begin
      redis = set_redis()
      ttl = ENV['REDIS_TTL'] || 604800
      req = Rack::Request.new(env)
      if req.path == '/'
        if req.params['url']
          url = CGI.unescape(req.params['url'])
          if url =~ /\A#{URI::regexp(['http', 'https'])}\z/
            ogp = redis.hgetall(url)
            if ogp.empty?
              og = OpenGraph.new(url)
              ogp = {'title' => og.title, 'description' => og.description, 'image' => og.images.first}
              redis.multi do
                redis.hmset(url, 'title', ogp['title'], 'description', ogp['description'], 'image', ogp['image'])
                redis.expire(url, ttl)
              end
            end
            ogp['url'] = url
            render(status_code: 200, body: ogp)
          else
            render(status_code: 422, body: {error: '正しい形式のURLを入力してください'})
          end
        else
          render(status_code: 422, body: {error: 'URLを設定してください'})
        end
      else
        render(status_code: 404, body: {error: 'Not Found'})
      end
    rescue Exception => e
      logger.fatal e.message
      logger.fatal e.backtrace.join("\n")
      render(status_code: 500, body: {error: 'Server Internal Error'})
    end
  end

  def logger
    Logger.new($stdout)
  end

  def set_redis
    if ENV['RACK_ENV'] == 'test'
      require 'mock_redis'
      MockRedis.new
    else
      require 'redis'
      Redis.new(url: ENV['REDIS_URL'] || "redis://127.0.0.1:6379")
    end
  end

  def render(status_code: , body: )
    [status_code, {'Content-Type' => 'application/json'}, [body.to_json]]
  end
end
