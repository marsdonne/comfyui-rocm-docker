#!/bin/bash
VENV_DIR=/venv

# Setup venv if not already created
if [ ! -d "$VENV_DIR" ]; then
    echo "Creating virtual environment..."
    python3 -m venv "$VENV_DIR"
    source "$VENV_DIR/bin/activate"

    echo "Installing PyTorch and dependencies..."
    pip install --upgrade pip
    pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/rocm6.2
    
    echo "Installing ComfyUI requirements..."
    pip install -r requirements.txt
    pip install pyyaml

    echo "Ensuring model directory exists..."
    MODEL_DIR=models/checkpoints
    mkdir -p "$MODEL_DIR"

    # Download sample model
    echo "Downloading SD-1.5 Sample model (v1-5-pruned-emaonly.safetensors)..."
    wget -nv -O $MODEL_DIR/v1-5-pruned-emaonly.safetensors https://huggingface.co/stable-diffusion-v1-5/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.safetensors
else
    echo "Using existing virtual environment."
    source "$VENV_DIR/bin/activate"
fi

# Run ComfyUI
exec "$VENV_DIR/bin/python" main.py