FROM clearlinux:latest
MAINTAINER hongzhan.chen@intel.com

ARG swupd_args

RUN swupd update --no-boot-update $swupd_args
RUN swupd bundle-add python3-basic $swupd_args \
	&& rm -rf /var/lib/swupd/*

CMD ["python3"]
