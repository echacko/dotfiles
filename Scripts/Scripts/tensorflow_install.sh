#! /usr/bin/bash
## Script to install tensorflow on arch linux
## Ensure that you have installed the nvidia drivers
## and anaconda before running this script.
## Also, activate anaconda before running this script.

# Check if Anaconda is installed
ANACONDA_PATH=$HOME/anaconda3/

# Dispaly ANACONDA_PATH and ask for conformation. If not, then ask for
# valid anaconda path.
echo "Anaconda path: $ANACONDA_PATH"
read -p "Is this the correct path to Anaconda? (y/n): " confirm
if [[ $confirm != [yY] ]]; then
  read -p "Enter the path to Anaconda: " ANACONDA_PATH
fi

if [[ ! -f $ANACONDA_PATH/bin/activate ]]; then
  echo "Error: Anaconda is not instlled. Please install Anaconda at $ANACONDA_PATH before running this script."
  exit 1
fi

# Activate anaconda
source $ANACONDA_PATH/bin/activate

# Define versions
VENV_NAME=sionna
PYTHON_VER=3.8
CUDA_VER=11.8.0
CUDNN_VER=8.6.0.163
TF_VER='2.12.*'
REQUIRED_DRIVER_VER="450.80.02"

# Check NVIDIA GPU driver version
NVIDIA_DRIVER_VER=$(nvidia-smi --query-gpu=driver_version --format=csv,noheader)

if [[ $(printf "$REQUIRED_DRIVER_VER\n$NVIDIA_DRIVER_VER" | sort -V | head -n1) != $REQUIRED_DRIVER_VER ]]; then
  echo "Error: NVIDIA GPU drivers version $REQUIRED_DRIVER_VER or higher are required, but the installed version is $NVIDIA_DRIVER_VER."
  exit 1
fi

# Print versions
echo "Installing TensorFlow in venv $VENV_NAME with the following versions:"
echo "Python version: $PYTHON_VER"
echo "CUDA version: $CUDA_VER"
echo "cuDNN version: $CUDNN_VER"
echo "TensorFlow version: $TF_VER"
echo "Required NVIDIA GPU driver version: $REQUIRED_DRIVER_VER"
echo "Current NVIDIA GPU driver version: $NVIDIA_DRIVER_VER"

# Ask for confirmation
read -p "Do you want to proceed with the installation? (y/n): " confirm
if [[ $confirm != [yY] ]]; then
  # Ask if the user wants to update the installaation versions
  read -p "Do you want to update the installation versions? (y/n): " confirm
  if [[ $confirm != [yY] ]]; then
    echo "Installation canceled."
    exit 1
  else
    read -p "Enter the Python version: " PYTHON_VER
    read -p "Enter the CUDA version: " CUDA_VER
    read -p "Enter the cuDNN version: " CUDNN_VER
    read -p "Enter the TensorFlow version: " TF_VER
  fi
fi

# Check if venv already exists
if [[ -d $ANACONDA_PATH/envs/$VENV_NAME ]]; then
  echo "Error: Conda environment $VENV_NAME already exists. Please remove the $VENV_NAME environment before running this script."
  exit 1
fi

# Create Conda environment
conda create -n $VENV_NAME python=$PYTHON_VER
conda activate $VENV_NAME

# Make sure the tf is activated
if [[ $CONDA_DEFAULT_ENV != $VENV_NAME ]]; then
  echo "Error: Cannot activate Conda environment $VENV_NAME."
  echo "Please try again or install manually."
  exit 1
else
  echo "Conda environment $VENV_NAME activated."
fi

# Install CUDA Toolkit
conda install -c conda-forge cudatoolkit=$CUDA_VER

# Install cuDNN
python3 -m pip install nvidia-cudnn-cu11==$CUDNN_VER

# Install TensorFlow
python3 -m pip install tensorflow==$TF_VER

# Set environment variables
mkdir -p $CONDA_PREFIX/etc/conda/activate.d
echo 'CUDNN_PATH=$(dirname $(python -c "import nvidia.cudnn;print(nvidia.cudnn.__file__)"))' >> $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/:$CUDNN_PATH/lib' >> $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh
source $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh

# Verify installation
python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"

echo "TensorFlow installed successfully."

