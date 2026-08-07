# Actividad 2. Diseñar el acceso a la aplicación

## Situación

El equipo de desarrollo de **TxurdiGest** va a implementar el acceso a la aplicación.

Antes de comenzar a programar, es necesario decidir quién podrá acceder al sistema y qué acciones podrá realizar cada tipo de usuario.

## Actividad

En equipos de 3 o 4 personas, analizad vuestra aplicación y decidid:

- qué tipos de usuarios existirán;
- cómo se identificarán al iniciar sesión;
- qué información será necesario conservar durante la sesión;
- qué operaciones podrá realizar cada tipo de usuario;
- qué operaciones deberán estar prohibidas.

No es necesario diseñar la implementación. El objetivo es definir un modelo de autenticación y autorización que sirva de guía durante el desarrollo.

!!! tip "Una pregunta útil"

    Si un usuario no necesita realizar una determinada acción para desempeñar su función, probablemente no debería tener permiso para realizarla.

## Aplicación al reto

Revisad vuestro proyecto y comprobad:

- qué perfiles de usuario tendrá la aplicación;
- qué funcionalidades estarán disponibles para cada perfil;
- qué operaciones requerirán autenticación;
- cuáles requerirán además autorización.

## Errores habituales

- Asignar los mismos permisos a todos los usuarios.
- Crear un único perfil para simplificar el desarrollo.
- Pensar que ocultar un botón protege una funcionalidad.
- No comprobar los permisos en el servidor.

## Resumen

- Autenticar significa comprobar la identidad del usuario.
- Autorizar significa decidir qué puede hacer.
- Cada usuario debe disponer únicamente de los permisos necesarios.
- La comprobación definitiva de permisos siempre debe realizarse en el servidor.
