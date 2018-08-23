# Clear Linux* OS Installer CI Container
[![](https://images.microbadger.com/badges/image/clearlinux/clr-installer-ci.svg)](https://microbadger.com/images/clearlinux/clr-installer-ci "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/clearlinux/clr-installer-ci.svg)](https://microbadger.com/images/clearlinux/clr-installer-ci "Get your own version badge on microbadger.com")

This repo provides a Clear Linux* container for running the Clear Linux
OS Installer CI on Travis.  This container has all of the packages and
tools installed to build Clear Linux OS Installer from source and run
its test suite.

# Build
## Building Locally 
```
docker build -t clearlinux/clr-installer-ci .
```
> #### Note:
> If you are behind a firewall, you may need to pass proxy settings to the
> build environment:
>
> `--build-arg https_proxy="$https_proxy"`
>
> `--build-arg http_proxy="$http_proxy"`
>
> `--build-arg no_proxy="$no_proxy"`
>
> flags to docker build; note these only impact the Build Environment and
> will not become part of the image being built.

## Pulling from Docker Hub
```
docker pull clearlinux/clr-installer-ci
```

## Running the clr-installer-ci Container
```
docker run --network=host --name clear-test -v $(pwd):/travis -v /dev:/dev  -v /var/tmp/test:/tmp -v /sys/fs/cgroup:/sys/fs/cgroup:ro -e container=docker --privileged --tmpfs /run --tmpfs /run/lock -dit --rm clearlinux/clr-installer-ci:latest /sbin/init
```

## Configure Travis to build and run the Dockerfile
In your Travis config (`.travis.yml`), build and run your above `Dockerfile`. An
example `.travis.yml` file is as follows:
```
sudo: required

services:
    - docker

# This is just here for Travis CI to report correctly
language: go
go:
    - "1.10" # quote this or 1.10 is treated as 1.1 (floating point number)

before_install:
    - docker pull clearlinux/clr-installer-ci
    - docker run --network=host --name clear-test -v $(pwd):/travis -v /dev:/dev  -v /var/tmp/test:/tmp -v /sys/fs/cgroup:/sys/fs/cgroup:ro -e container=docker --privileged --tmpfs /run --tmpfs /run/lock -dit --rm clearlinux/clr-installer-ci:latest /sbin/init
    - docker ps

# Do NOT use -l (login) for the bash shell or the default profile
# (/usr/share/defaults/etc/profile) will reset PATH removing the
# GOPATH/bin added to the clr-installer-ci Docker image.

before_script:
    - docker exec -it clear-test bash -c "swupd info"

script:
    - docker exec -it clear-test bash -c "cd /travis ; make dist-clean"
    - docker exec -it clear-test bash -c "cd /travis ; make"
    - docker exec -it clear-test bash -c "cd /travis ; make lint"
    - travis_retry docker exec -it clear-test bash -c "cd /travis ; make check"

after_script:
    - docker container stop clear-test
```
