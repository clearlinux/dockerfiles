CIAO Launcher
=============
[![](https://images.microbadger.com/badges/image/clearlinux/ciao-launcher.svg)](http://microbadger.com/images/clearlinux/ciao-launcher "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/clearlinux/ciao-launcher.svg)](http://microbadger.com/images/clearlinux/launcher "Get your own version badge on microbadger.com")

This provides a CIAO Launcher container

Features
--------
- From source building solution
- Daemon and Manual service start mode
- You mess it, just destroy it and start it again
- Develop on you local development machine and deploy it on container

Build
-----
```
docker build -t clearlinux/ciao-launcher .
```

Or just pull it from Dockerhub
------------------------------
```
docker pull clearlinux/ciao-launcher
```

Start CIAO Launcher container
-----------------------------
### Run in daemon mode
```
docker run -it -d --name launcher --net=host --privileged -v /dev/kvm:/dev/kvm \
    -v /dev:/dev -v /var/run/docker.sock:/var/run/docker.sock \
    --cap-add=NET_ADMIN --device /dev/net/tun:/dev/net/tun \
    -v `pwd`/certs/CAcert-localhost.pem:/etc/pki/ciao/CAcert-ciao-dev.pem \
    -v `pwd`/certs/cert-CNAgent-NetworkingAgent-localhost.pem:/etc/pki/ciao/cert-CNAgent-NetworkingAgent-ciao-dev.pem \
    -v $GOPATH/src/github.com/01org/ciao:/root/go/src/github.com/01org/ciao \
    ciao/launcher
```

### Run on manual mode
```
docker run -it --name launcher --net=host --privileged -v /dev/kvm:/dev/kvm \
    -v /dev:/dev -v /var/run/docker.sock:/var/run/docker.sock \
    --cap-add=NET_ADMIN --device /dev/net/tun:/dev/net/tun \
    -v `pwd`/certs/CAcert-localhost.pem:/etc/pki/ciao/CAcert-ciao-dev.pem \
    -v `pwd`/certs/cert-CNAgent-NetworkingAgent-localhost.pem:/etc/pki/ciao/cert-CNAgent-NetworkingAgent-ciao-dev.pem \
    -v $GOPATH/src/github.com/01org/ciao:/root/go/src/github.com/01org/ciao \
    ciao/launcher bash

# Inside container
root@example.com # ls
ciaorc  go  launcher.sh share

# Manual Start of Ciao Launcher
root@example.com # ./launcher.sh
```

Environment Variables
---------------------


Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://clearlinux.org/documentation/swupdate_how_to_run_the_updater.html) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#/arg
