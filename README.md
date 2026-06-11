<div align="center">
  <h1>🛡️ JohaScanner - Escáner de Red y Puertos Local</h1>
  <p><strong>Herramienta automatizada de reconocimiento y descubrimiento de activos en PowerShell 🇩🇴</strong></p>

  🗣️ <strong>Desarrollado por JohaSecurity TOL</strong>
</div>

---

## 🚀 Descripción
**JohaScanner** es un script ligero y ultra veloz desarrollado en PowerShell diseñado para auditorías de seguridad informática y administración de redes. 

La herramienta automatiza el proceso de **Descubrimiento de Activos (Asset Discovery)** mediante el envío de solicitudes ICMP (.NET Ping) adaptadas para redes locales (LAN). Si detecta un dispositivo activo, realiza un escaneo rápido de sockets sobre los puertos más críticos y explotados en ciberseguridad para identificar vectores potenciales de ataque.

---

## 🛠️ Características Principales
* **Cálculo Automático:** Identifica tu IP local y calcula automáticamente el rango de red de tu subred para iniciar el escaneo (`/24`).
* **Optimizado para Redes LAN:** Configurado con tiempos de espera asíncronos cortos (50ms - 60ms) para mapear las 254 direcciones IP en un tiempo récord.
* **Compatibilidad Universal:** Escrito utilizando clases nativas de `.NET` (`System.Net.NetworkInformation.Ping`), lo que garantiza su funcionamiento tanto en **Windows PowerShell 5.1** como en **PowerShell 7+**.
* **Detección de Servicios Críticos:** Escanea puertos clave:
  * `22` - SSH (Acceso Remoto Linux/Unix)
  * `80` - HTTP (Servidores Web locales)
  * `443` - HTTPS (Servidores Web Seguros)
  * `445` - SMB (Servicio de compartición de Windows, propenso a vulnerabilidades como EternalBlue)
  * `3389` - RDP (Escritorio Remoto de Windows)

---

## 💻 Requisitos de Ejecución
* **Sistema Operativo:** Windows 10 / Windows 11 o Windows Server.
* **Consola:** PowerShell (Ejecutado como Administrador).

---

## 🚀 Guía de Uso Rápido

1. **Clona el repositorio u obtén el script:**
   ```powershell
   git clone https://github.com/JohawebK/-JohaScanner---Esc-ner-de-Red-y-Puertos-Local.git
   cd JohaScanner
   ```

2. **Habilita los permisos de ejecución temporales:**
   Por defecto, Windows bloquea los scripts descargados de internet. Habilita la sesión actual ejecutando:
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force
   ```

3. **Ejecuta la herramienta:**
   ```powershell
   .\JohaScanner.ps1
   ```

---

## 📊 Ejemplo de Salida (Output)
<img width="1114" height="544" alt="image" src="https://github.com/user-attachments/assets/32218cbf-0721-402a-b353-5703b09dfaa9" />

---

## ⚠️ Descargo de Responsabilidad (Disclaimer)
Este software ha sido creado exclusivamente con fines educativos, de aprendizaje técnico y auditoría autorizada de sistemas informáticos. El uso de esta herramienta contra redes o infraestructuras sin el consentimiento previo y explícito de sus propietarios es estrictamente ilegal. El desarrollador no se hace responsable de daños o usos inadecuados de este script.
