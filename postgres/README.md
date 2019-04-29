PostgreSQL
==========
This provides a Clear Linux* PostgreSQL instance.

Build
-----
```
docker build -t clearlinux/postgres .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/postgres
```

Start PostgreSQL Container
-----------------------
```
docker run -p 5432:5432 -e POSTGRES_PASSWORD=secret -d clearlinux/postgres
```

Environment Variables
---------------------
- See ``Environment Variables`` section of the official postgres image [page](https://hub.docker.com/_/postgres).

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
