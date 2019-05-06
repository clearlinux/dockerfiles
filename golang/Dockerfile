FROM clearlinux:latest
MAINTAINER qi.zheng@intel.com

ARG swupd_args

RUN swupd update --no-boot-update $swupd_args
RUN swupd bundle-add go-basic $swupd_args \
	&& rm -rf /var/lib/swupd/*

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH
