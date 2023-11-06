#!/bin/bash
set -x
cd $SIMPLEVIS_DATA/workspace
cp -R datasets/training/* /opt/app-root/src/simplevis-data/workspace/training
ls -l /usr/local/lib/python3.9/site-packages/yolov5
ls -l /usr/local/lib/python3.9/site-packages/yolov5/training
ls -l /usr/local/lib/python3.9/site-packages/yolov5/training/images
# yolo train model=${SIMPLEVIS_DATA}/workspace/$BASE_MODEL batch=$BATCH_SIZE epochs=$NUM_EPOCHS data=classes.yaml project=${SIMPLEVIS_DATA}/workspace/runs exist_ok=True
sparseml.yolov5.train --imgsz 640 --epochs $NUM_EPOCHS --batch-size $BATCH_SIZE --data classes.yaml --weights ${SIMPLEVIS_DATA}/workspace/$BASE_MODEL --project ${SIMPLEVIS_DATA}/workspace/runs
