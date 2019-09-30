#!/usr/bin/bash
source /app/set_model_path.sh

echo "MODEL NAME: $MODEL_NAME"
echo "MODEL PRECISION: $MODEL_PRECISION"
echo "MODEL PATH: $MODEL_PATH"

exec "$@"
