# kong

微服务网关

## kong-database

```bash
docker run -d --name kong-database \
    -p 5432:5432 \
    -e "POSTGRES_USER=kong" \
    -e "POSTGRES_DB=kong" \
    postgres:9.4
```

## kong

```bash
docker run -d --name kong \
    --link kong-database:kong-database \
    -e "KONG_DATABASE=postgres" \
    -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
    -e "KONG_PG_HOST=kong-database" \
    -p 8000:8000 \
    -p 8443:8443 \
    -p 8001:8001 \
    -p 7946:7946 \
    -p 7946:7946/udp \
    kong:latest
```

8000端口 http 监听客户端传入的HTTP流量

8443端口 https 监听客户端传入的HTTPS流量

8001端口 admin api监听端口

## kong-dashboard

```bash
docker run -d -p 8080:8080 --name kong-dashboard pgbi/kong-dashboard:v2
```

http://ip:8080