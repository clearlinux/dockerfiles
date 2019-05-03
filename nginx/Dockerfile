FROM clearlinux:latest
MAINTAINER bin.yang@intel.com

ARG swupd_args="--no-boot-update $swupd_args"

COPY default.conf /etc/nginx/conf.d/default.conf

RUN swupd update --no-boot-update $swupd_args && \
    swupd bundle-add nginx $swupd_args && \
    rm -rf /var/lib/swupd && \
    mkdir -p /var/log/nginx && \
    # forward request and error logs to docker log collector
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    mkdir -p /var/lib/nginx/ && \
    cp -f /usr/share/nginx/conf/nginx.conf.example /etc/nginx/nginx.conf


VOLUME /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
