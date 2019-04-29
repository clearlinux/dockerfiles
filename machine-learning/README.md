Machine Learning
================
[![](https://images.microbadger.com/badges/image/clearlinux/machine-learning.svg)](http://microbadger.com/images/clearlinux/machine-learning "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/clearlinux/machine-learning.svg)](http://microbadger.com/images/clearlinux/machine-learning "Get your own version badge on microbadger.com")

This provides a machine learning environment with the `machine-learning-basic`,
`R-basic` and `R-extras` bundles from [Clearlinux](https://clearlinux.org/documentation/bundles_overview.html)

Build
-----
```
docker build -t clearlinux/machine-learning .
```

Or just pull it from Dockerhub
------------------------------
```
docker pull clearlinux/machine-learning
```

Run the machine-learning Container
----------------------------------
```
docker run -it clearlinux/machine-learning
```

Environment Variables
---------------------
none

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#/arg
