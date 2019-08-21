## Deep Learning Reference Stack with Pytorch and Intel® MKL-DNN

[![](https://images.microbadger.com/badges/image/clearlinux/stacks-pytorch-mkl.svg)](https://microbadger.com/images/clearlinux/stacks-pytorch-mkl "Get your own image badge on microbadger.com")

### Building Locally

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg

>NOTE: This command is for locally building this image alone.

```
docker build --no-cache --build-arg clear_ver="30650" -t clearlinux/stacks-tensorflow-oss .
```

### Build ARGs

* `clear_ver` specifies the latest validated Clearlinux version for this DLRS Dockerfile.
>NOTE: Changing this version may result in errors, if you want to upgrade the OS version, you should use `swupd_args` instead.

* `swupd_args` specifies [swupd update](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags passed to the update during build.

>NOTE: An empty `swupd_args` will default to 30650. Consider this when building as an OS upgrade won't be performed. If you'd like to upgrade the OS version, you can either do it manually inside a running container or add `swupd_args="<desired version>"` to the build command. The latest validated version is 30650, using a different one might result in unexpected errors.
