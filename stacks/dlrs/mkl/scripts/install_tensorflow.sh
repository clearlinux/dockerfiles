#!/bin/bash
#
# Copyright (c) 2019 Intel Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
set -e
set -u
set -o pipefail

export ARCH=skylake-avx512
export TUNE=cascadelake
export OPTM=3
export TF_BRANCH=r1.14
export TF_TAG=v1.14.0
export PYTHON_BIN_PATH=/usr/bin/python
export PROJECT=tensorflow
export USE_DEFAULT_PYTHON_LIB_PATH=1
export CC_OPT_FLAGS="-march=${ARCH} -mtune=native"
export TF_NEED_JEMALLOC=1
export TF_NEED_KAFKA=0
export TF_NEED_OPENCL_SYCL=0
export TF_NEED_GCP=0
export TF_NEED_HDFS=0
export TF_NEED_S3=0
export TF_ENABLE_XLA=1
export TF_NEED_GDR=0
export TF_NEED_VERBS=0
export TF_NEED_OPENCL=0
export TF_NEED_MPI=0
export TF_NEED_TENSORRT=0
export TF_SET_ANDROID_WORKSPACE=0
export TF_DOWNLOAD_CLANG=0
export TF_NEED_CUDA=0
export TF_BUILD_MAVX=MAVX512
export HTTP_PROXY=$(echo "$http_proxy" | sed -e 's/\/$//')
export HTTPS_PROXY=$(echo "$https_proxy" | sed -e 's/\/$//')

run() {
  echo "=============================================================="
  printf "$(date) -- %s"
  printf "%s\n" "$@"
  echo "=============================================================="
}

python_pkgs(){
# install dependencies for tensorflow build
  pip install pip six numpy wheel setuptools mock future>0.17.1
  pip install keras_applications==1.0.6 --no-deps
  pip install keras_preprocessing==1.0.5 --no-deps
}

get_project() {
  git clone https://github.com/${PROJECT}/${PROJECT}.git 
  cd tensorflow && git checkout -b ${TF_BRANCH} ${TF_TAG}
}

build () {
  # configure tensorflow make scripts
  ./configure

  # build TF
  bazel --output_base=/tmp/bazel build  \
  --repository_cache=/tmp/cache \
  --config=opt --config=mkl --copt=-mfma \
  --copt=-O${OPTM} --copt=-Wa,-mfence-as-lock-add=yes \
  --copt=-march=${ARCH}  --copt=-mtune=native \
   //tensorflow/tools/pip_package:build_pip_package

  # generate pip package
  bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tf/
}

begin="$(date +%s)"
run "get ${PROJECT}" && get_project 
run "install python deps" && python_pkgs
run "config, build ${PROJECT}" && build
finish="$(date +%s)"
runtime=$(((finish-begin)/60))
run "Done in :  $runtime minute(s)"
