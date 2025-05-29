# Azure Instructions
This is instructions to run the Junction Tree Variational AutoEncoder (JTVAE) Pipeline.

## Environment Setup

Before beginning, two AML environments should be created.

The first environment is specific to the CPU jobs (vocabulary generation, preprocessing, and reconstruction accuracy). This environment should be created using an existing docker image with option conda file.

Existing container registry image path (Azure parent image): mcr.microsoft.com/aifx/acpt/stable-ubuntu2004-cu116-py38-torch1121:latest

Use the conda file in this repo Azure_AML_CPU_env_conda.yml as the uploaded customized conda file.

The second environment is specific to the GPU job (training). This environment should be created using a Dockerfile and a requirements.txt file.

A prepare_image job will be created with both environments, and the build should be successful.
