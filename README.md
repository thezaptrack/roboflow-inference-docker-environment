# roboflow inference docker environment

containerized template to get up and running with a `python` installation containing the roboflow `inference` or `inference-gpu` module SDK.

## features

- the build scripts and tools in this template configuration will use `docker compose` to spin up a `debian`-based `docker` container using the official `python 3.10` bullseye `docker` image that has the `inference`/`inference-gpu` SDK installed via `pip`.

- build configuration options to install either `inference` or `inference-gpu` at the `Makefile` level.

- the docker compose specification is configured to allow pass-through for the `/dev/video0` and `/dev/video1` device files in order to enable the container to access the webcam and/or other camera devices bound to those files.

- the docker compose specification has the requisite volume mounts needed to allow display forwarding outside of the container and into the host via `X11` in order to allow `opencv` to display GUI windows.

    ```yaml
        - /tmp/.X11-unix:/tmp/.X11-unix
        - $HOME/.Xauthority:/root/.Xauthority
    ```

## setup

make sure you have the following installed

- bash as the shell
- docker with the docker compose plugin
- (gnu) make

also make sure you have the X server running on the host

```bash
$ sudo X
```

## run

type

```bash
$ make run
```

in order to

1. add `+local:docker` to the X server's access list
2. build the docker image with `inference` (CPU is the default `COMPUTE_TYPE`)
3. create the container
4. start the container
5. `exec` into the container via a `bash` session

alternatively, type

```bash
$ make run COMPUTE_TYPE='gpu'
```

in order to execute the same steps but build the docker image with `inference-gpu` instead if a GPU or any other kind of accelerator (OpenVINO, TensorRT) is available to be leveraged for faster inference

## stop

first, make sure you've exited out the container by typing

```bash
$ exit
```

then, type

```bash
$ make stop
```

in order to

1. stop the container
2. remove the container
3. remove the built docker image

alternatively, type

```bash
$ docker compose down
```

if you just want to stop and remove the container but don't want to remove the built docker image (useful when you don't want to rebuild the entire image on each `make start`)

## `exec`ing and `exit`ing

after you've started the container for the first time, you can move between the host (local) environment and the running container environment seamlessly:

- you can `exec` into the already-running container again by just typing the same `make start` instruction mentioned before.
- you can `exit` out of the running container by just typing `exit` as mentioned before.
