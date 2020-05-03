ruby '2.6.6'

source "https://rubygems.org"
gem 'rack'
gem 'unicorn'
gem 'redis'
gem 'opengraph_parser'
group :development, :test do
  gem 'rake'
  gem 'rspec'
  gem "mock_redis"
  gem 'rack-test'
end

group :production do
  gem "puma"
  gem "puma-heroku"
end
