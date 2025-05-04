FROM alpine/git:latest AS builder
WORKDIR /opt
RUN git clone --depth 1 https://github.com/comfyanonymous/ComfyUI.git
WORKDIR /opt/ComfyUI

FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

# Add render/video groups
RUN groupadd -f render && \
    groupadd -f video && \
    usermod -a -G render,video $LOGNAME || usermod -a -G render,video root

# Install base tooling
RUN apt-get update && \
    apt-get install -y git wget

# Install ComfyUI dependencies
RUN apt-get install -y python3-pip python3-venv libstdc++-12-dev python3-setuptools python3-wheel rocminfo && \
    apt-get install -y --no-install-recommends google-perftools && \
    wget https://repo.radeon.com/amdgpu-install/6.4/ubuntu/noble/amdgpu-install_6.4.60400-1_all.deb && \
    apt-get install -y ./amdgpu-install_6.4.60400-1_all.deb

COPY --from=builder /opt/ComfyUI /comfyui
WORKDIR /comfyui

# Install Comfy-UI Manager
RUN git clone https://github.com/ltdrdata/ComfyUI-Manager custom_nodes/comfyui-manager

SHELL ["/bin/bash", "-c"]    

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8188
ENTRYPOINT ["/entrypoint.sh"]