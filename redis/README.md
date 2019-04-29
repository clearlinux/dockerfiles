Redis
==========
This provides a Clear Linux* Redis instance.

Build
-----
```
docker build -t clearlinux/redis .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/redis
```

start a redis instance
-----------------------
```
docker run --name some-redis --network some-network -d clearlinux/redis redis-server --protected-mode no
```

connecting via redis-cli
---------------------
```
docker run -it --network some-network --rm clearlinux/redis redis-cli -h some-redis
```

benchmark test
---------------------
```
docker run --network some-network --rm clearlinux/redis redis-benchmark -h some-redis
```

details of how-to
---------------------
Please refer to the official redis image [page](https://hub.docker.com/_/redis).

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
