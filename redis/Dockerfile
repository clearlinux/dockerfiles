FROM clearlinux:latest
MAINTAINER qi.zheng@intel.com

RUN swupd update $swupd_args
RUN swupd bundle-add redis-native $swupd_args
RUN rm -rf /var/lib/swupd/*

RUN mkdir /data && chown redis:redis /data
VOLUME /data
WORKDIR /data

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 6379
CMD ["redis-server"]
