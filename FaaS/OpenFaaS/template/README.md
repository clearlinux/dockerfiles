# OpenFaaS template based on Clear Linux* OS

## What are these templates

> These templates are all based on the Clear Linux* OS.
> They are from the published container images per the function as below.

* [clearlinux:base](https://hub.docker.com/_/clearlinux)
* [clearlinux/python](https://hub.docker.com/r/clearlinux/python)
* [clearlinux/golang](https://hub.docker.com/r/clearlinux/golang)
* [clearlinux/node](https://hub.docker.com/r/clearlinux/node)

## Why use these templates

<!-- CL introduction -->
> [Clear Linux* OS](https://clearlinux.org/) is an open source, rolling release
> Linux distribution optimized for performance and security, from the Cloud to
> the Edge, designed for customization, and manageability.

Clear Linux* OS based container images use:
* Optimized libraries that are compiled with latest compiler versions and
  flags.
* Software packages that follow upstream source closely and update frequently.
* An aggressive security model and best practices for CVE patching.
* A multi-staged build approach to keep a reduced container image size.
* The same container syntax as the official images to make getting started
  easy. 

Therefore, template based on Clear Linux* OS could get above benefits as well.


## How to use the template

Assume you already had deployed workable OpenFaaS on top of Kubernetes.

Steps could refer to

[deployment-guide-for-kubernetes](https://docs.openfaas.com/deployment/kubernetes/#deployment-guide-for-kubernetes)

[OpenFaaS workshop](https://github.com/openfaas/workshop)

### Get Clear Linux based templates

```shell
$ mkdir test && cd test
$ git clone https://github.com/clearlinux/dockerfiles.git
$ cp -r dockerfiles/FaaS/OpenFaaS/template .
```

### For each template how-to, please refer to

* [dockerfile-clearlinux](./dockerfile-clearlinux/README.md)

* [go-clearlinux](./go-clearlinux/README.md)

* [node-clearlinux](./node-clearlinux/README.md)

* [numpy-mp](./numpy-mp/README.md)

* [python3-clearlinux](./python3-clearlinux/README.md)


    
## Proxy and Clear Linux mirror

When working behind a Proxy, you can pass proxy settings to faas-cli commands by "--build-arg".

Also to speed up the Clear Linux bundle install, you could use mirror if you are inside Intel.

For example, 

`faas-cli up --build-arg http_proxy=$http_proxy --build-arg https_proxy=$https_proxy --build-arg swupd_args="-u $mirror --allow-insecure-http" -f hello-openfaas.yml`
