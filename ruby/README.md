Ruby
==========
This provides a Clear Linux* ruby container

Build
-----
```
docker build -t clearlinux/ruby .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/ruby
```

Start ruby Container
-----------------------
```
docker run  -d clearlinux/ruby
```

How to use this image
---------------------
- See ``How to use this image`` section of the official ruby image [page](https://hub.docker.com/_/ruby).

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
