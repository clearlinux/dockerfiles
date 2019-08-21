# OSS version of Pytorch on Clear OS
ARG clear_ver
FROM stacks-clearlinux:$clear_ver
LABEL maintainer=otc-swstacks@intel.com

# FIXME: Until Moby finds a way for saving ARGs in multi-stage builds (see https://github.com/moby/moby/issues/34129)
# we have to re-declare clear_ver
ARG clear_ver
ARG swupd_args=$clear_ver

# update os and install pytorch
RUN swupd update -m $swupd_args && \
    swupd bundle-add devpkg-openmpi \
    devpkg-libpng desktop-gnomelibs \
    openssh-server \
    sysadmin-basic \
    devpkg-gperftools \
    machine-learning-pytorch \
    git user-basic-dev \ 
    && ln -s /usr/lib64/libtcmalloc.so /usr/lib/libtcmalloc.so

# install additional python packages for vision, horovod and notebook
RUN pip --no-cache-dir install torchvision
RUN pip --no-cache-dir install ipython ipykernel jupyter && \
    python -m ipykernel.kernelspec
RUN HOROVOD_WITH_TORCH=1 pip install --no-cache-dir horovod

# setup onnx and helper packages for caffe2
RUN pip install --no-cache-dir \
    future hypothesis protobuf onnx networkx opencv-python

# clean up and init
WORKDIR /workspace
RUN chmod -R a+w /workspace
CMD /bin/bash
