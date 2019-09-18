#!/usr/bin/bash
source /work/set_model_path.sh

echo "MODEL NAME: $MODEL_NAME"
echo "MODEL PRECISION: $MODEL_PRECISION"
echo "MODEL PATH: $MODEL_PATH"

/usr/bin/bash -c "$@"
