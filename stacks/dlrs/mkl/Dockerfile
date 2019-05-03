#---------------------------------------------------------------------
# Base instance to build MKL based Tensorflow on Clear Linux
#---------------------------------------------------------------------

FROM clearlinux as base
LABEL maintainer=otc-swstacks@intel.com

# tf with vnni support and bug fixes
ARG TF_COMMIT_SHA=47ab68d265a96b6e7be06afd1b4b47e0114c0ee9
ARG swupd_args

# update os and add required bundles
RUN swupd update $swupd_args && \
    swupd bundle-add machine-learning-basic git \
    java-basic sysadmin-basic package-utils devpkg-zlib

RUN ln -s -f /usr/bin/pip3.7 /usr/bin/pip
RUN ln -s -f /usr/bin/python3.7 /usr/bin/python

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

FROM clearlinux
LABEL maintainer=otc-swstacks@intel.com

ARG HOROVOD_VERSION=0.16.1
ARG swupd_args

# update os and add required bundles
RUN swupd update $swupd_args && \
    swupd bundle-add git \
    openssh-server sysadmin-basic \
    devpkg-openmpi python3-basic jupyter devpkg-opencv

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
