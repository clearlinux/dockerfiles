#--------------------------------------------------------------------
# Base image to build MKL version of Pytorch on ClearLinux OS
#--------------------------------------------------------------------
ARG clear_ver
FROM stacks-clearlinux:$clear_ver as base
LABEL maintainer=otc-swstacks@intel.com
# FIXME: Until Moby finds a way for saving ARGs in multi-stage builds (see https://github.com/moby/moby/issues/34129)
# we have to re-declare clear_ver
ARG clear_ver
ARG swupd_args=$clear_ver
# update os and add pkgs
RUN swupd update -m $swupd_args && swupd bundle-add wget \
    openssh-server devpkg-openmpi git which \
    && rm -rf /var/lib/swupd/*
# copy and execute installation scripts
COPY ./scripts /scripts
RUN cd /scripts \
  && ./install_conda.sh \
  && ./install_torch_deps.sh \ 
  && ./install_pytorch.sh \
  && ./install_torchvision.sh \
  && ./install_utils.sh \
  && cd / && rm -rf /scripts \
  && rm -rf /opt/conda/pkgs/mkl*

# cv2 deps
RUN /opt/conda/bin/conda install -y -c conda-forge \
    xorg-libsm xorg-libxrender \
    xorg-libxext xorg-libxau \
    && mv /opt/conda/compiler_compat/ld /opt/conda/compiler_compat/ld.orig \
    && /opt/conda/bin/conda clean -afy \
    && rm -f /opt/conda/bin/ffmpeg \
    && rm -f /opt/conda/bin/jasper \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.pyc' -delete \
    && find /opt/conda/ -follow -type f -name '*.js.map' -delete
#--------------------------------------------------------------------
# Pytorch CPU on ClearLinux
#--------------------------------------------------------------------
ARG clear_ver
FROM stacks-clearlinux:$clear_ver
LABEL maintainer=otc-swstacks@intel.com
ARG clear_ver
ARG swupd_args=$clear_ver
# update os and add pkgs
RUN swupd update -m $swupd_args && swupd bundle-add  \
    openssh-server openmpi git sysadmin-basic devpkg-gperftools \
    && rm -rf /var/lib/swupd/* \
    && ln -s /usr/lib64/libtcmalloc.so /usr/lib/libtcmalloc.so

COPY --from=base /opt/conda/ /opt/conda
#init
WORKDIR /workspace
COPY ./scripts/generate_defaults.py /workspace
RUN echo "export PATH=/opt/conda/bin:$PATH" >> /.bashrc \
    && echo "export LD_LIBRARY_PATH=/usr/lib64:/opt/conda/lib" >> /.bashrc \
    && /opt/conda/bin/python generate_defaults.py --generate \
    && cat mkl_env.sh >> /.bashrc \
    && chmod -R a+w /workspace 
SHELL ["/bin/bash",  "-c",  "source /.bashrc"]
