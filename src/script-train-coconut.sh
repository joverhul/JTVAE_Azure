#!/bin/bash

#conda install pytorch torchvision torchaudio cudatoolkit=10.2 -c pytorch

#WRK="./JTVAE/CPU-P3/fast_bo/Theano-master/"
#echo $WRK
#cd $WRK
#python setup.py install

#cd ../../../..

#HOM="/home/azureuser/cloudfiles/code/Users/overhulsejm/job-test/src/"
#echo $HOM
#cd $HOM



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


#torchrun --standalone --nproc_per_node=gpu $VAE \
 #               --train $TRA      \
  #             --vocab $VOC      \
   #            --save_dir $DIR   \
    #           --batch_size 8    \
     #          --epoch 5            \
      #         --num_workers 4   \
       #        --mult_gpus    \
        #        >& $OUT


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
