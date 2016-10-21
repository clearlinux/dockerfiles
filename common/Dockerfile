FROM clearlinux
MAINTAINER obed.n.munoz@intel.com

ARG swupd_args

# Setting Environment
RUN mkdir -p /root/share
RUN mkdir -p /root/go/src
RUN mkdir -p /etc/pki/ciao
COPY bashrc /.bashrc
COPY environment /etc/

# update and utilities
RUN swupd update $swupd_args
RUN swupd bundle-add os-core-dev $swupd_args

# CIAO Dependencies
RUN swupd bundle-add go-basic $swupd_args
RUN swupd bundle-add cloud-control  $swupd_args
ENV GOPATH /root/go
ENV GOBIN /root/go/bin
ENV GOPATH $GOPATH:$GOPATH/vendor
RUN go get --insecure -v -u github.com/01org/ciao/... ; exit 0

RUN rm -rf /var/lib/swupd/*

WORKDIR /root

VOLUME '/root/share'

CMD '/usr/sbin/bash'
