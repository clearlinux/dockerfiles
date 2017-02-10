FROM clearlinux
MAINTAINER leoswaldo.macias@intel.com

ARG swupd_args

RUN swupd update $swupd_args
RUN swupd bundle-add database-basic $swupd_args
RUN rm -rf /var/lib/swupd/*

RUN mkdir -p /etc/mariadb
COPY my.cnf /etc/mariadb

RUN mkdir -p /var/lib/mysql
VOLUME /var/lib/mysql

COPY bootstrap.sh /usr/bin
CMD '/usr/bin/bootstrap.sh'

EXPOSE 3306
