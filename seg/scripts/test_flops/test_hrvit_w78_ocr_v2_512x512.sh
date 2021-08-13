#!/usr/bin/env bash

. config.profile


# PYTHON="python"
PYTHON="/data/anaconda/envs/pytorch1.7.1/bin/python"

# check the enviroment info
export PYTHONPATH="$PWD":$PYTHONPATH
DATA_DIR="${DATA_ROOT}/cityscapes"
BACKBONE="hrt78"
MODEL_NAME="hrt_w78_ocr_v2"
CONFIGS="configs/cityscapes/H_48_D_4.json"


CUDA_VISIBLE_DEVICES=7 $PYTHON -m torch.distributed.launch \
    --nproc_per_node=1 \
    --master_port 12348 \
    main.py \
    --phase test_flops \
    --configs ${CONFIGS} --drop_last y \
    --backbone ${BACKBONE} --model_name ${MODEL_NAME} \
    --val_batch_size 1 \
    --shape 512 512 \
    --test_dir ${DATA_DIR}/val/image \
    --data_dir ${DATA_DIR} 