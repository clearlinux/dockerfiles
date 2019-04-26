FROM clearlinux:latest
MAINTAINER sophia.gong@intel.com

ARG swupd_args

RUN swupd update $swupd_args && \
    swupd bundle-add haproxy $swupd_args
RUN rm -rf /var/lib/swupd

RUN mkdir -p /usr/local/etc/haproxy
STOPSIGNAL SIGUSR1

COPY docker-entrypoint.sh /
COPY haproxy.cfg /usr/local/etc/haproxy

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]
