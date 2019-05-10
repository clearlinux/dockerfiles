tensorflow
==========
This provides a Clear Linux* tensorflow instance.

Build
-----
```
docker build -t clearlinux/tensorflow .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/tensorflow
```

Test go version
-----------------------
```
docker run -it --rm clearlinux/tensorflow bash
```


Details of how-to
---------------------
Please refer to the docker official tensorflow image [page](https://hub.docker.com/r/tensorflow/tensorflow).


Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
