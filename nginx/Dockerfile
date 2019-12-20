FROM clearlinux:latest AS builder

ARG swupd_args
# Move to latest Clear Linux release to ensure
# that the swupd command line arguments are
# correct
RUN swupd update --no-boot-update $swupd_args

# Grab os-release info from the minimal base image so
# that the new content matches the exact OS version
COPY --from=clearlinux/os-core:latest /usr/lib/os-release /

# Install additional content in a target directory
# using the os version from the minimal base
RUN source /os-release && \
    mkdir /install_root \
    && swupd os-install -V ${VERSION_ID} \
    --path /install_root --statedir /swupd-state \
    --bundles=nginx-mainline --no-boot-update

# For some Host OS configuration with redirect_dir on,
# extra data are saved on the upper layer when the same
# file exists on different layers. To minimize docker
# image size, remove the overlapped files before copy.
RUN mkdir /os_core_install
COPY --from=clearlinux/os-core:latest / /os_core_install/
RUN cd / && \
    find os_core_install | sed -e 's/os_core_install/install_root/' | xargs rm -d &> /dev/null || true

FROM clearlinux/os-core:latest

COPY --from=builder /install_root /
COPY default.conf /etc/nginx-mainline/conf.d/default.conf

# create directories for nginx-mainline
RUN mkdir -p /var/www/html && \
    mkdir -p /etc/nginx-mainline && \
    mkdir -p /var/log/nginx-mainline && \
    mkdir -p /var/lib/nginx-mainline/uwsgi && \
    mkdir -p /var/lib/nginx-mainline/client-body && \
    mkdir -p /var/lib/nginx-mainline/proxy && \
    mkdir -p /var/lib/nginx-mainline/fast-cgi && \
    # add links to make it compatible with general name nginx
    ln -sf /var/log/nginx-mainline /var/log/nginx && \
    ln -sf /var/lib/nginx-mainline /var/lib/nginx && \
    ln -sf /etc/nginx-mainline /etc/nginx && \
    ln -sf /usr/bin/nginx-mainline /usr/bin/nginx && \
    # forward request and error logs to docker log collector
    ln -sf /dev/stdout /var/log/nginx-mainline/access.log && \
    ln -sf /dev/stderr /var/log/nginx-mainline/error.log && \
    cp -f /usr/share/nginx-mainline/conf/nginx.conf.example /etc/nginx-mainline/nginx.conf && \
    cp -f /usr/share/nginx-mainline/html/* /var/www/html/

EXPOSE 80
STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
