This is following part of [OpenFaaS tempalte Readme](https://github.com/clearlinux/dockerfiles/blob/master/FaaS/OpenFaaS/template/README.md). 
This template is based on [clearlinux/numpy-mp](https://hub.docker.com/r/clearlinux/numpy-mp) container image. Python version is 3.8.
It can leverage AVX512 advantage and set OMP_NUM_THREADS dynamically at runtime to accelerate performance according to assigned computing resources.

### numpy-clearlinux
1.  Create a function named numpy-openfass

`faas-cli new --lang numpy-mp numpy-openfaas --prefix="<your-docker-username-here>"`

    Files tree as below.
>
    ├── numpy-openfaas
    │   ├── bundles.txt
    │   ├── handler.py
    │   ├── helper_script.sh
    │   ├── main.py
    │   ├── numpy-entry.sh
    │   ├── requirements.txt
    │   └── set-num-threads.sh
    ├── numpy-openfaas.yml
    └── template

    *  Put the required python packages in the "requirements.txt".
    For example,

    `echo "redis" >> numpy-openfaas/requirements.txt`
    `echo "flask" >> numpy-openfaas/requirements.txt`

    *  Put the required Clear Linux bundles in the "bundles.txt".
    For example,

    `echo "openblas" >> numpy-openfaas/bundles.txt`
    `echo "wget" >> numpy-openfaas/bundles.txt`

    *  Put any initial/helper operation in the "help_script.sh"

    *  Entry is "handler.py", do any change you want here.

2.  Deploy function

`faas-cli up -f numpy-openfaas.yml`

    Then you can invoke your python function by OpenFaas UI or faas-cli.
