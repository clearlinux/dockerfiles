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
set -o pipefail

export PATH=/opt/conda/bin/:$PATH
export GCC_IGNORE_WERROR=1
export CFLAGS="$CFLAGS -O3 -mfma -mtune=skylake-avx512"
export CXXFLAGS="$CXXFLAGS -O3 -mfma -mtune-skylake-avx512"
export GIT_HASH=v1.1.0
export CMAKE_PREFIX_PATH=/opt/conda
# linker fix
[ -f /opt/conda/compiler_compat/ld ] && mv /opt/conda/compiler_compat/ld /opt/conda/compiler_compat/ld.org
echo "=================get pytorch================================="
if [ ! -d ./pytorch/ ]; then
    git clone https://github.com/pytorch/pytorch.git \
    && cd pytorch && git checkout $GIT_HASH && git submodule update --init --recursive \
    && cd ..
fi
echo "=================build and install pytorch with MKL============="
cd ./pytorch/ \
  && python setup.py build && python setup.py install \
  && cd / && rm -rf /scripts/pytorch \
  && find /opt/conda/ -follow -type f -name '*.js.map' -delete \
  && find /opt/conda/ -follow -type f -name '*.pyc' -delete
echo "======================done======================================"

