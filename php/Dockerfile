FROM clearlinux:latest
MAINTAINER jianjun.liu@intel.com

ARG swupd_args="--no-boot-update $swupd_args"

RUN swupd update $swupd_args \
	&& swupd bundle-add php-basic $swupd_args \
	&& rm -rf /var/lib/swupd/*

CMD ["php","-a"]
