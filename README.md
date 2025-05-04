# ComfyUI with ROCm Docker (AMD GPUs)

This repository provides a Dockerized environment for running **[ComfyUI](https://github.com/comfyanonymous/ComfyUI)** on **AMD GPUs** using **ROCm**. It includes a `Dockerfile` and `docker-compose.yaml` configured for hardware acceleration and easy deployment on systems with supported AMD GPUs.

---

## 🚀 Features

- **Full ROCm support** for AMD GPUs (tested with ROCm 6.4).
- Installs and runs **ComfyUI** in a containerized environment.
- Downloads and sets up the **Stable Diffusion 1.5** model automatically.
- Includes **ComfyUI Manager** plugin for enhanced UI node management.
- Designed to work with Docker Compose for simple setup.

---

## 🛠 Prerequisites
- AMD GPU with ROCm-compatible architecture (see table below).
- ROCm drivers installed on the host. [Install ROCm →](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/install/quick-start.html#rocm-installation)
- Docker and Docker Compose installed.

## 🛠️ AMD GPUs Requiring `HSA_OVERRIDE_GFX_VERSION` (Unofficial ROCm Workaround)

| GPU Series       | GPU Models                                      | GFX ID   | Suggested HSA_OVERRIDE_GFX_VERSION |
|------------------|--------------------------------------------------|----------|-------------------------------------|
| **RDNA1**        | RX 5700 / 5700 XT                                | gfx1010  | 10.3.0                              |
|                  | RX 5600 XT                                       | gfx1011  | 10.3.0                              |
|                  | RX 5500 XT                                       | gfx1012  | 10.3.0                              |
| **RDNA2**        | RX 6600 / 6600 XT / 6650 XT                      | gfx1032  | 10.3.0                              |
|                  | RX 6500 XT                                       | gfx1034  | 10.3.0                              |
|                  | RX 6400                                          | gfx1035  | 10.3.0                              |
|                  | RX 6300                                          | gfx1036  | 10.3.0                              |
| **RDNA3**        | RX 7900 XTX / XT / GRE (partial support)         | gfx1100  | 11.0.0                              |
|                  | RX 7800 XT / RX 7700 XT                          | gfx1103  | 11.0.0                              |
|                  | RX 7600                                          | gfx1102  | 11.0.0                              |
| **Integrated RDNA2** | Ryzen 7000 Series iGPU (Phoenix iGPU)        | gfx1036  | 10.3.0                              |
---

## 🧰 Build and Run

### 🔧 Build the Docker Image

```bash
docker build -t comfyui-rocm .
```

### ▶️ Start the Container

```bash
docker compose up
```

Then open your browser and go to: [http://localhost:8188](http://localhost:8188)

---

## 📁 Mounted Volumes

You can customize the bound directories to your likings. Keep in mind that the directories are owned by docker / root,
so you might need elevated permissions to write into those directories, e.g. copying new models.

---

## 🧪 Tested With

- ROCm 6.4 on Fedora 42 (KDE)
- AMD Radeon RX 6600m
- Docker Engine 24+
- Docker Compose v2+

---

## 📝 Notes

- Set the `HSA_OVERRIDE_GFX_VERSION` variable according to your GPU architecture if needed.
- Make sure ROCm is functioning correctly on the host (`rocminfo`, `clinfo`, etc.).
- If using a different ROCm version, update the `amdgpu-install` package URL accordingly.


