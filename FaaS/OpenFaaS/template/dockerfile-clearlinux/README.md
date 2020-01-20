This is following part of [OpenFaaS tempalte Readme](https://github.com/clearlinux/dockerfiles/blob/master/FaaS/OpenFaaS/template/README.md). 
This template is based on [clearlinux:base](https://hub.docker.com/_/clearlinux) image.

### dockerfile-clearlinux
1.  Create a function named hello-openfass

`faas-cli new --lang dockerfile-clearlinux hello-openfaas --prefix="<your-docker-username-here>"`

    Files tree as below.
>
    ├── hello-openfaas
    │   ├── bundles.txt
    │   └── Dockerfile
    ├── hello-openfaas.yml
    └── template

    *  Put the required Clear Linux bundles in the "bundles.txt".
    For example,

    `echo "openblas" >> hello-openfaas/bundles.txt`
    `echo "wget" >> hello-openfaas/bundles.txt`

2. Deploy function 

`faas-cli up -f hello-openfaas.yml`

    Then you can invoke your function by OpenFaas UI or faas-cli.

