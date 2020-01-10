Based on clearlinux/golang container image

### go-clearlinux
1.  `faas-cli new --lang go-clearlinux go-openfaas --prefix="<your-docker-username-here>"`

    Files tree as below.
>
    .
    ├── go-openfaas
    │   ├── bundles.txt
    │   └── handler.go
    ├── go-openfaas.yml
    └── template

    *  Put the required Clear Linux bundles in the "bundles.txt".
    For example,

    `echo "openblas" >> go-openfaas/bundles.txt`
    `echo "wget" >> go-openfaas/bundles.txt`
2.  `faas-cli up -f go-openfaas.yml`

    Then you can invoke your go function by OpenFaas UI or faas-cli.
