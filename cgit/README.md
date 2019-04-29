# cgit
==========
This provides a Clear Linux* cgit service

Build
-----
```
docker build -t clearlinux/cgit .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/cgit
```

Start cgit Container
-----------------------
```
docker run -p 80:80 -v <git repo path>:/var/www/cgit clearlinux/cgit
```

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
