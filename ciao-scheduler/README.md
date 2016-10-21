CIAO Scheduler
==============
[![](https://images.microbadger.com/badges/image/clearlinux/ciao-scheduler.svg)](http://microbadger.com/images/clearlinux/ciao-scheduler "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/clearlinux/ciao-scheduler.svg)](http://microbadger.com/images/clearlinux/scheduler "Get your own version badge on microbadger.com")

This provides a CIAO Scheduler container

Features
--------
- From source building solution
- Daemon and Manual service start mode
- You mess it, just destroy it and start it again
- Develop on you local development machine and deploy it on containers.
- No data/binary copies, everything can be accesible from container

Build
-----
```
    docker build -t clearlinux/ciao-scheduler .
```

Or just pull it from Dockerhub
------------------------------
```
    docker pull clearlinux/ciao-scheduler
```

Pre-requirements
----------------
Before launching scheduler, take a look on [CIAO on top of Docker containers for development]()

Start CIAO Scheduler container
-----------------------------
### Run in daemon mode
```
export YOUR_HOST=localhost
docker run -d -it -v --name ciao-scheduler --net=host -v `pwd`/certs/CAcert-$YOUR_HOST.pem:/etc/pki/ciao/CAcert-ciao-dev.pem \
       -v `pwd`/certs/cert-Scheduler-$YOU_HOST.pem:/etc/pki/ciao/cert-Scheduler-ciao-dev.pem \
       -e IDENTITY_HOST=$YOUR_HOST \
       -v $GOPATH/src/github.com/01org/ciao:/root/go/src/github.com/01org/ciao \
       ciao/scheduler
```

### Run on manual mode
```
export YOUR_HOST=localhost
docker run -d -it -v --name ciao-scheduler --net=host -v `pwd`/certs/CAcert-$YOUR_HOST.pem:/etc/pki/ciao/CAcert-ciao-dev.pem \
       -v `pwd`/certs/cert-Scheduler-$YOU_HOST.pem:/etc/pki/ciao/cert-Scheduler-ciao-dev.pem \
       -e IDENTITY_HOST=$YOUR_HOST \
       -v $GOPATH/src/github.com/01org/ciao:/root/go/src/github.com/01org/ciao \
       ciao/scheduler bash

# Inside container
root@example.com # ls
ciaorc  go  scheduler.sh share

# Manual Start of Ciao Scheduler
root@example.com # ./scheduler.sh
```

### Getting CIAO Scheduler logs from docker
```
docker logs -f ciao-scheduler
```

Environment Variables
---------------------
- ``IDENTITY_HOST`` Specifies the Keystone URL. Example: example.com

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://clearlinux.org/documentation/swupdate_how_to_run_the_updater.html) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#/arg
