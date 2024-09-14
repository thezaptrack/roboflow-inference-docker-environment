SHELL := /bin/bash

.PHONY: start stop xhost run

start:
	@chmod +x start.sh
	@if [ "$(COMPUTE_TYPE)" = "gpu" ]; then \
		export COMPUTE_TYPE="gpu"; \
	elif [ "$(COMPUTE_TYPE)" = "cpu" ]; then \
		export COMPUTE_TYPE="cpu"; \
	elif [ "$(COMPUTE_TYPE)" = "" ]; then \
		export COMPUTE_TYPE="cpu"; \
		echo "no COMPUTE_TYPE specified, defaulting to '$$COMPUTE_TYPE'"; \
	else \
		echo "invalid COMPUTE_TYPE specified. please use 'gpu' or 'cpu'"; \
		exit 1; \
	fi; \
	./start.sh $$COMPUTE_TYPE

stop:
	source stop.sh

xhost:
	xhost +local:docker

run: xhost start
