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


Container Image Size
---------------------
Clear Linux enables the AVX2 instructions compile in default for many applications, including mariadb.
With the two sets of binaries/libraries as below, this mariadb in Clear Linux can automatically and 
dynamically choose corresponding set to support different IA platforms.

SSE:
```
/usr/bin/mariadb
/usr/bin/mariadb-access
/usr/bin/mariadb-admin
/usr/bin/mariadb-backup
...
/usr/bin/mysql
/usr/bin/mysql_client_test
/usr/bin/mysql_config
...
/usr/lib64/libmariadb.so
/usr/lib64/libmariadbd.so
/usr/lib64/libmariadbd.so.19
...
```

AVX/AVX2:
```
/usr/bin/haswell/mariadb
/usr/bin/haswell/mariadb-admin
/usr/bin/haswell/mariadb-backup
/usr/bin/haswell/mariadb-binlog
...
/usr/bin/haswell/mysql
/usr/bin/haswell/mysql_client_test
/usr/bin/haswell/mysql_ldb
...
/usr/lib64/haswell/libmariadb.so
/usr/lib64/haswell/libmariadbd.so
/usr/lib64/haswell/libmariadbd.so.19
...
```

The side effect is the size of the container image is bigger because of two sets binary included. For some size sensitive scenario, user can select the right binary only. 

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg

## Run MariaDB on kubernetes cluster

```
1. kubectl create secret generic mariadb2 \
--from-literal= mysql-root-password= <your-mysql-root-pwd> \
--from-literal= mysql-user= <your-mysql-user> \
--from-literal= mysql-password = <your-mysql-pwd>

2. kubectl create -f mariadb-deployment.yaml
```

