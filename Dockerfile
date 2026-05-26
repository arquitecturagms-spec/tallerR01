# 1. BASE DEL SISTEMA OPERATIVO Y DEPENDENCIAS
FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    libsm6 \
    libxext6 \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
# 2. CLONACIÓN DEL MOTOR E INSTALACIÓN DE LIBRERÍAS
RUN git clone https://github.com .

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN git clone https://github.com custom_nodes/ComfyUI-Manager
RUN mkdir -p models/checkpoints models/loras models/vae models/controlnet output input
# 3. CONFIGURACIÓN DE RED Y ENCENDIDO DEL MOTOR
ENV HOST=0.0.0.0
ENV PORT=7860

CMD ["python", "main.py", "--listen", "0.0.0.0", "--port", "7860", "--cpu"]
