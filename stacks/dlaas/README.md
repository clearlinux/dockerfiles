# Clear Linux Deep Learning Stack
[![](https://images.microbadger.com/badges/image/clearlinux/dlaas.svg)](http://microbadger.com/images/clearlinux/mariadb "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/clearlinux/dlaas.svg)](http://microbadger.com/images/clearlinux/mariadb "Get your own version badge on microbadger.com")

This provides a Clear Linux Deep Learning Stack. To offer more flexibility,
there are two versions of the Deep Learning Stack:  a
version that supports the TensorFlow* framework, and a second version that includes the TensorFlow* framework optimized using Intel®
Math Kernel Library for Deep Neural Networks (Intel® MKL-DNN) primitives.


# Building Locally

```
docker build --no-cache -f oss/Dockerfile -t clearlinux/dlaas .     # TensorFlow
docker build --no-cache -f mkl/Dockerfile -t clearlinux/dlaas-mkl . # TensorFlow with MKL-DNN
```

## Optinal Build ARGs

* `swupd_args` specifies
  [swupd update](https://clearlinux.org/documentation/clear-linux/guides/maintenance/swupd-guide#perform-a-manual-update)
  flags passed to the update during build.

# Pulling from Dockerhub
---------------------------

```
docker pull clearlinux/dlaas
docker pull clearlinux/dlaas-mkl
```

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#/arg
