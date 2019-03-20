FROM clearlinux:latest
MAINTAINER william.douglas@intel.com

RUN swupd update $swupd_args
RUN swupd bundle-add postgresql $swupd_args

RUN mkdir -p /var/lib/pgsql/data && chown -R postgres:postgres /var/lib/pgsql
VOLUME /var/lib/pgsql/data

RUN mkdir -p /run/postgresql && chown -R postgres:postgres /run/postgresql

RUN mkdir -p /usr/local/bin
COPY bootstrap.sh /usr/local/bin

EXPOSE 5432

CMD bootstrap.sh
