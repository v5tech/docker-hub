#!/bin/bash

# https://docs.konghq.com/install/docker/
# https://cookcode.blog.csdn.net/article/details/118892872

# create kong container network
docker network create kong-net

# start PostgreSQL database
docker run -d --name kong-database \
               --network=kong-net \
               -p 5432:5432 \
               -v $HOME/kong/postgres-data:/var/lib/postgresql/data \
               -e "POSTGRES_USER=kong" \
               -e "POSTGRES_DB=kong" \
               -e "POSTGRES_PASSWORD=kong" \
               postgres:9.6

# prepare database

docker run --rm \
     --network=kong-net \
     -e "KONG_DATABASE=postgres" \
     -e "KONG_PG_HOST=kong-database" \
     -e "KONG_PG_USER=kong" \
     -e "KONG_PG_PASSWORD=kong" \
     kong:latest kong migrations bootstrap

# secure admin api
# https://docs.konghq.com/gateway-oss/2.5.x/secure-admin-api/
# https://dev.to/vousmeevoyez/setup-kong-konga-part-2-dan

# Load the configuration file which enables the Admin API loopback
# Notice that it is assumed that kong.yml is located in $(pwd)/kong.yml

# delete the service if duplicate
# curl -X DELETE "http://localhost:8001/services/admin-api"

docker run --rm \
    --network=kong-net \
    -e "KONG_DATABASE=postgres" \
    -e "KONG_PG_HOST=kong-database" \
    -e "KONG_PG_USER=kong" \
    -e "KONG_PG_PASSWORD=kong" \
    -v ./kong.yml:/home/kong/kong.yml \
    kong:latest kong config db_import /home/kong/kong.yml

# start kong
docker run -d --name kong \
     --network=kong-net \
     -e "KONG_DATABASE=postgres" \
     -e "KONG_PG_HOST=kong-database" \
     -e "KONG_PG_USER=kong" \
     -e "KONG_PG_PASSWORD=kong" \
     -e "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
     -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" \
     -e "KONG_PROXY_ERROR_LOG=/dev/stderr" \
     -e "KONG_ADMIN_ERROR_LOG=/dev/stderr" \
     -e "KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl" \
     -p 8000:8000 \
     -p 8443:8443 \
     -p 127.0.0.1:8001:8001 \
     -p 127.0.0.1:8444:8444 \
     kong:latest
