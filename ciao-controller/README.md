CIAO Controller
==============
[![](https://images.microbadger.com/badges/image/clearlinux/ciao-controller.svg)](http://microbadger.com/images/clearlinux/ciao-controller "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/clearlinux/ciao-controller.svg)](http://microbadger.com/images/clearlinux/controller "Get your own version badge on microbadger.com")

This provides a CIAO Controller container

Features
--------
- From source building solution
- Daemon and Manual service start mode
- You mess it, just destroy it and start it again
- Develop on you local development machine and deploy it on container

Build
-----
```
docker build -t clearlinux/ciao-controller .
```

Or just pull it from Dockerhub
------------------------------
```
docker pull clearlinux/ciao-controller
```

Pre-requirements
----------------
Before starting ``ciao-controller``, take a look on [CIAO on top of Docker containers for development]()

Start CIAO Controller container
-----------------------------
### Run in daemon mode
```
export YOUR_HOST=localhost
docker run -it -d --name ciao-controller --net=host
       -v `pwd`/certs/CAcert-$YOUR_HOST.pem:/etc/pki/ciao/CAcert-ciao-dev.pem \
       -v `pwd`/certs/cert-Controller-$YOUR_HOST.pem:/etc/pki/ciao/cert-Controller-ciao-dev.pem \
       -v `pwd`/certs/controller_cert.pem:/etc/pki/ciao/controller_cert.pem \
       -v `pwd`/certs/controller_key.pem:/etc/pki/ciao/controller_key.pem \
       -v `pwd`/certs/ciao-image_cert.pem:/etc/pki/ciao/ciao-image_cert.pem \
       -v `pwd`/ciao-keystone_cert.pem:/etc/ca-certs/cacert.pem \
       -e IDENTITY_HOST=$YOUR_HOST -e CONTROLLER_HOST=$YOUR_HOST \
       -v $GOPATH/src/github.com/01org/ciao:/root/go/src/github.com/01org/ciao \
       clearlinux/ciao-controller
```
### Run on manual mode
```
export YOUR_HOST=localhost
docker run -it --name ciao-controller --net=host
       -v `pwd`/certs/CAcert-$YOUR_HOST.pem:/etc/pki/ciao/CAcert-ciao-dev.pem \
       -v `pwd`/certs/cert-Controller-$YOUR_HOST.pem:/etc/pki/ciao/cert-Controller-ciao-dev.pem \
       -v `pwd`/certs/controller_cert.pem:/etc/pki/ciao/controller_cert.pem \
       -v `pwd`/certs/controller_key.pem:/etc/pki/ciao/controller_key.pem \
       -v `pwd`/certs/ciao-image_cert.pem:/etc/pki/ciao/ciao-image_cert.pem \
       -v `pwd`/ciao-keystone_cert.pem:/etc/ca-certs/cacert.pem \
       -e IDENTITY_HOST=$YOUR_HOST -e CONTROLLER_HOST=$YOUR_HOST \
       -v $GOPATH/src/github.com/01org/ciao:/root/go/src/github.com/01org/ciao \
       clearlinux/ciao-controller bash

# Inside container
root@example.com # ls
ciaorc  go  controller.sh share

# Manual Start of Ciao Controller
root@example.com # ./controller.sh
```
### Getting CIAO Scheduler logs from docker
```
docker logs -f ciao-scheduler
```

Environment Variables
---------------------
- ``IDENTITY_HOST`` Specifies the Keystone URL. Example: example.com
- ``CONTROLLER_HOST`` Specifies the CIAO Controller URL. Example: example.com

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://clearlinux.org/documentation/swupdate_how_to_run_the_updater.html) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#/arg
