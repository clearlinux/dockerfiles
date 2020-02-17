#!/usr/bin/env bash
# Copyright (C) 2018 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

benchmark_app -m $MODEL_PATH/$MODEL_NAME.xml -d CPU -api async -i car.png --progress true

