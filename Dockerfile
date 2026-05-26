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
