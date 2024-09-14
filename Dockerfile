FROM python:3.10-bullseye

ENV TERM=xterm
ENV DEBIAN_FRONTEND=noninteractive

ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH=/workspace

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

WORKDIR /workspace
COPY . .

ARG COMPUTE_TYPE

# install dependencies conditionally based on build args
RUN chmod +x dependencies.sh && ./dependencies.sh COMPUTE_TYPE=$COMPUTE_TYPE
