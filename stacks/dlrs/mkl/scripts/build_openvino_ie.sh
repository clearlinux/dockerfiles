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

export CFLAGS="-O3 "
export CXXFLAGS="-O3 "
export FCFLAGS="$CFLAGS "
export FFLAGS="$CFLAGS "
export CFLAGS="$CFLAGS -march=skylake-avx512 -m64 -pipe"
export CXXFLAGS="$CXXFLAGS -march=skylake-avx512 -m64 -pipe"
export GCC_IGNORE_WERROR=1
export GIT_HASH=0ef928  # 2019_R1.0.1
# setup mkl
export MKL_VERSION=mklml_lnx_2019.0.5.20190502
export MKLDNN=v0.19
export N_JOBS=$(grep -c ^processor /proc/cpuinfo)

echo "=================get dldt================================="
if [ ! -d ./dldt/ ]; then
    git clone --recursive -j"$N_JOBS" https://github.com/opencv/dldt.git &&\
    cd dldt && git checkout -b v2019_R1.1 $GIT_HASH && cd ..
fi
echo "=================config and build inference engine=================="
cd ./dldt/
CMAKE_ARGS="-DENABLE_MKL_DNN=ON -DTHREADING=OMP -DENABLE_GNA=OFF -DENABLE_CLDNN=OFF -DENABLE_MYRIAD=OFF -DENABLE_VPU=OFF"
mkdir -p ./inference-engine/build &&\
cd ./inference-engine/build
IE_BUILD_DIR=$(pwd)
cmake $CMAKE_ARGS ..
make -j"$N_JOBS"
echo "=================config and build IE bridges========================="
CMAKE_ARGS="-DInferenceEngine_DIR=$IE_BUILD_DIR
-DPYTHON_EXECUTABLE=$(command -v python)
-DPYTHON_LIBRARY=/usr/lib64/libpython3.7m.so
-DPYTHON_INCLUDE_DIR=/usr/include/python3.7m"
cd "$IE_BUILD_DIR"/../ie_bridges/python &&\
mkdir -p build &&\
cd build
cmake $CMAKE_ARGS ..
make -j"$N_JOBS"
echo "===================================================================="
echo "Inference Engine build directory is: $IE_BUILD_DIR"
echo "IE bridges build directory is: $(pwd)"
echo "===================================================================="
