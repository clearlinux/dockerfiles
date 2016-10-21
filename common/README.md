CIAO Common
==============
[![](https://images.microbadger.com/badges/image/clearlinux/ciao-common.svg)](http://microbadger.com/images/clearlinux/ciao-common "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/clearlinux/ciao-common.svg)](http://microbadger.com/images/clearlinux/common "Get your own version badge on microbadger.com")

This provides a CIAO Common base image that contains all initial requirements for working with CIAO project

Build
-----
```
    docker build -t clearlinux/ciao-common .
```

Or just pull it from Dockerhub
------------------------------
```
    docker pull clearlinux/ciao-common
```

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://clearlinux.org/documentation/swupdate_how_to_run_the_updater.html) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#/arg
