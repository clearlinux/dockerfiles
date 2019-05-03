# MKL version of Pytorch on Clear OS
FROM clearlinux
LABEL maintainer=otc-swstacks@intel.com

ARG PYTHON_VERSION=3.7.1
ARG MINICONDA_VERSION=4.5.12
ARG swupd_args
ENV PATH /opt/conda/bin:$PATH

# update os and add pkgs
RUN swupd update $swupd_args && \
    swupd bundle-add which git \
    devpkg-opencv openssh-server \
    sysadmin-basic devpkg-openmpi

# install miniconda and necessary build packages
ADD https://repo.continuum.io/miniconda/Miniconda3-$MINICONDA_VERSION-Linux-x86_64.sh  /tmp/miniconda.sh
RUN chmod +x /tmp/miniconda.sh && \
    /tmp/miniconda.sh -b -p /opt/conda && \
    conda install -c anaconda -y python=$PYTHON_VERSION \
    pip=18.1 \
    setuptools=40.6.3 \
    six=1.12.0 \
    numpy=1.16.2 \
    pyyaml=5.1 \
    mkl=2019.1 \
    mkl-include=2019.1 \
    cython=0.29.6 \
    typing=3.6.4  \
    ninja=1.9.0

RUN conda install -c conda-forge -y \
    gcc=4.8.5 \
    libgcc=7.2.0

#fix from:https://github.com/ContinuumIO/anaconda-issues/issues/5191
RUN \
    cd /opt/conda/lib && \
    ln -sf libstdc++.so.6.0.25 libstdc++.so && \
    ln -sf libstdc++.so.6.0.25 libstdc++.so.6

# clone and build pytorch with
RUN mv /opt/conda/compiler_compat/ld /opt/conda/compiler_compat/ld.orig
RUN cd /tmp && git clone https://github.com/pytorch/pytorch.git
WORKDIR /tmp/pytorch
RUN git checkout 4ac91b2 &&\
    git submodule update --init
RUN CMAKE_PREFIX_PATH="$(dirname $(which conda))/../" \
    BUILD_ONNX_PYTHON=ON \
    USE_OPENMP=ON \
    pip install -v .

# torchvision and jupyter
RUN pip --no-cache-dir install \
    torchvision==0.2.2 \
    jupyterlab==0.35.4 \
    jupyterhub==0.9.4 \
    ipython==7.4.0 \
    ipykernel==5.1.0 && \
    python -m ipykernel install --user

# install horovod
RUN HOROVOD_WITH_TORCH=1 pip install --no-cache-dir horovod==0.16.0
RUN mv /opt/conda/compiler_compat/ld.orig /opt/conda/compiler_compat/ld


# setup onnx and helper packages for caffe2
RUN conda install -c conda-forge -c anaconda -y \
    onnx=1.4.1
RUN pip --no-cache-dir install \
    future==0.17.1 \
    hypothesis==4.14.0 \
    protobuf==3.7.0 \
    networkx==2.2 \
    opencv-python==4.0.0.21

# clean up and init
RUN conda clean -typsy &&\
    rm -fr /tmp/*
WORKDIR /workspace
RUN chmod -R a+w /workspace &&\
    echo "export PATH=$PATH" >> ~/.bashrc
CMD /bin/bash && source ~/.bashrc
