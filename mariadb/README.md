MariaDB
=======
[![](https://images.microbadger.com/badges/image/clearlinux/mariadb.svg)](http://microbadger.com/images/clearlinux/mariadb "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/clearlinux/mariadb.svg)](http://microbadger.com/images/clearlinux/mariadb "Get your own version badge on microbadger.com")

This provides a Clear Linux* MariaDB

Build
-----
```
docker build -t clearlinux/mariadb .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/mariadb:stable
```

Start MariaDB Container
-----------------------
```
YOUR_HOST=`hostname -f`
docker run --name mariadb -p 3306:3306 -e MYSQL_ROOT_PASSWORD=secret -d clearlinux/mariadb:stable
# Test it
mysql -uroot -h $YOUR_HOST -psecret -e "show databases;"
```

Environment Variables
---------------------
- ``MYSQL_ROOT_PASSWORD`` specifies MariaDB root password

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#/arg
