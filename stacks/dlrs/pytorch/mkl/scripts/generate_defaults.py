#!/usr/bin/env python
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
""" Helper script that generates a file with sane defaults that can be sourced when using MKL_DNN optimized DLRS stack.
    We recommend you fine tune the exported env variables based on the workload. More details can be found at:
    https://github.com/IntelAI/models/blob/master/docs/general/tensorflow_serving/GeneralBestPractices.md.
    To get further details, try --verbose."""

import os
import argparse
import subprocess
import sys

import psutil

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument(
    "-v",
    "--verbose",
    action="store_true",
    help="detailed info on the variables being set",
)
parser.add_argument(
    "-g",
    "--generate",
    action="store_true",
    help="generate 'mkl_env.sh' file with default settings for MKL DNN",
    required=False,
)
args = parser.parse_args()


def main():
    sockets = int(
        subprocess.check_output(
            'cat /proc/cpuinfo | grep "physical id" | sort -u | wc -l', shell=True
        )
    )
    physical_cores = psutil.cpu_count(logical=False)
    vars = {}
    vars["OMP_NUM_THREADS"] = {
        "value": physical_cores,
        "help": "Number of OpenMP threads",
    }
    vars["KMP_BLOCKTIME"] = {
        "value": 1,
        "help": "Thread waits until set ms after execution.",
    }
    vars["KMP_AFFINITY"] = {
        "value": "granularity=fine,verbose,compact,1,0",
        "help": "OpenMP threads bound to single thread context compactly",
    }
    vars["INTRA_OP_PARALLELISM_THREADS"] = {
        "value": physical_cores,
        "help": "scheme for individual op",
    }
    vars["INTER_OP_PARALLELISM_THREADS"] = {
        "value": sockets,
        "help": "parllelizing scheme for independent ops",
    }
    if args.verbose:
        print(
            (
                "variables that can be used to fine tune performance,\n"
                "use '-g' or '--generate' to generate a file with these variables\n"
            )
        )
        for var, val in vars.items():
            print("variable: {}, description: {}".format(var, val["help"]))
    if args.generate:
        print("Generating default env vars for MKL and OpenMP, stored in /workspace/mkl_env.sh ")
        for var, val in vars.items():
            print(
                "export {}={}".format(var, str(val["value"])),
                file=open("mkl_env.sh", "a"),
            )


if __name__ == "__main__":
    main()
