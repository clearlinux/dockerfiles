WordPress
==========
This provides a Clear Linux* WordPress instance.

Build
-----
```
docker build -t clearlinux/wordpress .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/wordpress
```

Start a wordpress instance
-----------------------
```
sudo docker-compose up
```

Check wordpress container status
-----------------------
```
run "docker container ls"
```

it will list wordpress containers info:
CONTAINER ID     IMAGE                       PORTS                  NAMES
eff987d8f6e9     clearlinux/nginx:latest     0.0.0.0:8080->80/tcp   wordpress_nginx_1
738f71a6e7fa     clearlinux/wordpress:latest 9000/tcp               wordpress_wordpress_1
deaa8614ce8d     clearlinux/mariadb:latest   3306/tcp               wordpress_db_1


Edit web/blog in wordpress
---------------------
open the brower on host machine, visit wordpress page with

```
http://host-ipaddr:8080/wp-login.php
```

Details of how-to
---------------------
Please refer to [page](https://hub.docker.com/_/wordpress).


Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
