#!/bin/bash
# Activation script for pytorch3d development environment

# Set CUDA_HOME to the conda prefix if not already set
export CUDA_HOME="${CUDA_HOME:-$CONDA_PREFIX}"
export CUDA_PATH="${CUDA_PATH:-$CONDA_PREFIX}"

# Add CUDA include paths for compilation
# The nvidia conda packages put headers in targets/x86_64-linux/include
if [ -d "$CONDA_PREFIX/targets/x86_64-linux/include" ]; then
    export CPATH="$CONDA_PREFIX/targets/x86_64-linux/include${CPATH:+:$CPATH}"
    export C_INCLUDE_PATH="$CONDA_PREFIX/targets/x86_64-linux/include${C_INCLUDE_PATH:+:$C_INCLUDE_PATH}"
    export CPLUS_INCLUDE_PATH="$CONDA_PREFIX/targets/x86_64-linux/include${CPLUS_INCLUDE_PATH:+:$CPLUS_INCLUDE_PATH}"
fi

# Add CUDA lib paths
if [ -d "$CONDA_PREFIX/targets/x86_64-linux/lib" ]; then
    export LIBRARY_PATH="$CONDA_PREFIX/targets/x86_64-linux/lib${LIBRARY_PATH:+:$LIBRARY_PATH}"
    export LD_LIBRARY_PATH="$CONDA_PREFIX/targets/x86_64-linux/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
fi

# Also add the standard conda lib paths
export LD_LIBRARY_PATH="$CONDA_PREFIX/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

# Add PyTorch lib path for libc10.so and other torch libraries
TORCH_LIB="$CONDA_PREFIX/lib/python3.12/site-packages/torch/lib"
if [ -d "$TORCH_LIB" ]; then
    export LD_LIBRARY_PATH="$TORCH_LIB${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
fi

# Set CXX11 ABI flag to match PyTorch build
# Note: Check with `python -c "import torch; print(torch._C._GLIBCXX_USE_CXX11_ABI)"`
export GLIBCXX_USE_CXX11_ABI=0
