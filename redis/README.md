# Redis


```bash
docker run -d -p 6379:6379 redislabs/redismod
```


```bash
docker run -d --name redis-stack -p 6379:6379 -p 8001:8001 redis/redis-stack:latest
```


```bash
docker run \
  -p 6379:6379 \
  -v /home/user/data:/data \
  -v /home/user/redis.conf:/usr/local/etc/redis/redis.conf \
  redislabs/redismod \
  /usr/local/etc/redis/redis.conf
```


```yaml
version: '3.9'
services:
  redis:
    image: 'redis/redis-stack:latest'
    ports:
      - '6379:6379'
    volumes:
      - ./data:/data
    environment:
      - REDIS_ARGS: --save 20 1
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure
```
