#---------------------------------------------------------------------
# Base instance to build MKL based Tensorflow on Clear Linux
#---------------------------------------------------------------------
ARG clear_ver
FROM clearlinux/stacks-clearlinux:$clear_ver as base
LABEL maintainer=otc-swstacks@intel.com

# FIXME: Until Moby finds a way for saving ARGs in multi-stage builds (see https://github.com/moby/moby/issues/34129)
# we have to re-declare clear_ver
ARG clear_ver
ARG swupd_args=$clear_ver

# tf with vnni support and bug fixes
ARG TF_COMMIT_SHA=47ab68d265a96b6e7be06afd1b4b47e0114c0ee9
ARG BAZEL_VERSION=0.24.0

# update os and add required bundles
RUN swupd update -m $swupd_args && \
    swupd bundle-add which git devpkg-opencv \
    java-basic zip unzip devpkg-zlib sysadmin-basic \
    python-data-science curl devpkg-openmpi wget package-utils

RUN ln -s -f /usr/bin/pip3.7 /usr/bin/pip
RUN ln -s -f /usr/bin/python3.7 /usr/bin/python

# download and install bazel
RUN mkdir /bazel && \
    cd /bazel && \
    curl -fSsL -O https://github.com/bazelbuild/bazel/releases/download/$BAZEL_VERSION/bazel-$BAZEL_VERSION-dist.zip && \
    unzip bazel-$BAZEL_VERSION-dist.zip && \
    env EXTRA_BAZEL_ARGS="--host_javabase=@local_jdk//:jdk" bash ./compile.sh && \
    cp output/bazel /usr/bin/

RUN pip install \
    keras_applications==1.0.6 \
    keras_preprocessing==1.0.9
# clone build and install tensorflow 1.13.1
WORKDIR /tensorflow_src
RUN git clone https://github.com/tensorflow/tensorflow.git /tensorflow_src && \
    git checkout -b quantized ${TF_COMMIT_SHA}
RUN \
  export PYTHON_BIN_PATH=/usr/bin/python3.7 &&\
  export USE_DEFAULT_PYTHON_LIB_PATH=1 &&\
  export CC_OPT_FLAGS="-march=native -mtune=native"  &&\
  export TF_NEED_JEMALLOC=1  &&\
  export TF_NEED_KAFKA=0 &&\
  export TF_NEED_OPENCL_SYCL=0 &&\
  export TF_NEED_GCP=0 &&\
  export TF_NEED_HDFS=0 &&\
  export TF_NEED_S3=0 &&\
  export TF_ENABLE_XLA=1 &&\
  export TF_NEED_GDR=0 &&\
  export TF_NEED_VERBS=0 &&\
  export TF_NEED_OPENCL=0 &&\
  export TF_NEED_MPI=0 &&\
  export TF_NEED_TENSORRT=0 &&\
  export TF_SET_ANDROID_WORKSPACE=0 &&\
  export TF_DOWNLOAD_CLANG=0 &&\
  export TF_NEED_CUDA=0 &&\
  export TF_BUILD_MAVX=MAVX512 &&\
  export HTTP_PROXY=`echo $http_proxy | sed -e 's/\/$//'` &&\
  export HTTPS_PROXY=`echo $https_proxy | sed -e 's/\/$//'`
RUN ./configure
RUN bazel --output_base=/tmp/bazel build --repository_cache=/tmp/cache \
   --config=opt --config=mkl --copt=-O3 --copt=-mavx \
   --copt=-mavx2 --copt=-march=skylake-avx512 --copt=-mfma  \
   //tensorflow/tools/pip_package:build_pip_package
RUN bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tf/

#---------------------------------------------------------------------
# Tensorflow with MKL-DNN on Clear Linux
#---------------------------------------------------------------------
ARG clear_ver
FROM clearlinux/stacks-clearlinux:$clear_ver
LABEL maintainer=otc-swstacks@intel.com

# FIXME: Until Moby finds a way for saving ARGs in multi-stage builds (see https://github.com/moby/moby/issues/34129)
# we have to re-declare clear_ver
ARG clear_ver
ARG swupd_args=$clear_ver

ARG HOROVOD_VERSION=0.16.1

# update os and add required bundles
RUN swupd update -m $swupd_args && \
    swupd bundle-add which git \
    openssh-server sysadmin-basic \
    devpkg-openmpi python3-basic jupyter

RUN ln -s -f /usr/bin/pip3.7 /usr/bin/pip &&\
    ln -s -f /usr/bin/python3.7 /usr/bin/python

# install keras, nltk and jupyterhub
RUN pip --no-cache-dir install \
    keras_applications==1.0.6 \
    keras_preprocessing==1.0.9 \
    nltk==3.4 jupyterhub==0.9.4

# install tensorflow
COPY --from=base /tmp/tf/*.whl /tmp/.
RUN pip --no-cache-dir  install /tmp/tensorflow*.whl

# install horovod
RUN HOROVOD_WITH_TENSORFLOW=1 \
    pip --no-cache-dir install --no-cache-dir horovod==${HOROVOD_VERSION}

# clean up and init
RUN rm -rf /tmp/*
WORKDIR /workspace
COPY ./set_env.sh /workspace/
RUN chmod -R a+w /workspace
ENTRYPOINT source /workspace/set_env.sh && /bin/bash
