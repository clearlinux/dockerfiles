FROM clearlinux:latest
MAINTAINER qi.zheng@intel.com

ARG swupd_args

RUN swupd update --no-boot-update $swupd_args
RUN swupd bundle-add elasticsearch $swupd_args \
	&& rm -rf /var/lib/swupd/*

RUN set -ex \
	&& for path in \
		/var/data/elasticsearch \
		/var/log/elasticsearch \
		/etc/elasticsearch \
	; do \
		mkdir -p "$path"; \
		chown -R elasticsearch:elasticsearch "$path"; \
	done

COPY config /etc/elasticsearch
COPY docker-entrypoint.sh /

VOLUME /var/data/elasticsearch

EXPOSE 9200 9300
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["-Epath.conf=/etc/elasticsearch/"]
