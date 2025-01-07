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
    --bundles=mixer,go-basic,c-basic,os-core-update-dev,sudo --no-boot-update

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

RUN useradd -G wheelnopw clr && mkdir -p /run/lock

ENV GOPATH /home/clr/go
ENV PATH="/home/clr/go/bin:${PATH}"

USER clr
RUN git config --global user.email "travis@example.com" && \
    git config --global user.name "Travis CI"
