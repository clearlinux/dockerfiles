## Deep Learning Reference Stack with Pytorch and Intel® MKL-DNN

[![](https://images.microbadger.com/badges/image/clearlinux/stacks-pytorch-mkl.svg)](https://microbadger.com/images/clearlinux/stacks-pytorch-mkl "Get your own image badge on microbadger.com")

### Building Locally

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg

```
docker build --no-cache -t clearlinux/stacks-pytorch-mkl --build-arg swupd_args="-m 27910" .
```

### Build ARGs

* `swupd_args` specifies [swupd update](https://clearlinux.org/documentation/clear-linux/guides/maintenance/swupd-guide#perform-a-manual-update) flags passed to the update during build.

>NOTE: `swupd_args` defaults so that the Clear Linux OS version is updated to 27910. Upgrading to a later version is not recommended, as further versions have not been validated.
