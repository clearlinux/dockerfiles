FROM clearlinux/php-fpm

VOLUME /var/www/html

ENV WORDPRESS_VERSION 5.4.2
ENV WORDPRESS_SHA1 e5631f812232fbd45d3431783d3db2e0d5670d2d

RUN set -ex; \
    curl -o wordpress.tar.gz -fSL "https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz"; \
    echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c -; \
    # upstream tarballs include ./wordpress/ so this gives us /usr/src/wordpress
    tar -xzf wordpress.tar.gz -C /usr/src/; \
    rm wordpress.tar.gz; \
    chown -R httpd:httpd /usr/src/wordpress

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
