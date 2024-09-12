#!/usr/bin/env bash

SERVICE=roboflow-inference
SHELL=/bin/bash

COMPUTE_TYPE=$1

docker-compose build --build-arg COMPUTE_TYPE=${COMPUTE_TYPE}
docker compose up -d
docker compose exec $SERVICE $SHELL