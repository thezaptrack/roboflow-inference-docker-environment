SHELL := /bin/bash

.PHONY: start stop xhost run

start:
	@chmod +x start.sh
	@export COMPUTE_TYPE="$(COMPUTE_TYPE)"
	@./start.sh COMPUTE_TYPE=$$COMPUTE_TYPE

stop:
	source stop.sh

xhost:
	xhost +local:docker

run: xhost start
