# Mixer CI Container
[![](https://images.microbadger.com/badges/image/clearlinux/mixer-ci.svg)](http://microbadger.com/images/clearlinux/clr-sdk "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/clearlinux/mixer-ci.svg)](http://microbadger.com/images/clearlinux/clr-sdk "Get your own version badge on microbadger.com")

This repo provides a Clear Linux* container for running the Mixer CI on Travis.
This container has all of the packages and tools installed to build Mixer from
source and run its test suite.

# Build
## Building Locally 
```
docker build -t clearlinux/mixer-ci .
```
> #### Note:
> If you are behind a firewall, you may need to pass the `--network host` and/or
> `--build-arg http://<proxy>:<port>` flags to docker build to configure your
> proxy.

## Pulling from Dockerhub
```
docker pull clearlinux/mixer-ci
```

# Use
## Create a derivative Dockerfile
This image creates a container with a user named `clr`, with the `GOPATH` in
`/home/clr/go`.

Create a `Dockerfile` based on this `mixer-ci` image. In this `Dockerfile`, copy
the source code into the `mixer-tools` **package root** within the `GOPATH`,
then execute the build and test steps. An example `Dockerfile` is as follows:
```
FROM clearlinux/mixer-ci:latest
COPY --chown=clr:clr . /home/clr/go/src/github.com/clearlinux/mixer-tools/
WORKDIR /home/clr/go/src/github.com/clearlinux/mixer-tools
ENTRYPOINT ["/bin/sh", "-c", "make && sudo -E make install && make lint && make check"]
```

> #### Note:
> You can inspect [Mixer's Dockerfile](https://github.com/clearlinux/mixer-tools/blob/master/Dockerfile)
> to see how this is used in production.

## Configure Travis to build and run the Dockerfile
In your Travis config (`.travis.yml`), build and run your above `Dockerfile`. An
example `.travis.yml` file is as follows:
```
language: go
sudo: required

go:
    - 1.9

go_import_path: github.com/clearlinux/mixer-tools

services:
    - docker

before_install:
    - docker build -t testdock .

script:
    - docker run testdock
```
> #### Note:
> You can inspect [Mixer's Travis config](https://github.com/clearlinux/mixer-tools/blob/master/.travis.yml)
> to see how this is used in production. For more information on Travis
> configuration, see the [Travis documentation](https://docs.travis-ci.com/user/customizing-the-build).

