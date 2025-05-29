#!/bin/bash

echo "hello"

JTVAE_GPU_PATH="./JTVAE/GPU-P3/"
export PYTHONPATH=$JTVAE_GPU_PATH

echo $*
echo $JTVAE_GPU_PATH

VAE="$JTVAE_GPU_PATH""/fast_molvae/vae_train_gpu.py"
TRA=$1
VOC=$2
DIR=$3
OUT=$4
SMI=$5

echo $*

python -u $VAE \
               --train $TRA      \
               --vocab $VOC      \
               --save_dir $DIR   \
               --rejected_smiles $SMI  \
               --batch_size 15    \
               --epoch 10            \
               --num_workers 100   \
               --mult_gpus    \

echo "done"
