# Manual de Instalación: SQL Server 2022 Developer & SSMS 22

Este documento detalla el procedimiento técnico para configurar un entorno local de bases de datos utilizando la edición para desarrolladores de SQL Server 2022.

---

## 1. Fase de Preparación y Descarga
Para iniciar, es necesario obtener los medios de instalación completos (ISO) para asegurar una instalación sin interrupciones.

1.  **Ejecución del Asistente:** Se inicia con el archivo ejecutable de descarga rápida.
![Mi captura](/img/8.png)

2.  **Selección de Descarga:** En el menú principal, se debe elegir la opción **Descargar medios**.
![Mi captura](/img/9.png)
3.  **Configuración del Paquete:**
    * **Idioma:** Inglés.
    * **Formato:** ISO (Imagen de disco de 1109 MB).
    * **Ubicación:** Carpeta de descargas local 
    ![Mi captura](/img/10.png)
4.  **Finalización de Descarga:** El sistema notificará cuando la descarga del archivo `SQLServer2022-x64-ENU.iso` se haya completado con éxito.
![Mi captura](/img/11.png)

---

## 2. Montaje e Inicio del Instalador
Una vez obtenido el archivo ISO, se procede a preparar el entorno de instalación en Windows.
![Mi captura](/img/12.png)

1.  **Montar Imagen:** Haz clic derecho sobre el archivo ISO y selecciona la opción **Montar**  para habilitar la unidad virtual.
![Mi captura](/img/13.png)
2.  **Privilegios de Administrador:** Dentro de la unidad montada, localiza el archivo `setup`, haz clic derecho y selecciona **Ejecutar como administrador**.
![Mi captura](/img/15.png)
3.  **Centro de Instalación:** En la pestaña *Installation*, selecciona la primera opción: **New SQL Server standalone installation or add features to an existing installation**.
![Mi captura](/img/17.png)
![Mi captura](/img/18.png)
---

## 3. Configuración del Motor (Database Engine)

### Pasos Iniciales
 * **Edición:** Next

* **Developer** como la edición gratuita para fines de desarrollo.
![Mi captura](/img/19.png)
* **Licencia:** Acepta los términos y condiciones de Microsoft para continuar.
![Mi captura](/img/20.png)
* **Reglas de Instalación:** El sistema validará los requisitos. Si aparece una advertencia en el *Windows Firewall*, puedes ignorarla momentáneamente.
![Mi captura](/img/22.png)
* **Azure Extension:** Desmarca la casilla si no deseas conectar el servidor a servicios de Azure en la nube.
![Mi captura](/img/23.png)

### Selección de Características y Seguridad
1.  **Features:** Selecciona obligatoriamente **Database Engine Services** y **SQL Server Replication**.
![Mi captura](/img/24.png)
2.  **Autenticación:**
    * Selecciona **Mixed Mode** (Autenticación de Windows y SQL Server).
    * Define una contraseña para el usuario administrador (`sa`).
    * Haz clic en **Add Current User** para asignar permisos al usuario local `NOAM\DELL`.
    ![Mi captura](/img/25.png)
3.  **Ejecución:** Confirma el resumen de características e inicia la instalación.
![Mi captura](/img/26.png)

4.  **Éxito:** Verifica que todos los estados aparezcan como **Succeeded**.
![Mi captura](/img/28.png)

---

## 4. Instalación de SQL Server Management Studio (SSMS 22)

Para interactuar con la base de datos, se requiere la interfaz gráfica SSMS.

1.  **Descarga Herramientas:** En el instalador, haz clic en **Install SQL Server Management Tools**.
![Mi captura](/img/29.png)
2.  **Obtención del Instalador:** Descarga el instalador de **SSMS 22** desde la página oficial de Microsoft.
![Mi captura](/img/30.png)
3.  **Ejecución:** Una vez instalado, abre la aplicación desde el buscador de Windows.
![Mi captura](/img/31.png)

---

## 5. Conexión Final y Verificación
1.  **Conectar al Servidor:** En la ventana de login, coloca un punto (`.`) en el nombre del servidor para referirte al servidor local.
![Mi captura](/img/34.png)
2.  **Validación:** Una vez conectado, el **Explorador de Objetos** mostrará el servidor activo (versión `16.0.1000.6`) con el usuario `NOAM\DELL`.
![Mi captura](/img/35.png)

---