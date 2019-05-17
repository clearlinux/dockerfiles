FROM clearlinux:latest
MAINTAINER long1.wang@intel.com

ARG swupd_args

RUN swupd update --no-boot-update $swupd_args && \
    swupd bundle-add openstack-common $swupd_args && \
    rm -rf /var/lib/swupd

EXPOSE 4369 5671 5672 25672
CMD ["rabbitmq-server"]
