Based on clearlinux/python:3 container image.
Current version is 3.8.

### python3-clearlinux
1.  `faas-cli new --lang python3-clearlinux hello-openfaas --prefix="<your-docker-username-here>"`

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

    `echo "redis" >> hello-openfaas/requirements.txt`
    `echo "flask" >> hello-openfaas/requirements.txt`

    *  Put the required Clear Linux bundles in the "bundles.txt".
    For example,

    `echo "openblas" >> hello-openfaas/bundles.txt`
    `echo "wget" >> hello-openfaas/bundles.txt`

    *  Put any initial/helper operation in the "help_script.sh"

2.  `faas-cli up -f hello-openfaas.yml`

    Then you can invoke your python function by OpenFaas UI or faas-cli.
