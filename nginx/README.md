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
docker run -p 80:80 -v /some/content:/usr/share/nginx/html -d clearlinux/nginx
```

How to use this image
---------------------
- See ``How to use this image`` section of the official nginx image [page](https://hub.docker.com/_/nginx).

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
