#!/usr/bin/env bash

for ARGUMENT in "$@"
do
   KEY=$(echo $ARGUMENT | cut -f1 -d=)

   KEY_LENGTH=${#KEY}
   VALUE="${ARGUMENT:$KEY_LENGTH+1}"

   export "$KEY"="$VALUE"
done

# install Roboflow's on-device inference or inference-gpu SDK for CPU/GPU inference
if [ "$COMPUTE_TYPE" = "gpu" ]; then
    echo "[INFO] installing inference-gpu"
    pip install -U inference-gpu >/dev/null
else
    echo "[INFO] installing inference"
    pip install -U inference >/dev/null
fi