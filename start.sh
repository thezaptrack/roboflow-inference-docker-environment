#!/usr/bin/env bash

SERVICE=roboflow-inference
SHELL=/bin/bash

docker compose up -d
docker compose exec $SERVICE $SHELL