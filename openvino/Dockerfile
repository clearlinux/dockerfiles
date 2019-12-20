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
    --bundles=os-core-update,curl,computer-vision-openvino --no-boot-update

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

WORKDIR /app

# path to save pre-downloaded models
ENV MODEL_DIR="/models"
ENV MO_PATH="/usr/share/openvino/model-optimizer/mo.py"

# MODEL will be used by the container
# If not pre-downloaded, the entrypoint will try download it and set the MODEL_PATH
# ENVs values could be passed by users to dynamically choose model to be used
ENV MODEL_NAME="face-detection-retail-0005"
ENV MODEL_PRECISION="FP32"

# pre-downloaded and converted models for openvino
COPY ./models.txt /app
RUN for m in $(cat /app/models.txt); do \
        model-downloader --name $m -o $MODEL_DIR  && \
        model-converter --name $m -d $MODEL_DIR -o $MODEL_DIR --mo $MO_PATH; \
    done

# Pre-install some python libs for serivce to use
COPY ./requirements.txt /app
RUN pip3 install -r /app/requirements.txt

COPY ./set_model_path.sh /app
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

