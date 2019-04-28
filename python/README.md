Python
==========
This provides a Clear Linux* python container

Build
-----
```
docker build -t clearlinux/python .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/python
```

Start python Container
-----------------------
```
docker run  -d clearlinux/python
```

How to use this image
---------------------
- See ``How to use this image`` section of the official python image [page](https://hub.docker.com/_/python).

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://clearlinux.org/documentation/swupdate_how_to_run_the_updater.html) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
