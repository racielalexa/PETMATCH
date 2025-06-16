# PetMatch

PetMatch es una aplicación web para conectar mascotas con personas que desean adoptarlas. Permite a usuarios registrarse, solicitar adopciones, y a refugios administrar las solicitudes.

---

## Características principales

- Registro e inicio de sesión de usuarios y refugios.
- Listado y filtrado de mascotas disponibles para adopción.
- Solicitud de adopción para usuarios registrados.
- Gestión de solicitudes para administradores/refugios.
- Sistema CRUD para mascotas (sólo para administradores).
- Página para donaciones.
- Diseño responsive y moderno usando Bootstrap 5.

---

## Tecnologías utilizadas

- Java EE con Servlets y JSP
- MariaDB como base de datos
- JDBC para acceso a base de datos
- Bootstrap 5 para la interfaz
- HTML5, CSS3 y JavaScript

---

## Requisitos

- Java JDK 11 o superior
- Apache Tomcat 9 o superior
- MariaDB Server
- Maven
- 

---

## Instalación y configuración

1. **Base de datos**

   - Instala y configura MariaDB.
   - Crea la base de datos `petmatch`.
   - Ejecuta el script SQL que crea las tablas y datos iniciales.

2. **Configurar conexión a base de datos**

   - En el proyecto, verifica la clase `Database` donde configuras URL, usuario y contraseña MariaDB.
   - Ejemplo:
     ```java
     private static final String URL = "jdbc:mariadb://localhost:3306/petmatch";
     private static final String USER = "tu_usuario";
     private static final String PASSWORD = "tu_contraseña";
     ```

3. **Desplegar en Tomcat**

   - Copia el proyecto a la carpeta `webapps` de Tomcat o genera un WAR.
   - Inicia Tomcat y accede a `http://localhost:8080/petmatch`

4. **Uso**

Registro

Regístrate como usuario adoptante o como refugio (admin).

Completa el formulario con tus datos personales.

Inicio de sesión

Accede con tu email y contraseña.

Para usuarios (rol user)

Explora el listado de mascotas disponibles para adopción.

Filtra mascotas por especie, estado o refugio.

Solicita la adopción de una mascota mediante el botón Solicitar adopción.

Consulta el estado de tus solicitudes en la sección Mis Solicitudes.

Para refugios/admin (rol admin)

Gestiona las mascotas: agrega, edita o elimina registros.

Consulta todas las solicitudes de adopción realizadas por usuarios.

Aprueba o rechaza solicitudes desde la sección Solicitudes de Adopción.

Donaciones

Los usuarios pueden realizar donaciones para apoyar la causa desde la sección Contribuye.


## Estructura del proyecto

- `/src/main/java/com/svalero/petmatch/` - Código Java
- `/webapp/` - JSPs, recursos estáticos (CSS, JS, imágenes)
- `/WEB-INF/` - Configuraciones y archivos privados

---

## Contacto

Para dudas o contribuciones, contacta a:

- Autor: raciel uzcanga
- Email: racielalexah@gmail.com
---

## Licencia

Este proyecto está bajo la licencia MIT - ver archivo LICENSE para más detalles.

---

---

¡Gracias por usar PetMatch! 🐾❤️
