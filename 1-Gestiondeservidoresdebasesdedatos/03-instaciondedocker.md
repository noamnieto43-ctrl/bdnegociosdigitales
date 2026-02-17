# 🐳 Manual de Instalación: Docker Desktop en Windows

Este manual describe el proceso paso a paso para instalar Docker Desktop, utilizando como referencia las capturas del proceso de configuración técnica.

---

## 1. Descarga e inicio del instalador
* Diríjase al sitio oficial y seleccione la opción **"Escritorio Docker para Windows - x86_64"**.
* Ubique el archivo ejecutable denominado `Docker Desktop Installer.exe` en su carpeta de descargas para comenzar.

![Página de descarga oficial](/img/40.png)
![Instalador descargado](/img/41.png)

---

## 2. Ejecución de la aplicación
* Una vez terminada la instalación, busque **"Docker Desktop"** en el menú de inicio de Windows para abrir el programa.

![Buscador de Windows](/img/42.png)

---

## 3. Actualización de WSL (Subsistema de Windows para Linux)
* Si el sistema indica que el **Subsistema de Windows para Linux (WSL)** requiere una actualización, observe el mensaje instructivo en la terminal de comandos.
* Ejecute el comando `wsl.exe --update` tal como se solicita para poder continuar con el proceso.
* Asegúrese de que la descarga de los componentes de WSL (específicamente la versión 2.6.3) se complete correctamente en su equipo.

![Mensaje de error WSL](/img/43.png)
![Progreso de descarga](/img/44.png)

---

## 4. Configuración de usuario y servicios
* En la pantalla de inicio de sesión, puede optar por omitir el registro seleccionando el botón **"Skip"** ubicado en la esquina superior derecha.
* Espere a que aparezca el mensaje informativo **"Starting the Docker Engine..."**, lo que indica que los servicios de contenedores se están activando.

![Omitir registro](/img/45.png)
![Arranque de servicios](/img/46.png)

---

## 5. Panel de bienvenida e integración de recursos
* Al finalizar el arranque, accederá al panel principal de configuración donde podrá gestionar los recursos del sistema y la integración con otras herramientas de desarrollo como VS Code.

![Panel de bienvenida](/img/47.png)