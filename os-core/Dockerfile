FROM clearlinux:latest AS builder

ARG swupd_args

# Move to latest Clear Linux release
RUN swupd update --no-boot-update $swupd_args

# Install clean os-core bundle in target directory
# using the new os version
RUN source /usr/lib/os-release \
    && mkdir /install_root \
    && swupd os-install -V ${VERSION_ID} \
    --path /install_root --statedir /swupd-state \
    --bundles=os-core --no-scripts \
    && rm -rf /install_root/var/lib/swupd/*

FROM scratch
COPY --from=builder /install_root /
CMD ["/bin/bash"]
