#!/bin/sh
if [ -n "$OMP_NUM_THREADS" ]; then
  echo "Warning: Manual set of \"OMP_NUM_THREADS=$OMP_NUM_THREADS\" may be not better than the calculated value by script!"
else
  source /usr/local/bin/set-num-threads.sh
  echo "runtime calculated and exported OMP_NUM_THREADS=${OMP_NUM_THREADS}"
fi

python3 main.py
