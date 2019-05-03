#!/bin/bash

echo "Sane defaults when using MKL_DNN optimized DLRS stack."
echo "We recommend you fine tune the exported env variables based on the workload"
echo "More details can be found at: https://github.com/IntelAI/models/blob/master/docs/general/tensorflow_serving/GeneralBestPractices.md"


# A good default setting for OMP theads is number of physical cores
physical_cores=$(lscpu | grep 'Core(s)' | head -1 | awk '{print $4}')
sockets=$(lscpu | grep 'Socket(s)' | head -1 | awk '{print $2}')
total_physical_cores=$((physical_cores * sockets))
export OMP_NUM_THREADS=$total_physical_cores
# number of threads to use for a TensorFlow session, specifically
# when used for inference
export TENSORFLOW_SESSION_PARALLELISM=$((total_physical_cores / 4))
export KMP_BLOCKTIME=2
export KMP_AFFINITY=granularity=fine,verbose,compact,1,0
# if available set intra_op and inter_op threads as well.
export INTRA_OP_PARALLELISM_THREADS=$total_physical_cores
export INTER_OP_PARALLELISM_THREADS=$sockets
