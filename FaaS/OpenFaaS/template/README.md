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

### dockerfile-clearlinux
1.  `mkdir test && cd test`
2.  `cp -r "<your-dockerfiles-path>"/FaaS/OpenFaaS/template/. template/`
3.  `faas-cli new --lang dockerfile-clearlinux hello-dockerfile --prefix="<your-docker-username-here>"`

    Files tree as below.
>
    ├── hello-dockerfile
    │   ├── bundles.txt
    │   └── Dockerfile
    ├── hello-dockerfile.yml

    *  Put the required Clear Linux bundles in the "bundles.txt".
    For example,

    `echo "openblas" >> hello-dockerfile/bundles.txt`
    `echo "wget" >> hello-dockerfile/bundles.txt`
4.  Replace the "cat" in the Dockerfile line below per your requirement.
    ENV fprocess="cat"
5.  `faas-cli up -f hello-dockerfile.yml`

    Then you can invoke your python function by OpenFaas UI or faas-cli.

### python3-clearlinux
1.  `mkdir test && cd test`
2.  `cp -r "<your-dockerfiles-path>"/FaaS/OpenFaaS/template/. template/`
3.  `faas-cli new --lang python3-clearlinux hello-openfaas --prefix="<your-docker-username-here>"`

    Files tree as below.
>  
    ├── hello-openfaas
    │   ├── bundles.txt
    │   ├── handler.py
    │   ├── __init__.py
    │   └── requirements.txt
    ├── hello-openfaas.yml
    └── template


    *  Put the required python packages in the "requirements.txt".
    For example,

    `echo "redis" >> hello-openfaas/requirements.txt`
    `echo "flask" >> hello-openfaas/requirements.txt`

    *  Put the required Clear Linux bundles in the "bundles.txt".
    For example,

    `echo "openblas" >> hello-openfaas/bundles.txt`
    `echo "wget" >> hello-openfaas/bundles.txt`
4.  `faas-cli up -f hello-openfaas.yml`

    Then you can invoke your python function by OpenFaas UI or faas-cli.
    
### go-clearlinux
1.  mkdir test && cd test
2.  `cp -r "<your-dockerfiles-path>"/FaaS/OpenFaaS/template/. template/`
3.  `faas-cli new --lang go-clearlinux go-openfaas --prefix="<your-docker-username-here>"`

    Files tree as below.
> 
    ├── go-openfaas
    │   ├── handler.go
    ├── go-openfaas.yml
    └── template


    *  Put the required Clear Linux bundles in the "bundles.txt".
    For example,

    `echo "openblas" >> go-openfaas/bundles.txt`
    `echo "wget" >> go-openfaas/bundles.txt`
4.  `faas-cli up -f go-openfaas.yml`

    Then you can invoke your go function by OpenFaas UI or faas-cli.

    
## Proxy and Clear Linux mirror

When working behind a Proxy, you can pass proxy settings to faas-cli commands by "--build-arg".

Also to speed up the Clear Linux bundle install, you could use mirror if you are inside Intel.

For example, 

`faas-cli up --build-arg http_proxy=$http_proxy --build-arg https_proxy=$https_proxy --build-arg swupd_args="-u $mirror --allow-insecure-http" -f hello-openfaas.yml`
