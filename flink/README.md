Flink
==========
This provides a Clear Linux* flink container

Build
-----
```
docker build -t clearlinux/flink .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/flink
```

Start flink Container
-----------------------
```
docker run  -d clearlinux/flink
```

How to use this image
---------------------
- See ``How to use this image`` section of the official flink image [page](https://hub.docker.com/_/flink).

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
