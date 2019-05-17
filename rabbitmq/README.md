rabbitmq
==========
This provides a Clear Linux* rabbitmq-server container

Build
-----
```
docker build -t clearlinux/rabbitmq .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/rabbitmq
```

Run rabbitmq-server instance
-----------------------
```
docker run --rm -it --hostname my-rabbit --name some-rabbit clearlinux/rabbitmq
```

Details of how-to
---------------------
- Please refer to the docker official rabbitmq image [page](https://hub.docker.com/_/rabbitmq).

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
