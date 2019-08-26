memcached
==========
This provides a Clear Linux* memcached instance.

Build
-----
```
docker build -t clearlinux/memcached .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/memcached
```

Start a memcached server 
-----------------------
```
docker run --network somenetwork --name memcached-server -d clearlinux/memcached
```

Benchmark test using memtier benchmark
---------------------
Please refer to the [page](https://github.com/RedisLabs/memtier_benchmark) for details.

```
docker pull redislabs/memtier_benchmark
docker run --rm --network somenetwork redislabs/memtier_benchmark ./memtier_benchmark --server=memcached-server -p 11211 -P memcache_text
```

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg

## Run memcached on  kubernetes cluster

```
kubectl create -f memcached-deployment.yaml
```

