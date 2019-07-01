php-fpm
==========
This provides a Clear Linux* php-fpm instance.

Build
-----
```
docker build -t clearlinux/php-fpm .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/php-fpm
```

start a php-fpm instance
-----------------------
```
docker run --name some-php-fpm clearlinux/php-fpm
```

Test
-----------------------
```
docker exec -it some-php-fpm bash
php-fpm -t
```

More typical, php-fpm works with nginx, mariadb, for example in wordpress use case. For details, please refer to clearlinux wordpress micro service. 


Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
