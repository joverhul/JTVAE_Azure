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



pip install path
#pip install --upgrade numpy

#will see entire dependency tree
pipdeptree -fl


JTVAE_CPU_PATH="./JTVAE/CPU-P3/"
export PYTHONPATH=$JTVAE_CPU_PATH

echo $*

EDF="$JTVAE_CPU_PATH""/fast_molvae/EDF.py"
DAT=$1
VOC=$2
#MOD=$3
OUT=$4
MODELFOLD=$3

echo $*

echo "start"

python -u $EDF -d $DAT        \
               -v $VOC        \
               -c 36 -b 20    \
               -m $MODELFOLD \
   #            >& $OUT