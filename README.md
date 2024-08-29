# roboflow inference docker environment

template to get up and running with a python installation containing the roboflow `inference` or `inference-gpu` module SDK.

the build scripts and tools in this template configuration will use docker compose to spin up a debian-based docker container using the official python 3.10 bullseye docker image that has the inference/inference-gpu SDK installed via pip.

## setup

make sure you have the following installed

- bash as the shell
- docker with the docker compose plugin
- (gnu) make

## start

type

```bash
$ make start
```

in order to

1. build the docker image
2. create the container
3. start the container
4. `exec` into the container via a `bash` session

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

after you've started the container for the first time, you can move between the parent (local) environment and the running container environment seamlessly:

- you can `exec` into the already-running container again by just typing the same `make start` instruction mentioned before.
- you can `exit` out of the running container by just typing `exit` as mentioned before.
