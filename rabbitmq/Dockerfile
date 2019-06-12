FROM clearlinux:latest
MAINTAINER long1.wang@intel.com

ARG swupd_args

RUN swupd update --no-boot-update $swupd_args && \
    swupd bundle-add openstack-common $swupd_args && \
    rm -rf /var/lib/swupd && \
    mkdir -p /etc/rabbitmq && \
    chown rabbitmq:rabbitmq /etc/rabbitmq && \
    ln -s /usr/lib/rabbitmq-server/sbin/cuttlefish /usr/bin/

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 4369 5671 5672 25672
CMD ["rabbitmq-server"]
