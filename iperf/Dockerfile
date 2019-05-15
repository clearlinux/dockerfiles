FROM clearlinux:latest
MAINTAINER long1.wang@intel.com

ARG swupd_args

RUN swupd update --no-boot-update $swupd_args
RUN swupd bundle-add iperf $swupd_args \
	&& rm -rf /var/lib/swupd/*

# Define default command
ENTRYPOINT ["iperf3"]

# Expose ports
EXPOSE 5201
