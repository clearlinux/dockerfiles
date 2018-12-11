## Deep Learning Reference Stack with Intel® MKL-DNN

[![](https://images.microbadger.com/badges/image/clearlinux/stacks-dlrs-mkl.svg)](http://microbadger.com/images/clearlinux/stacks-dlrs-mkl "Get your own image badge on microbadger.com")

### Building Locally

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg

```
docker build --no-cache -t clearlinux/stacks-dlrs-mkl .
```

### Optional Build ARGs

* `swupd_args` specifies [swupd update](https://clearlinux.org/documentation/clear-linux/guides/maintenance/swupd-guide#perform-a-manual-update) flags passed to the update during build.
