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

## Run PostgreSQL on  kubernetes cluster

```
1. kubectl create secret generic postgres-config \
--from-literal= POSTGRES_DB= <your-postgres-db> \
--from-literal= POSTGRES_PASSWORD= <your-postgres-pwd> \
--from-literal= POSTGRES_USER = <your-postgres-user>

2. kubectl create -f postgres-deployment.yaml
```

