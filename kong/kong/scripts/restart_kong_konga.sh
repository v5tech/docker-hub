#!/bin/bash

docker restart kong-database && \
  docker restart kong && \
  docker restart konga-database && \
  docker restart konga
