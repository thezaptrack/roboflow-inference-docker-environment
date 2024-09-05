FROM python:3.10-bullseye

ENV TERM=xterm
ENV DEBIAN_FRONTEND=noninteractive

# refresh
RUN apt update -y && apt upgrade -y

# install system utilities
RUN apt install -y git curl wget build-essential

# install system dependencies
RUN apt install -y --no-install-recommends \
    libopencv-dev \
    python3-opencv \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# refresh pip
RUN pip install -U pip

# install Roboflow's on-device inference SDK for CPU inference
RUN pip install -U inference

# alternatively, install Roboflow's on-device inference-gpu SDK for GPU inference if an AI accelerator is available
# RUN pip install -U inference-gpu

WORKDIR /workspace

COPY . .

ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH=/workspace