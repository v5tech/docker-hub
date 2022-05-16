#!/bin/bash

# Create a user defined network
docker network create keycloak-network

# Start a MySQL instance
docker run --name keycloak-mysql \
  -d \
  --net keycloak-network \
  -v $HOME/keycloak/mysql-data:/var/lib/mysql \
  -e MYSQL_DATABASE=keycloak \
  -e MYSQL_USER=keycloak \
  -e MYSQL_PASSWORD=keycloak123 \
  -e MYSQL_ROOT_PASSWORD=keycloak123 \
  mysql:8.0

# Start a Keycloak instance
docker run --name keycloak \
  -d \
  --net keycloak-network \
  -p 8080:8080 \
  -e DB_VENDOR=mysql \
  -e DB_ADDR=keycloak-mysql \
  -e DB_DATABASE=keycloak \
  -e DB_USER=keycloak \
  -e DB_PASSWORD=keycloak123 \
  -e KEYCLOAK_USER=admin \
  -e KEYCLOAK_PASSWORD=admin \
  quay.io/keycloak/keycloak:15.0.0

# check logs
# docker logs -f keycloak