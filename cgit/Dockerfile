FROM clearlinux/httpd

ARG swupd_args
RUN swupd update --no-boot-update $swupd_args
RUN swupd bundle-add sudo curl scm-server $swupd_args \
	&& rm -rf /var/lib/swupd/*

COPY cgitrc /etc/cgitrc
COPY httpd-cgit.conf /etc/httpd/conf.d/httpd-cgit.conf
