PostgreSQL
==========
This provides a Clear Linux* PostgreSQL instance.

Build
-----
```
docker build -t clearlinux/postgresql .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/postgresql
```

Start PostgreSQL Container
-----------------------
```
docker run -p 5432:5432 -e PGSQL_ROOT_PASSWORD=secret -d clearlinux/postgresql
```

Environment Variables
---------------------
- ``PGSQL_ROOT_PASSWORD`` specifies PostgreDB root password

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://clearlinux.org/documentation/swupdate_how_to_run_the_updater.html) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
