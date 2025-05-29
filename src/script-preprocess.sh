#!/bin/bash

conda install pytorch torchvision cpuonly -c pytorch

WRK="./JTVAE/CPU-P3/fast_bo/Theano-master/"
echo $WRK
cd $WRK
python setup.py install

cd ../../../..

#HOM="/home/azureuser/cloudfiles/code/Users/overhulsejm/job-test/src/"
#echo $HOM
#cd $HOM


JTVAE_CPU_PATH="./JTVAE/CPU-P3/"
export PYTHONPATH=$JTVAE_CPU_PATH

echo $*

PRE="$JTVAE_CPU_PATH""/fast_molvae/preprocess.py"
TRA=$1
DIR=$3
OUT=$2

python $PRE -t $TRA       \
            -n 100 -j 4  \
            -d $DIR       \
            >& $OUT