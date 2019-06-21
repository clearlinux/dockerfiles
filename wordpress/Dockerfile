FROM clearlinux/php

ARG swupd_args

RUN swupd update $swupd_args && \
    swupd bundle-add curl $swupd_args
RUN rm -rf /var/lib/swupd

WORKDIR /var/www/html

RUN set -ex \
	&& cd /usr/share/defaults/php \
	&& { \
		echo '[global]'; \
		echo 'error_log = /proc/self/fd/2'; \
		echo; echo '; https://github.com/docker-library/php/pull/725#issuecomment-443540114'; echo 'log_limit = 8192'; \
		echo; \
		echo '[www]'; \
		echo '; if we send this to /proc/self/fd/1, it never appears'; \
		echo 'access.log = /proc/self/fd/2'; \
		echo; \
		echo 'clear_env = no'; \
		echo; \
		echo '; Ensure worker stdout and stderr are sent to the main error log.'; \
		echo 'catch_workers_output = yes'; \
		echo 'decorate_workers_output = no'; \
	} | tee php-fpm.d/docker.conf \
	&& { \
		echo '[global]'; \
		echo 'daemonize = no'; \
		echo; \
		echo '[www]'; \
		echo 'listen = 9000'; \
	} | tee php-fpm.d/zz-docker.conf \
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

STOPSIGNAL SIGQUIT

EXPOSE 9000

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
