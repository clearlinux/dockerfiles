php
==========
This provides a Clear Linux* php basic cli instance.

Build
-----
```
docker build -t clearlinux/php .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/php
```

start a php instance
-----------------------
```
docker run --name some-php clearlinux/php
```

Run my own php instance
-----------------------
Create a Dockerfile in your own php project
```
FROM clearlinux/php:latest
COPY . /usr/src/myphpapp
WORKDIR /usr/src/myphpapp
CMD [ "php", "./my-script.php" ]
```

Then, run the commands to build and run the Docker image:
```
$ docker build -t my-own-php-instance .
$ docker run -it --rm --name my-running-php my-own-php-instance
```

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://clearlinux.org/documentation/swupdate_how_to_run_the_updater.html) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
