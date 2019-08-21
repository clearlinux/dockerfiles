#!/bin/bash
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
export OMP_NUM_THEADS=10
export KMP_BLOCKTIME=2
export KMP_AFFINITY=granularity=fine,verbose,compact,1,0
export INTRA_OP_PARALLELISM_THREADS=10
export INTER_OP_PARALLELISM_THREADS=1
