FROM clearlinux:latest
MAINTAINER qi.zheng@intel.com

ARG swupd_args="--no-boot-update $swupd_args"

RUN swupd update $swupd_args \
	&& swupd bundle-add httpd $swupd_args \
	&& rm -rf /var/lib/swupd/*

#default configuration on /usr/share/defaults/httpd/httpd.conf
#create folder for default DocumentRoot and LOG/PidFile path
RUN mkdir -p /var/www/html \
	&& mkdir -p /var/log/httpd \
	&& mkdir -p /run/httpd \
	&& mkdir -p /usr/local/bin

COPY index.html /var/www/html/
COPY httpd-foreground /usr/local/bin/
RUN chmod +x /usr/local/bin/httpd-foreground

EXPOSE 80
CMD ["httpd-foreground"]
