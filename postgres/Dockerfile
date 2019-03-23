FROM clearlinux:latest
MAINTAINER william.douglas@intel.com

RUN swupd update $swupd_args && \
    swupd bundle-add postgresql $swupd_args

ENV PGDATA /var/lib/pgsql/data
RUN mkdir -p /run/postgresql && chown -R postgres:postgres /run/postgresql
RUN mkdir -p "$PGDATA" && chown -R postgres:postgres "$PGDATA"
VOLUME /var/lib/pgsql/data

RUN mkdir -p /usr/local/bin
COPY bootstrap.sh /usr/local/bin
ENTRYPOINT ["bootstrap.sh"]

EXPOSE 5432
CMD ["postgres"]
