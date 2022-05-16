docker-compose build kong
docker-compose up -d kong-database
docker-compose run --rm kong kong migrations bootstrap
docker-compose run --rm kong kong migrations up
docker-compose run --rm kong kong config db_import /home/kong/kong.yml
docker-compose up -d kong
docker-compose ps
curl -s http://localhost:8001 | jq .plugins.available_on_server.oidc
docker-compose run --rm konga -c prepare -a postgres -u postgresql://kong:kong@kong-database:5432/kong
docker-compose up -d konga