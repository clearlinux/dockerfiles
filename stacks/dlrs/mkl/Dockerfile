#---------------------------------------------------------------------
# Base instance to build MKL based Tensorflow on Clear Linux
#---------------------------------------------------------------------
ARG clear_ver
FROM stacks-clearlinux:$clear_ver as base
LABEL maintainer=otc-swstacks@intel.com

# FIXME: Until Moby finds a way for saving ARGs in multi-stage builds (see https://github.com/moby/moby/issues/34129)
# we have to re-declare clear_ver
ARG clear_ver
ARG swupd_args=$clear_ver

# update os and add required bundles
RUN swupd update -m $swupd_args \
    && swupd bundle-add git curl wget \
    java-basic sysadmin-basic package-utils devpkg-zlib

# fix for stdlib not found issue
RUN ln -sf /usr/lib64/libstdc++.so /usr/lib64/libstdc++.so.6

COPY ./scripts/ /scripts
# do not change the order of the devpkg-opencv bundle install
# as it interferes with TensorFlow build
RUN ./scripts/install_bazel.sh \
    && ./scripts/install_tensorflow.sh
RUN cd /usr/lib64/ && ln -sf libzstd.so.1.4.1 libzstd.so.1
RUN swupd clean \
    && swupd bundle-add devpkg-opencv devpkg-llvm \
    && ./scripts/build_openvino_ie.sh

#---------------------------------------------------------------------
# Tensorflow with MKL-DNN on Clear Linux
#---------------------------------------------------------------------
ARG clear_ver
FROM stacks-clearlinux:$clear_ver
LABEL maintainer=otc-swstacks@intel.com

# FIXME: Until Moby finds a way for saving ARGs in multi-stage builds (see https://github.com/moby/moby/issues/34129)
# we have to re-declare clear_ver
ARG clear_ver
ARG swupd_args=$clear_ver
ARG HOROVOD_VERSION=0.16.4
ARG NUMACTL_VERSION=2.0.12
ARG MODEL_SERVER_TAG=v2019.1.1

# update os and add required bundles
RUN swupd update -m $swupd_args \
    && swupd bundle-add devpkg-openmpi devpkg-libX11 git openssh-server c-basic nodejs-basic curl python3-basic devpkg-gperftools \
    && curl -fSsL -O https://github.com/numactl/numactl/releases/download/v${NUMACTL_VERSION}/numactl-${NUMACTL_VERSION}.tar.gz \
    && tar xf numactl-${NUMACTL_VERSION}.tar.gz \
    && cd numactl-${NUMACTL_VERSION} \
    && ./configure \
    && make \
    && make install \
    && rm -rf /numactl-${NUMACTL_VERSION}* \
    && rm -rf /var/lib/swupd/* \
    && ln -sf /usr/lib64/libstdc++.so /usr/lib64/libstdc++.so.6 \
    && ln -sf /usr/lib64/libzstd.so.1.4.* /usr/lib64/libzstd.so.1 \
    && ln -s /usr/lib64/libtcmalloc.so /usr/lib/libtcmalloc.so

# install tensorflow, ntlk, jupyterhub, opencv and horovod
COPY --from=base /tmp/tf/*.whl /tmp/.
RUN pip --no-cache-dir install /tmp/tensorflow*.whl \
    nltk jupyter jupyterlab jupyterhub opencv-python \
    horovod==${HOROVOD_VERSION} \
    && npm install -g configurable-http-proxy \
    && pip --no-cache-dir install common \
    && pip --no-cache-dir install notebook protobuf \
    && pip --no-cache-dir install numpy tensorflow-serving-api google-cloud-storage boto3 jsonschema falcon cheroot \
    && pip --no-cache-dir install grpcio defusedxml==0.5.0 grpcio-tools test-generator==0.1.1 \
    && npm cache clean --force \
    && rm -rf /tmp/* \
    && find /usr/lib/ -follow -type f -name '*.pyc' -delete \
    && find /usr/lib/ -follow -type f -name '*.js.map' -delete 

# install openvino inference engine
COPY --from=base /dldt/inference-engine/bin/intel64/Release/lib/*.so /usr/local/lib/
COPY --from=base /dldt/inference-engine/ie_bridges/python/bin/intel64/Release/python_api/python3.7/openvino/ /usr/local/lib/openvino/

# init
RUN echo "export LD_LIBRARY_PATH=/usr/local/lib" >> /.bashrc \
    && echo "export PYTHONPATH=/usr/local/lib" >> /.bashrc
# init ie serving
WORKDIR /ie_serving_py
RUN git clone https://github.com/IntelAI/OpenVINO-model-server.git model_server \
    && cd model_server && git checkout ${MODEL_SERVER_TAG} && cd .. \
    && cp ./model_server/setup.py /ie_serving_py \
    && echo "OpenVINO Model Server version: ${MODEL_SERVER_TAG}" > /ie_serving_py/version \
    && echo "Git commit: `cd ./model_server; git rev-parse HEAD; cd ..`" >> /ie_serving_py/version \
    && echo "OpenVINO version: ${MODEL_SERVER_TAG} src" >> /ie_serving_py/version \
    && echo "# OpenVINO built with: https://github.com/opencv/dldt.git" >> /ie_serving_py/version \
    && cp -r ./model_server/ie_serving /ie_serving_py/ie_serving \
    && pip --no-cache-dir install . \
    && rm -rf model_server
WORKDIR /workspace
COPY ./scripts/*.sh /workspace/scripts/
COPY ./scripts/*.md /workspace/scripts/
RUN chmod -R a+w /workspace
