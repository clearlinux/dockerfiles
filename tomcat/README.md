tomcat
==========
This provides a Clear Linux* apache-tomcat container

Build
-----
```
docker build -t clearlinux/tomcat .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/tomcat
```

Run apache-tomcat instance
-----------------------
```
docker run --rm -it --hostname my-tomcat --name some-tomcat -p 8080:8080 clearlinux/tomcat
```

Details of how-to
---------------------
- Please refer to the docker official tomcat image [page](https://hub.docker.com/_/tomcat).

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
