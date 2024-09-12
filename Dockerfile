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

ARG COMPUTE_TYPE
# install Roboflow's on-device inference or inference-gpu SDK for CPU/GPU inference
RUN if [ "$COMPUTE_TYPE" = "gpu" ] ; then pip install -U inference-gpu ; else pip install -U inference ; fi

WORKDIR /workspace

COPY . .

ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH=/workspace