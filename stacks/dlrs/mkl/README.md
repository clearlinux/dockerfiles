## Deep Learning Reference Stack with Intel® MKL-DNN

[![](https://images.microbadger.com/badges/image/clearlinux/stacks-dlrs-mkl.svg)](http://microbadger.com/images/clearlinux/stacks-dlrs-mkl "Get your own image badge on microbadger.com")

The Deep Learning Reference Stack, an integrated, highly-performant open source
stack optimized for Intel® Xeon® Scalable platforms. This open source community
release is part of our effort to ensure AI developers have easy access to all
of the features and functionality of the Intel platforms.  The Deep Learning
Reference Stack is highly-tuned and built for cloud native environments. With
this release, we are enabling developers to quickly prototype by reducing the
complexity associated with integrating multiple software components, while
still giving users the flexibility to customize their solutions.

### Building Locally

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg

```
docker build --no-cache -t clearlinux/stacks-dlrs-mkl .
```

### Optional Build ARGs

* `swupd_args` specifies [swupd update](https://clearlinux.org/documentation/clear-linux/guides/maintenance/swupd-guide#perform-a-manual-update) flags passed to the update during build.
