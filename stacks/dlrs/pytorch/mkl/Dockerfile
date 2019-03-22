# MKL version of Pytorch on Clear OS
FROM clearlinux
LABEL maintainer=otc-swstacks@intel.com

ARG PYTHON_VERSION=3.7.1
ARG MINICONDA_VERSION=4.5.12
ARG HOROVOD_VERSION=0.16.0
ARG MKL_VERSION=2019.1
ARG swupd_args
ENV PATH /opt/conda/bin:$PATH

# update os and add pkgs
RUN swupd update $swupd_args && \
    swupd bundle-add which git devpkg-opencv openssh-server sysadmin-basic devpkg-openmpi

# install miniconda and necessary build packages
ADD https://repo.continuum.io/miniconda/Miniconda3-$MINICONDA_VERSION-Linux-x86_64.sh  /tmp/miniconda.sh
RUN chmod +x /tmp/miniconda.sh && \
    /tmp/miniconda.sh -b -p /opt/conda && \
    conda install -y python=$PYTHON_VERSION \
    numpy pyyaml scipy ipython mkl=${MKL_VERSION} mkl-include=${MKL_VERSION} cython typing && \
	conda install -y gcc libgcc -c conda-forge
RUN pip --no-cache-dir install ninja

# clone and build pytorch with
RUN mv /opt/conda/compiler_compat/ld /opt/conda/compiler_compat/ld.orig
RUN cd /tmp && git clone https://github.com/pytorch/pytorch.git
WORKDIR /tmp/pytorch
# includes patches for optimized ideep backend for inference
RUN git checkout 4ac91b2 &&\
    git submodule update --init
RUN CMAKE_PREFIX_PATH="$(dirname $(which conda))/../" \
    BUILD_ONNX_PYTHON=ON \
    USE_OPENMP=ON \
    pip install -v .

# install horovod and additional python packages for vision an notebook
RUN pip --no-cache-dir install torchvision
RUN pip --no-cache-dir install ipython ipykernel jupyter && \
    python -m ipykernel.kernelspec
RUN HOROVOD_WITH_TORCH=1 pip install --no-cache-dir horovod==${HOROVOD_VERSION}
RUN mv /opt/conda/compiler_compat/ld.orig /opt/conda/compiler_compat/ld


# setup onnx and helper packages for caffe2
RUN conda install -y -c conda-forge onnx && \
    conda install libgcc=5.2.0 && \
    pip install --no-cache-dir future \
    hypothesis protobuf networkx opencv-python

#fix from:https://github.com/ContinuumIO/anaconda-issues/issues/5191
RUN \
    cd /opt/conda/lib && \
    ln -sf libstdc++.so.6.0.25 libstdc++.so && \
    ln -sf libstdc++.so.6.0.25 libstdc++.so.6

# clean up and init
RUN conda clean -typsy
RUN rm -fr /tmp/*
WORKDIR /workspace
RUN chmod -R a+w /workspace
RUN echo "export PATH=$PATH" >> ~/.bashrc
CMD /bin/bash && source ~/.bashrc
