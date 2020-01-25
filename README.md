# Docker Image
[https://hub.docker.com/r/webuilder240/ogp_parse_api/]

# WebAPI (Heroku)
[https://powerful-sierra-79664.herokuapp.com/] 

# How to Use

```
  curl https://powerful-sierra-79664.herokuapp.com/?url=http://ogp.me | jq

  {
    "image": "http://ogp.me/logo.png",
    "description": "The Open Graph protocol enables any web page to become a rich object in a social graph.",
    "title": "Open Graph protocol",
    "url": "http://ogp.me"
  }
```

# Endpoints

## GET /

### Paramater

|name|required|type|Description|
|:---|:---|:---|:---|
|url|True|string|scrape url|

### Response

#### Success

```
  curl https://powerful-sierra-79664.herokuapp.com/?url=http://ogp.me | jq

  {
    "image": "http://ogp.me/logo.png",
    "description": "The Open Graph protocol enables any web page to become a rich object in a social graph.",
    "title": "Open Graph protocol",
    "url": "http://ogp.me"
  }
```

#### Error

```
  curl https://powerful-sierra-79664.herokuapp.com/?url= | jq

  {
    error: '正しいURLを設定してください'
  }
```

# Requirements

## Ruby Version
- 2.4.x, 2.5.x, 2.6.x

## Redis
- latest

# Configure

## Redis
- REDIS_URL
  - Redis url (Default: 'redis://127.0.0.1:6379')
- REDIS_TTL
  - Expire key TTL (Default: 604800 [1 week])

## Unicorn
- WEB_CONCURRENCY
  - Unicorn Worker Count (Default: 3)

# Runnning Test

``` 
bundle install
bundle exec rake test
```

# Run Locally (Docker Componse)

``` 
docker-compose up
```

