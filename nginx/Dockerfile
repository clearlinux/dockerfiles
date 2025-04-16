ARG clear_ver
FROM ghcr.io/clearlinux/os-core:$clear_ver AS core
FROM clearlinux:latest AS builder

ARG clear_ver
ARG swupd_args
# Move to latest Clear Linux release to ensure
# that the swupd command line arguments are
# correct
RUN swupd update --no-boot-update -V $clear_ver $swupd_args

# Grab os-release info from the minimal base image so
# that the new content matches the exact OS version
COPY --from=core /usr/lib/os-release /

# Install additional content in a target directory
# using the os version from the minimal base
RUN source /os-release && \
    mkdir /install_root \
    && swupd os-install -V ${VERSION_ID} \
    --path /install_root --statedir /swupd-state \
    --bundles=nginx --no-boot-update

# For some Host OS configuration with redirect_dir on,
# extra data are saved on the upper layer when the same
# file exists on different layers. To minimize docker
# image size, remove the overlapped files before copy.
RUN mkdir /os_core_install
COPY --from=core / /os_core_install/
RUN cd / && \
    find os_core_install | sed -e 's/os_core_install/install_root/' | xargs rm -d &> /dev/null || true

FROM core

COPY --from=builder /install_root /
COPY default.conf /etc/nginx/conf.d/default.conf

# create directories for nginx
RUN mkdir -p /var/www/html && \
    mkdir -p /etc/nginx && \
    mkdir -p /var/log/nginx && \
    mkdir -p /var/lib/nginx/uwsgi && \
    mkdir -p /var/lib/nginx/client-body && \
    mkdir -p /var/lib/nginx/proxy && \
    mkdir -p /var/lib/nginx/fast-cgi && \
    # forward request and error logs to docker log collector
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    cp -f /usr/share/nginx/conf/nginx.conf.example /etc/nginx/nginx.conf && \
    cp -f /usr/share/nginx/html/* /var/www/html/

EXPOSE 80
STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
