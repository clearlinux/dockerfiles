FROM clearlinux:latest
MAINTAINER william.douglas@intel.com

ARG swupd_args

RUN swupd update --no-boot-update $swupd_args
RUN swupd bundle-add postgresql $swupd_args \
	&& rm -rf /var/lib/swupd/*

ENV PGDATA /var/lib/pgsql/data
RUN mkdir -p /run/postgresql && chown -R postgres:postgres /run/postgresql
RUN mkdir -p "$PGDATA" && chown -R postgres:postgres "$PGDATA"
VOLUME /var/lib/pgsql/data

RUN mkdir -p /usr/local/bin
COPY bootstrap.sh /usr/local/bin
ENTRYPOINT ["bootstrap.sh"]

EXPOSE 5432
CMD ["postgres"]
