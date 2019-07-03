FROM clearlinux/php-fpm
MAINTAINER sophia.gong@intel.com

ARG swupd_args

RUN swupd update $swupd_args && \
    swupd bundle-add curl $swupd_args
RUN rm -rf /var/lib/swupd

RUN set -ex \
	&& { \
		useradd -U www-data; \
		chown -R www-data:www-data /var/www/html; \
		chmod 777 /var/www/html; \
		cd /var/www/html; \
		curl -O https://wordpress.org/latest.tar.gz; \
		tar xzvf latest.tar.gz; \
		mv wordpress/* .; \
		rm latest.tar.gz; \
	}

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
