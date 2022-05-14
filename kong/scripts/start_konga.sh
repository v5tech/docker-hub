#!/bin/bash

# konga: Kong Admin UI
# https://github.com/pantsel/konga
# https://hub.docker.com/r/pantsel/konga/
# https://pantsel.github.io/konga/

# use same container network `kong-net` with kong

# create konga database (not share kong database)
docker run -d --name konga-database \
               --network=kong-net \
               -p 5433:5432 \
               -v $HOME/kong/konga/postgres-data:/var/lib/postgresql/data \
               -e "POSTGRES_USER=konga" \
               -e "POSTGRES_DB=konga" \
               -e "POSTGRES_PASSWORD=konga" \
               postgres:9.6

# prepare the database
docker run --rm \
             --network=kong-net \
             pantsel/konga:latest \
             -c prepare \
             -a "postgres" \
             -u "postgres://konga:konga@konga-database:5432/konga"

# start konga
docker run -d --name konga \
             --network kong-net \
             -e "TOKEN_SECRET=secret123" \
             -e "DB_ADAPTER=postgres" \
             -e "DB_URI=postgres://konga:konga@konga-database:5432/konga" \
             -e "NODE_ENV=development" \
             -p 1337:1337 \
             pantsel/konga:latest

# access Konga admin UI
# http://localhost:1337