# How to Use

```
  docker compose up -d
```

```
  curl http://localhost:8080/?url=http://ogp.me | jq

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
  curl http://localhost:8080/?url=http://ogp.me | jq

  {
    "image": "http://ogp.me/logo.png",
    "description": "The Open Graph protocol enables any web page to become a rich object in a social graph.",
    "title": "Open Graph protocol",
    "url": "http://ogp.me"
  }
```

#### Error

```
  curl http://localhost:8080/?url= | jq

  {
    error: '正しいURLを設定してください'
  }
```

# Requirements

## Ruby Version
- 2.4.x, 2.5.x

## Redis
- latest (2.x, 3.x)

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
bundle exec rake test
```

# Docker Image
