from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
import time

# Configurar opciones de Chrome
options = Options()
options.add_argument("--no-sandbox")
options.add_argument("--disable-dev-shm-usage")
options.add_argument("--disable-gpu")
options.add_argument("--remote-debugging-port=9222")
options.add_argument("--window-size=1280,800")

# Si estás en servidor sin entorno gráfico (como EC2)
options.add_argument("--headless=new")  # ejecuta sin interfaz

# Ruta del ChromeDriver
service = Service("/usr/local/bin/chromedriver")

print("🚀 Iniciando prueba con Google Chrome...")

# Iniciar navegador
driver = webdriver.Chrome(service=service, options=options)
driver.get("https://www.google.com")

print("✅ Página abierta:", driver.title)

# Esperar unos segundos y cerrar
time.sleep(3)
driver.quit()

print("🎯 Prueba finalizada correctamente.")
