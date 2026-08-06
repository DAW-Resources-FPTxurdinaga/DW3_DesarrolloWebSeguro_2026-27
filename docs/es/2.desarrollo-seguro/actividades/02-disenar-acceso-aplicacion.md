# Actividad 2. Diseñar el acceso a la aplicación

## Objetivos

Al finalizar esta actividad serás capaz de:

- Identificar los diferentes tipos de usuarios de una aplicación.
- Diseñar un sistema de acceso adecuado para cada perfil.
- Definir qué operaciones podrá realizar cada usuario.
- Preparar las decisiones que implementarás posteriormente durante el desarrollo del proyecto.

---

## Contexto

El equipo de desarrollo de **TxurdiGest** va a comenzar la implementación del acceso a la aplicación.

Antes de programar el inicio de sesión, es necesario decidir quién podrá acceder a la aplicación y qué podrá hacer cada usuario una vez haya iniciado sesión.

Un buen diseño evitará problemas de seguridad y facilitará el desarrollo posterior.

---

## Actividad

Trabajad en equipos de 3 o 4 personas.

Analizad vuestra aplicación y decidid:

- qué tipos de usuarios existirán;
- cómo se identificarán al iniciar sesión;
- qué información será necesario conservar durante la sesión;
- qué operaciones podrá realizar cada tipo de usuario;
- qué operaciones deberán estar prohibidas.

No es necesario pensar todavía en cómo programar estas funcionalidades.

El objetivo es definir un diseño claro que sirva como guía durante la implementación.

---

## ¿Cómo podéis abordarla?

Podéis seguir un proceso parecido al siguiente:

1. Haced una lista con todos los usuarios que utilizarán la aplicación.
2. Agrupad aquellos que tengan responsabilidades similares.
3. Para cada tipo de usuario, decidid qué acciones necesita realizar para cumplir su trabajo.
4. Preguntaos si existe alguna acción que no debería poder realizar.
5. Revisad si algún usuario tiene más permisos de los realmente necesarios.

No existe una única solución correcta. Lo importante es justificar las decisiones tomadas.

!!! tip "Consejo"

    Si un usuario no necesita realizar una determinada acción para desempeñar su función, probablemente no debería tener permiso para realizarla.

---

## Aplicación al reto

Revisad vuestro proyecto y elaborad una lista con:

- los perfiles de usuario que tendrá la aplicación;
- las funcionalidades disponibles para cada uno;
- las operaciones que requerirán autenticación;
- las operaciones que requerirán autorización.

Estas decisiones servirán como guía cuando implementéis el sistema de acceso durante el Bloque 3.

---

## Errores habituales

Es frecuente cometer algunos de estos errores:

❌ Pensar que todos los usuarios necesitan los mismos permisos.

❌ Crear un único perfil de usuario para simplificar el desarrollo.

❌ Ocultar un botón en la interfaz y pensar que la funcionalidad ya está protegida.

❌ No comprobar los permisos antes de realizar una operación en el servidor.

---

## Para profundizar

Elegid una funcionalidad importante de vuestra aplicación.

Por ejemplo:

- modificar una calificación;
- eliminar un usuario;
- cambiar una contraseña;
- descargar un informe.

Preguntad:

- ¿Quién debería poder realizar esta acción?
- ¿Quién no debería poder realizarla?
- ¿Qué ocurrirá si un usuario intenta acceder sin tener permiso?

Comentad vuestras respuestas con el resto del equipo.

---

## Qué debes recordar

- Autenticar significa comprobar la identidad de un usuario.
- Autorizar significa comprobar qué puede hacer ese usuario.
- Cada usuario debe disponer únicamente de los permisos que necesita.
- La comprobación definitiva de permisos siempre debe realizarse en el servidor.