#!/bin/bash

if [ $# -eq 0 ]; then
    echo Warning: No namespace provided. Please provide a target namespace.
    exit 1
fi

# Assign the first argument to the TABLESPACE variable
TABLESPACE=$1

# Execute your code here using the TABLESPACE variable
echo "Run model training"
tkn pipeline start training-x-pipeline \
  -w name=sourcecode,volumeClaimTemplateFile=code-pvc.yaml \
  -w name=shared-workspace,volumeClaimTemplateFile=work-pvc.yaml \
  -p ocp-tablespace="$TABLESPACE" \
  -p git-url=https://github.com/redhat-na-ssa/flyingthings.git \
  -p git-revision=main \
  -p BATCH_SIZE="-1" \
  -p NUM_EPOCHS="100" \
  -p IMG_RESIZE="Y" \
  -p MAX_WIDTH="200" \
  -p WEIGHTS=hoscale.pt \
  -p DATASET_ZIP=hoscale.zip \
  -p MINIO_ENDPOINT=http://minio:9000 \
  -p MINIO_ACCESSKEY=minioadmin \
  -p MINIO_SECRETKEY=minioadmin \
  -p MINIO_BUCKET=hoscale \
  -p MODEL_NAME=model-hoscale \
  -p MINIO_CLIENT_URL=https://dl.min.io/client/mc/release/linux-amd64 \
  -p DEPLOY="Y" \
  --use-param-defaults --showlog

# Exit the script gracefully
exit 0
