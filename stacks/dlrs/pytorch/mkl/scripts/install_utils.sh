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

export PATH=/opt/conda/bin:$PATH
echo "=================install utilities============================="
pip --no-cache-dir install -r ./deps/pip.deps \
  && pip --no-cache-dir install typing-extensions horovod opencv-python==4.1.0.25 \
  && mv /opt/conda/compiler_compat/ld.org /opt/conda/compiler_compat/ld \
  && mv /opt/conda/lib/libtinfo.so.6 /opt/conda/lib/libtinfo.so.6.org \
    && find /opt/conda/ -follow -type f -name '*.js.map' -delete \
    && find /opt/conda/ -follow -type f -name '*.pyc' -delete \
    && python -m ipykernel install --user \
    && npm cache clean --force \
    && rm -rf /tmp/* \
    && rm ./deps/pip.deps
echo "==================done=========================================="
