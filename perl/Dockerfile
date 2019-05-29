FROM clearlinux:latest
MAINTAINER qi.zheng@intel.com

ARG swupd_args

RUN swupd update --no-boot-update $swupd_args
RUN swupd bundle-add perl-extras $swupd_args \
	&& rm -rf /var/lib/swupd/*

WORKDIR /root

CMD ["perl5.28.2","-de0"]
