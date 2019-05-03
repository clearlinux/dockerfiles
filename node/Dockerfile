FROM clearlinux:latest
MAINTAINER jianjun.liu@intel.com

ARG swupd_args

RUN swupd update $swupd_args \
	&& swupd bundle-add nodejs-basic $swupd_args \
	&& rm -rf /var/lib/swupd/*

RUN /usr/bin/ldconfig

CMD ["node"]
