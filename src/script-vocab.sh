#!/bin/bash

#HOM="/home/azureuser/cloudfiles/code/Users/overhulsejm/job-test/src/"
#add echo commands here
#conda install -c conda-forge rdkit=2020.09.5 
#conda install numpy 
#conda install scipy
#conda install joblib
#conda install networkx 

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

VOC="$JTVAE_CPU_PATH""/fast_jtnn/mol_tree.py"
DAT=$1
#DAT="scaffold_split_25perc_test.txt"
OUT=$2

time python $VOC < $DAT > $OUT

echo "done"

#python script.py