#!/usr/bin/env bash
# Copyright (C) 2018 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

# demo to use alexnet modle to do classification

classification_sample_async -i cat.bmp -m $MODEL_PATH/$MODEL_NAME.xml
