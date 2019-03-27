FROM clearlinux:latest
MAINTAINER bin.yang@intel.com

RUN swupd update $swupd_args && \
    swupd bundle-add nginx $swupd_args
RUN rm -rf /var/lib/swupd

# forward request and error logs to docker log collector
RUN mkdir -p /var/log/nginx
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

RUN mkdir -p /var/lib/nginx/
RUN mkdir -p /etc/nginx/conf.d
RUN cp -f /usr/share/nginx/conf/nginx.conf.example /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

VOLUME /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
