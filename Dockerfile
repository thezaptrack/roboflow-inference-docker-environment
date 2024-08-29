FROM python:3.10-bullseye

# refresh
RUN apt update -y && apt upgrade -y

# install system utilities
RUN apt install -y git curl wget build-essential

# refresh pip
RUN pip install -U pip

# install Roboflow's on-device inference SDK for CPU inference
RUN pip install -U inference

# alternatively, install Roboflow's on-device inference-gpu SDK for GPU inference if an AI accelerator is available
# RUN pip install -U inference-gpu

WORKDIR /workspace

COPY . .