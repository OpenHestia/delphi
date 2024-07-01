ARG UBUNTU_VERSION=22.04
# This needs to generally match the container host's environment.
ARG CUDA_VERSION=12.5.0
# Target the CUDA build image
ARG BASE_CUDA_DEV_CONTAINER=nvidia/cuda:${CUDA_VERSION}-devel-ubuntu${UBUNTU_VERSION}
FROM ${BASE_CUDA_DEV_CONTAINER} AS cuda

WORKDIR /root
ENV CMAKE_ARGS="-DLLAMA_BLAS=ON -DLLAMA_BLAS_VENDOR=OpenBLAS -DLLAMA_CUDA=on"

RUN apt update

# Install openBLAS
RUN apt install -y libopenblas-dev

# Install the pre-requisite for Node.js
RUN apt update && apt install -y -q --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        git \
        libssl-dev \
        wget \
    && rm -rf /var/lib/apt/lists/*

# Install Node.JS
RUN apt-get update && apt-get install -y \
    software-properties-common \
    npm
RUN npm install npm@v6 -g && \
    npm install n -g && \
    n 14.20.0

# Install yarn, because the lmql playground needs not just Node.js but yarn installed
RUN npm install --global --unsafe-perm yarn

RUN apt update
RUN apt install -y python3.10 python3.10-dev python3-pip
RUN apt install -y python-is-python3
RUN apt install -y pkg-config

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install wheel
RUN pip install tensorflow
RUN pip install --upgrade tensorrt
RUN pip install torch torchvision
RUN pip install sentencepiece transformers
RUN pip install llama-cpp-python
RUN pip install lmql
ENV LMQL_DEFAULT_MODEL="local:llama.cpp:/models/llama-2-13b.Q5_K_M.gguf"

FROM cuda AS llamav2

WORKDIR /root
ENTRYPOINT [ "/bin/bash", "-c" ]
