FROM clearlinux:latest
MAINTAINER qi.zheng@intel.com

ARG swupd_args

RUN swupd update $swupd_args \
	&& swupd bundle-add memcached $swupd_args \
	&& rm -rf /var/lib/swupd/*

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 11211
CMD ["memcached"]
