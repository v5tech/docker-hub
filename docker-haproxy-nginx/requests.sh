#!/bin/sh

for i in $(seq 1 20);
do
  curl http://localhost:8080
done
