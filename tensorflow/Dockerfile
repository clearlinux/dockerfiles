FROM clearlinux:latest
MAINTAINER jianjun.liu@intel.com

ARG swupd_args

RUN swupd update --no-boot-update $swupd_args
RUN swupd bundle-add machine-learning-tensorflow $swupd_args \
	&& rm -rf /var/lib/swupd/*
