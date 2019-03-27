nginx
==========
This provides a Clear Linux* nginx service

Build
-----
```
docker build -t clearlinux/nginx .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/nginx
```

Start nginx Container
-----------------------
```
docker run -p 80:80 -v /var/www:/var/www -d clearlinux/nginx
```

How to use this image
---------------------
- See ``How to use this image`` section of the official nginx image [page](https://hub.docker.com/_/nginx).

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://clearlinux.org/documentation/swupdate_how_to_run_the_updater.html) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
