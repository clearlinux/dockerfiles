FROM clearlinux:latest
MAINTAINER qi.zheng@intel.com

ARG swupd_args

RUN swupd update $swupd_args \
	&& swupd bundle-add elasticsearch $swupd_args \
	&& rm -rf /var/lib/swupd/*

ENV PATH="/usr/share/elasticsearch/bin:${PATH}"

WORKDIR /usr/share/elasticsearch

RUN set -ex \
	&& for path in \
		/var/data/elasticsearch \
		/var/log/elasticsearch \
		./config \
	; do \
		mkdir -p "$path"; \
		chown -R elasticsearch:elasticsearch "$path"; \
	done

COPY config ./config

VOLUME /var/data/elasticsearch

COPY docker-entrypoint.sh /

EXPOSE 9200 9300
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]
