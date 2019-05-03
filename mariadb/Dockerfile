FROM clearlinux:latest
MAINTAINER qi.zheng@intel.com

ARG swupd_args

RUN swupd update $swupd_args \
	&& swupd bundle-add mariadb $swupd_args \
	&& rm -rf /var/lib/swupd/*

RUN mkdir /docker-entrypoint-initdb.d
RUN set -ex; \
	rm -rf /var/lib/mysql; \
	mkdir -p /var/lib/mysql /var/run/mariadb /etc/mariadb; \
	chown -R mysql:mysql /var/lib/mysql /var/run/mariadb; \
	chmod 777 /var/run/mariadb; 

VOLUME /var/lib/mysql

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
COPY my.cnf /etc/mariadb/

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]
