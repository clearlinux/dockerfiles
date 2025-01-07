This is following part of [OpenFaaS tempalte Readme](https://github.com/clearlinux/dockerfiles/blob/master/FaaS/OpenFaaS/template/README.md). 
This template is based on [clearlinux/python:3](https://hub.docker.com/r/clearlinux/python) container image. Python version is 3.8.

### python3-clearlinux
1.  Create a function named hello-openfass

`faas-cli new --lang python3-clearlinux hello-openfaas --prefix="<your-docker-username-here>"`

    Files tree as below.
>
    ├── hello-openfaas
    │   ├── bundles.txt
    │   ├── handler.py
    │   ├── helper_script.sh
    │   ├── __init__.py
    │   └── requirements.txt
    ├── hello-openfaas.yml
    └── template

    *  Put the required python packages in the "requirements.txt".
    For example,

    `echo "valkey" >> hello-openfaas/requirements.txt`
    `echo "flask" >> hello-openfaas/requirements.txt`

    *  Put the required Clear Linux bundles in the "bundles.txt".
    For example,

    `echo "openblas" >> hello-openfaas/bundles.txt`
    `echo "wget" >> hello-openfaas/bundles.txt`

    *  Put any initial/helper operation in the "help_script.sh"

2.  Deploy function

`faas-cli up -f hello-openfaas.yml`

    Then you can invoke your python function by OpenFaas UI or faas-cli.
