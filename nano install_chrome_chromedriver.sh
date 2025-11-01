#!/bin/bash
# ============================================================
#  Instalador automático de Google Chrome y ChromeDriver
#  Compatible con Ubuntu 20.04 / 22.04 / 24.04 / EC2-VPS
#  Autor: NETDROIDVPS (Optimizado para entornos root)
# ============================================================

set -e  # Detiene el script ante cualquier error

echo "🚀 Iniciando instalación de Google Chrome y ChromeDriver..."

# --- Actualizar repositorios ---
sudo apt update -y
sudo apt install -y wget unzip curl gnupg

# --- Verificar si Google Chrome está instalado ---
if command -v google-chrome &> /dev/null
then
    echo "✅ Google Chrome ya está instalado."
else
    echo "📦 Instalando Google Chrome estable..."
    wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install -y ./google-chrome-stable_current_amd64.deb
    rm -f google-chrome-stable_current_amd64.deb
    echo "✅ Google Chrome instalado correctamente."
fi

# --- Obtener versión actual de Chrome ---
CHROME_VERSION=$(google-chrome --version | grep -oP '\d+' | head -1)
echo "🔍 Versión principal detectada de Chrome: $CHROME_VERSION"

# --- Instalar ChromeDriver correspondiente ---
if command -v chromedriver &> /dev/null
then
    echo "✅ ChromeDriver ya está instalado. Verificando versión..."
    chromedriver --version
else
    echo "📦 Descargando ChromeDriver compatible..."
    DRIVER_VERSION=$(curl -s "https://googlechromelabs.github.io/chrome-for-testing/LATEST_RELEASE_$CHROME_VERSION")

    if [ -z "$DRIVER_VERSION" ]; then
        echo "❌ No se encontró versión compatible para Chrome $CHROME_VERSION"
        exit 1
    fi

    wget -q https://storage.googleapis.com/chrome-for-testing-public/$DRIVER_VERSION/linux64/chromedriver-linux64.zip
    unzip -q chromedriver-linux64.zip
    sudo mv chromedriver-linux64/chromedriver /usr/local/bin/
    sudo chmod +x /usr/local/bin/chromedriver
    rm -rf chromedriver-linux64 chromedriver-linux64.zip
    echo "✅ ChromeDriver instalado correctamente."
fi

# --- Mostrar versiones finales ---
echo "--------------------------------------------------"
echo "✅ Instalación completada correctamente."
google-chrome --version
chromedriver --version
echo "--------------------------------------------------"
echo "🎯 Google Chrome y ChromeDriver están listos."
