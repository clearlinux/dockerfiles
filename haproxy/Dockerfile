FROM clearlinux:latest
MAINTAINER sophia.gong@intel.com

ARG swupd_args

RUN swupd update --no-boot-update $swupd_args

RUN swupd bundle-add haproxy $swupd_args \
    && rm -rf /var/lib/swupd \
    && mkdir -p /usr/local/etc/haproxy

STOPSIGNAL SIGUSR1

COPY docker-entrypoint.sh /
COPY haproxy.cfg /usr/local/etc/haproxy

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]
