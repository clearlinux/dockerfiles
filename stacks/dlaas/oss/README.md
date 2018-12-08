# Deep Learning Reference Stack

>>>>>>> 85383eb2e662dc34c0476f7641a75ca75fd7e716
[![](https://images.microbadger.com/badges/image/clearlinux/dlaas.svg)](http://microbadger.com/images/clearlinux/dlaas "Get your own image badge on microbadger.com")

This variant is built with Eigen

# Building Locally

```
docker build --no-cache -t clearlinux/dlaas .     # Optimized for Intel Architecture
```

## Optional Build ARGs

* `swupd_args` specifies
  [swupd update](https://clearlinux.org/documentation/clear-linux/guides/maintenance/swupd-guide#perform-a-manual-update)
  flags passed to the update during build.

# Pulling from Dockerhub
---------------------------

```
docker pull clearlinux/dlaas
```

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#/arg
