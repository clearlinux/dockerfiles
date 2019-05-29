perl
==========
This provides a Clear Linux* perl instance.

Build
-----
```
docker build -t clearlinux/perl .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/perl
```

Test perl version
-----------------------
```
docker run --rm clearlinux/perl perl --version
```

Run a single Perl script
---------------------
```
docker run -it --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp clearlinux/perl perl your-daemon-or-script.pl
```

Details of how-to
---------------------
Please refer to the docker official golang image [page](https://hub.docker.com/_/perl).


Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
