Cassandra
==========
This provides a Clear Linux* Cassandra instance.

Build
-----
```
docker build -t clearlinux/cassandra .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/cassandra
```

start a cassandra instance
-----------------------
```
docker run --name some-cassandra --network some-network -d clearlinux/cassandra:tag
```

connect to cassandra from cqlsh
---------------------
```
docker run -it --network some-network --rm clearlinux/cassandra cqlsh -h some-cassandra
```

benchmark test
---------------------
```
TBD
```

details of how-to
---------------------
Please refer to the official cassandra image [page](https://hub.docker.com/_/cassandra).

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
