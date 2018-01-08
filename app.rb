require 'rubygems'
require "sinatra/base"
require 'logger'
require 'json'
require 'redis'
require 'cgi'
require 'opengraph_parser'

class App < Sinatra::Base
  # Refactor ...
  if ENV['RACK_ENV'] == 'test'
    require 'mock_redis'
    redis = MockRedis.new
  else
    redis = Redis.new(url: ENV['REDIS_URL'] || "redis://127.0.0.1:6379")
  end

  ttl = ENV['REDIS_TTL'] || 604800

  set :show_exceptions, false
  set :dump_errors, true

  before do
    content_type :json
  end

  not_found do |e|
    status 404
    {error: 'エンドポイントが存在しません'}.to_json
  end

  error do |e|
    status 500
    {error: 'Internal Server Error'}.to_json
  end

  def render_error(status_code: 500, message: )
    status status_code
    {
      error: message
    }.to_json
  end

  get '/' do
    return render_error(status_code: 422, message: 'URLを設定してください') unless params['url']
    url = CGI.unescape(params['url'])
    return render_error(status_code: 422, message: '正しい形式のURLを入力してください')  unless url =~ /\A#{URI::regexp(['http', 'https'])}\z/
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
    ogp.to_json
  end
end
