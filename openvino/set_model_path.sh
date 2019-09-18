#!/bin/sh
# set -e

# download model
model_dl() {
    model-downloader --name $1 -o $MODEL_DIR  && \
    model-converter --name $1 -d $MODEL_DIR -o $MODEL_DIR --mo $MO_PATH; \
}

# set model path
set_model_path() {
    if [ "$MODEL_PRECISION" ]; then
        MODEL_PATH=$(find $MODEL_DIR -name "$MODEL_NAME.xml" | grep $MODEL_PRECISION)
    else
        MODEL_PATH=$(find $MODEL_DIR -name "$MODEL_NAME.xml")
    fi

    export MODEL_PATH=${MODEL_PATH%/*}
}

# download models if not existed and set the model path
if [ "$MODEL_NAME" ]; then
    set_model_path

    if [ -z "$MODEL_PATH" ]; then
        model_dl $MODEL_NAME
        set_model_path
    fi
fi

if [ -z "$MODEL_PATH" ]; then
    echo "Wrong model $MODEL_NAME, couldn't set MODEL_PATH"
fi

