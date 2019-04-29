Machine Learning
================
[![](https://images.microbadger.com/badges/image/clearlinux/machine-learning-ui.svg)](http://microbadger.com/images/clearlinux/machine-learning-ui "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/clearlinux/machine-learning-ui.svg)](http://microbadger.com/images/clearlinux/machine-learning-ui "Get your own version badge on microbadger.com")

This provides a machine learning environment with the `machine-learning-web-ui`,
bundle from [Clearlinux](https://clearlinux.org/documentation/bundles_overview.html)

Build
-----
```
docker build -t clearlinux/machine-learning-ui .
```

Or just pull it from Dockerhub
------------------------------
```
docker pull clearlinux/machine-learning-ui
```

Run the machine-learning-ui Container
----------------------------------
```
docker run -it clearlinux/machine-learning-ui
```

Environment Variables
---------------------
none

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#/arg
