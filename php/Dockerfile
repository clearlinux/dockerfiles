FROM clearlinux:latest
MAINTAINER jianjun.liu@intel.com

ARG swupd_args

RUN swupd update --no-boot-update $swupd_args
RUN swupd bundle-add php-basic $swupd_args \
	&& rm -rf /var/lib/swupd/*

CMD ["php","-a"]
