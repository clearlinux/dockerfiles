haproxy
==========
This provides a Clear Linux* haproxy instance.

Build
-----
docker build -t clearlinux/haproxy .

Or just pull it from Dockerhub
---------------------------
docker pull clearlinux/haproxy

start a haproxy instance
-----------------------
docker run --name some-haproxy -d -p 8080:80 clearlinux/haproxy

use customized configuration file
---------------------
Since no two users of haproxy are likely to configure it exactly alike, we provide /usr/local/etc/haproxy/haproxy.cfg as an example, user may need to customize their own and override this default. Please refer to [page](https://cbonte.github.io/haproxy-dconv/) for configure details.

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
