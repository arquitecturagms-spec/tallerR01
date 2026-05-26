# Usa una base oficial de Ubuntu optimizada para IA y Python
FROM python:3.10-slim

# Instalar dependencias esenciales del sistema y herramientas de Git
RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    libsm6 \
    libxext6 \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

# Configurar el directorio de trabajo principal
WORKDIR /workspace

# Clonar el repositorio oficial de ComfyUI directamente desde GitHub
RUN git clone https://github.com .

# Copiar e instalar las librerías de Python requeridas
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Clonar el ComfyUI-Manager (Herramienta clave para instalar ControlNet y nodos de arquitectura)
RUN git clone https://github.com custom_nodes/ComfyUI-Manager

# Crear manualmente la estructura de carpetas críticas para que el motor no de error
RUN mkdir -p models/checkpoints models/loras models/vae models/controlnet output input

# Configurar las variables de entorno de red obligatorias para Hugging Face
ENV HOST=0.0.0.0
ENV PORT=7860

# Comando final para ejecutar ComfyUI optimizado para la nube en modo CPU/GPU híbrido
CMD ["python", "main.py", "--listen", "0.0.0.0", "--port", "7860", "--cpu"]
