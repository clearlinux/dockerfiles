httpd
==========
This provides a Clear Linux* httpd instance.

Build
-----
```
docker build -t clearlinux/httpd .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/httpd
```

start a redis instance
-----------------------
```
docker run --name some-httpd -dit -p 8080:80 clearlinux/httpd
```

connecting
---------------------
```
curl http://localhost:8080/	# locally
curl http://${server-ip}:8080/	# remotely
```

benchmark test using apache ab
---------------------
Please refer to the [page](https://httpd.apache.org/docs/2.4/programs/ab.html) for details.

```
ab -n 25000 -c 50 -k http://${server-ip}:8080/
```


use customized configuration file
---------------------
The default conf file on clear Linux* is put on /usr/share/defaults/httpd/httpd.conf.
The /etc/httpd/conf.d/httpd.conf could be used to override the defaul one.
The default DocumentRoot is on /var/www/html/.
Above could be modified dynamically by "docker run -v " option, for example,

```
docker run --name some-httpd -dit -p 8080:80 \
	-v /etc/httpd/conf.d:/etc/httpd/conf.d \
	-v $PWD/html:/var/www/html \
	clearlinux/httpd
```

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
