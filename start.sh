#!/usr/bin/env bash

SERVICE=roboflow-inference
SHELL=/bin/bash

for ARGUMENT in "$@"
do
   KEY=$(echo $ARGUMENT | cut -f1 -d=)

   KEY_LENGTH=${#KEY}
   VALUE="${ARGUMENT:$KEY_LENGTH+1}"

   export "$KEY"="$VALUE"
done

echo "[INFO] COMPUTE_TYPE: $COMPUTE_TYPE"

if [ "$COMPUTE_TYPE" = "gpu" ]; then
    export COMPUTE_TYPE="gpu"
elif [ "$COMPUTE_TYPE" = "cpu" ]; then
    export COMPUTE_TYPE="cpu"
elif [ "$COMPUTE_TYPE" = "" ]; then
    export COMPUTE_TYPE="cpu"
    echo "[WARN] no COMPUTE_TYPE specified, defaulting to '$COMPUTE_TYPE'"
else
    echo "[ERROR] invalid COMPUTE_TYPE specified. please use 'gpu' or 'cpu'"
    exit 1
fi

docker compose build --build-arg COMPUTE_TYPE=${COMPUTE_TYPE}
docker compose up -d
docker compose exec $SERVICE $SHELL
