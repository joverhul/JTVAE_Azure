# Azure Instructions
This is instructions to run the Junction Tree Variational AutoEncoder (JTVAE) Pipeline.

## Environment Setup

Before beginning, two AML environments should be created.

The first environment is specific to the CPU jobs (vocabulary generation, preprocessing, and reconstruction accuracy). This environment should be created using an existing docker image with option conda file.

Existing container registry image path (Azure parent image): mcr.microsoft.com/aifx/acpt/stable-ubuntu2004-cu116-py38-torch1121:latest

Use the conda file in this repo [Azure_AML_CPU_env_conda.yml](https://github.com/joverhul/JTVAE_Azure/blob/main/Azure_AML_CPU_env_conda.yml) as the uploaded customized conda file.

The second environment is specific to the GPU job (training). This environment should be created using a [Dockerfile](https://github.com/joverhul/JTVAE_Azure/blob/main/GPU_env_Dockerfile) and a [requirements.txt](https://github.com/joverhul/JTVAE_Azure/blob/main/GPU_env_requirements.txt) file.

A prepare_image job will be created with both environments, and the build should be successful.

## Job Setup

Create a yaml file for job submission for each of the different steps of the JTVAE model training. For further information on each of the steps please visit the original JTVAE repo and paper as described in the use case. The code is the name of the folder that contains the code you will be running.

### Data Location
The datasets used for the vocabulary generation, preprocessing, training, and reconstruction evaluation can all be found in the [Raw Data folder](https://github.com/joverhul/JTVAE_Azure/tree/main/LOGP-JTVAE-PAPER/Raw-Data/ZINC).

### Vocabulary Generation
Requires the total dataset SMILES strings as input.  The output produced is a file with the broken down vocabulary. This job should be run on a CPU cluster inside of the CPU environment described above. 

### Preprocessing of Compounds
Requires the training set of SMILES you will be training the autoencoder with. The output file is folder of .pkl files that are used to train the model. This job should be run on a CPU cluster inside of the CPU environment described above.

* Vocabulary generation and preprocessing of compounds can be done simulataneously.

### Training AutoEncoder
Requires the output of the above two steps linked with the path. The output of the training step is a folder of several epochs that is determined inside of the training script. A print out of rejected smiles strings that are potentially causing errors with the training is provided. Note: This occurs when compounds are too complex. This job should be run within the GPU environment on a GPU. 

Ensure the distribution and resources matches the necessary requirements for your run.  In this case, pytorch is specified with a shm_size set to 2000G. 
process_count_per_instance is set to 4 and instance_count is set to 1 because the compute resources used is 4 GPUs on one instance in AML.

### Reconstruction Evaluation
Requires a test dataset, the total vocab, and the model output folder.  The output file shows the reconstruction accuracy.  This job should be run on a CPU environment.

### Components and Pipeline
The component job submission is similar to specific jobs, but does not require paths in the component set up. Indicate the paths either in the pipeline.yaml file, or inside the pipeline designer on AML.

### yaml file contents
#### code
Folder that contains your source code.

#### command
Contains the .sh file, along with the inputs and outputs.

#### inputs
Input files and input names mounted on the AML space.

#### outputs
Output files that will be written to AML.

#### environment
The name of the environment you created to run the job in.

#### compute
The name of the compute cluster the job will be run on.

#### naming
The display name, experiment name, and description are all customizable for what you will call the job.

### sh script edits
To submit the job, create a .sh file that will run your desired code. A runnable example can be found in `script-vocab.sh`.
src/script-vocab.sh

### submit job

Once all files are updated, run the cell: 

`!az ml job create -f jobvocab.yaml`

in the jtvae-submit-job.ipynb notebook.

Estimated time for jobs using provided values:
vocab: 20m 17s
preprocess: 2h 20m
train: 6h 57m
reconstruction: 14m 44s
