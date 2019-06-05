os-core
==========
This provides the common base layer shared by all Clear Linux* based containers.  It
is not designed to be used stand alone, but to be pulled in via a FROM entry in a new
Dockerfile.

Build
-----
```
docker build -t clearlinux/os-core .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/os-core
```

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
