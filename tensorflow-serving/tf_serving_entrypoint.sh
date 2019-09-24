#!/bin/bash

if [ "$1" = 'tensorflow_model_server' ]; then
    exec tensorflow_model_server --port=8500 --rest_api_port=8501 \
        --model_name=${MODEL_NAME} --model_base_path=${MODEL_BASE_PATH}/${MODEL_NAME}
fi

if [ "${1#-}" != "$1" ]; then
    set -- tensorflow_model_server --port=8500 --rest_api_port=8501 \
        --model_name=${MODEL_NAME} --model_base_path=${MODEL_BASE_PATH}/${MODEL_NAME} "$@"
fi

exec "$@"
~

