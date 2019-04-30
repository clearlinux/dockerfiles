MariaDB
=======

This provides a Clear Linux* MariaDB

Build
-----
```
docker build -t clearlinux/mariadb .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/mariadb:latest
```

Start MariaDB Container
-----------------------
```
docker run --name clr-mariadbtest -e MYSQL_ROOT_PASSWORD=mypass -d clearlinux/mariadb
# Get the mariadb server IP
docker inspect clr-mariadbtest | grep IPAddress
# Test it
mysql -h $IP -u root -p
```

Environment Variables
---------------------
- ``MYSQL_ROOT_PASSWORD`` specifies MariaDB root password

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
