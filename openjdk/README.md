openjdk
==========
This provides a Clear Linux* openjdk container

Build
-----
```
docker build -t clearlinux/openjdk .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/openjdk
```

Compile your java app inside the Docker container
-----------------------
```
docker run --rm -it --name myapp -v "$PWD":/usr/src/myapp -w /usr/src/myapp clearlinux/openjdk javac myapp.java
```

Run your java app instance
-----------------------
```
docker run --rm -it --name myapp -v "$PWD":/usr/src/myapp -w /usr/src/myapp clearlinux/openjdk java myapp
```

Details of how-to
---------------------
- Please refer to the docker official openjdk image [page](https://hub.docker.com/_/openjdk).

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
