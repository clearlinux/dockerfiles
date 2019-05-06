FROM clearlinux:latest
MAINTAINER long1.wang@intel.com

ARG swupd_args

RUN swupd update --no-boot-update $swupd_args && \
    swupd bundle-add iperf $swupd_args

# Define default command
ENTRYPOINT ["iperf3"]

# Expose ports
EXPOSE 5201
