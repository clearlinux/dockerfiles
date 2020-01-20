This is following part of [OpenFaaS tempalte Readme](https://github.com/clearlinux/dockerfiles/blob/master/FaaS/OpenFaaS/template/README.md). 
This template is based on [clearlinux/node:12](https://hub.docker.com/r/clearlinux/node) container image.

### node-clearlinux
1.  Create a function named node-openfass

`faas-cli new --lang node-clearlinux node-openfaas --prefix="<your-docker-username-here>"`

    Files tree as below.
>
    ├── node-openfaas
    │   ├── bundles.txt
    │   ├── handler.js
    │   └── package.json
    ├── node-openfaas.yml
    └── template

    *  The entry is "handler.js", do any change you want in this file.

    *  Put the required Clear Linux bundles in the "bundles.txt".
    For example,

    `echo "openblas" >> node-openfaas/bundles.txt`
    `echo "wget" >> node-openfaas/bundles.txt`

2. Deploy function 

`faas-cli up -f node-openfaas.yml`

    Then you can invoke your node function by OpenFaas UI or faas-cli.

