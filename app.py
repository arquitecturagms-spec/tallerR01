import os
import sys

# Clonar dinámicamente el núcleo de ComfyUI si no existe en el contenedor
if not os.path.exists("ComfyUI-Core"):
    print("Clonando el motor central de ComfyUI...")
    os.system("git clone https://github.com ComfyUI-Core")

# Añadir el motor al sistema de rutas de Python
sys.path.append(os.path.abspath("ComfyUI-Core"))

# Ejecutar el archivo principal del motor clonado con los argumentos necesarios
if __name__ == "__main__":
    import launch
    # Esto arranca el servidor nativo
