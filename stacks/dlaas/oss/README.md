# Clear Linux Deep Learning Stack
[![](https://images.microbadger.com/badges/image/clearlinux/dlaas.svg)](http://microbadger.com/images/clearlinux/dlaas "Get your own image badge on microbadger.com")

This variant is built with Eigen

# Building Locally

```
docker build --no-cache -t clearlinux/dlaas .     # Optimized for Intel Architecture
```

## Optinal Build ARGs

* `swupd_args` specifies
  [swupd update](https://clearlinux.org/documentation/clear-linux/guides/maintenance/swupd-guide#perform-a-manual-update)
  flags passed to the update during build.

# Pulling from Dockerhub
---------------------------

```
docker pull clearlinux/dlaas
```

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#/arg
