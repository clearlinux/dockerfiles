golang
==========
This provides a Clear Linux* golang instance.

Build
-----
```
docker build -t clearlinux/golang .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/golang
```

Test go version
-----------------------
```
docker run --rm clearlinux/golang go version
```

Test go build
---------------------
```
docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp clearlinux/golang go build -v
```

Details of how-to
---------------------
Please refer to the docker official golang image [page](https://hub.docker.com/_/golang).


Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
