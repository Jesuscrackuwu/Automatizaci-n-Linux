from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
import time
import os

# Configurar opciones de Chrome
options = Options()
options.add_argument("--no-sandbox")
options.add_argument("--disable-dev-shm-usage")
options.add_argument("--disable-gpu")
options.add_argument("--remote-debugging-port=9222")
options.add_argument("--window-size=1280,800")

# Si estás en servidor sin entorno gráfico
options.add_argument("--headless=new")

# Ruta del ChromeDriver
service = Service("/usr/local/bin/chromedriver")

print("🚀 Iniciando prueba con Google Chrome...")

# Iniciar navegador
driver = webdriver.Chrome(service=service, options=options)

try:
    # Abrir página
    driver.get("https://portal.nuevaeps.com.co/Portal/home.jspx")

    print("✅ Página abierta:", driver.title)

    # Esperar a que cargue bien
    time.sleep(3)

    # Ruta donde guardar captura
    screenshot_path = os.path.join(os.getcwd(), "captura_google.png")

    # Tomar captura
    driver.save_screenshot(screenshot_path)

    print(f"📸 Captura guardada en: {screenshot_path}")

finally:
    # Cerrar navegador
    driver.quit()

print("🎯 Prueba finalizada correctamente.")
