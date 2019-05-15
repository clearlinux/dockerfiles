FROM clearlinux:latest
MAINTAINER long1.wang@intel.com

ARG swupd_args

RUN swupd update --no-boot-update $swupd_args
RUN swupd bundle-add java-runtime $swupd_args && \
    rm -rf /var/lib/swupd/*

CMD ["java"]
