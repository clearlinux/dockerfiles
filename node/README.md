node
==========
This provides a Clear Linux* nodejs basic cli instance.

Build
-----
```
docker build -t clearlinux/node .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/node
```

start a node instance
-----------------------
```
docker run -it --rm clearlinux/node
```

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
