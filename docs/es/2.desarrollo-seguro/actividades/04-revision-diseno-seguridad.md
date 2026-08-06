# Actividad 4. Revisar el diseño de seguridad del proyecto

## Objetivos

Al finalizar esta actividad serás capaz de:

- Revisar las principales decisiones de seguridad tomadas durante el diseño de una aplicación.
- Detectar aspectos que todavía necesitan definirse.
- Preparar el proyecto para comenzar la fase de implementación.

---

## Contexto

Habéis finalizado el diseño de vuestra aplicación y estáis a punto de comenzar a programarla.

Es el momento de comprobar si las principales decisiones relacionadas con la seguridad ya están tomadas.

Corregir un problema durante el diseño siempre será más sencillo que hacerlo cuando la aplicación ya esté desarrollada.

---

## Actividad

Trabajad en equipos de 3 o 4 personas.

Revisad vuestro proyecto y comprobad si habéis definido los siguientes aspectos:

- qué datos recibirá vuestra aplicación;
- cómo validaréis esos datos;
- cómo informará la aplicación cuando ocurra un error;
- quién podrá iniciar sesión;
- qué tipos de usuarios existirán;
- qué podrá hacer cada uno de ellos;
- qué información sensible utilizará la aplicación;
- cómo separaréis el código de la configuración.

No es necesario que todas las decisiones sean definitivas.

El objetivo es detectar qué aspectos todavía necesitan ser revisados antes de comenzar a programar.

---

## ¿Cómo podéis abordarla?

Podéis seguir este orden:

1. Revisad los formularios principales de la aplicación.
2. Analizad cómo accederán los distintos tipos de usuario.
3. Comprobad si existen funcionalidades que deban protegerse.
4. Identificad la información sensible que utilizará la aplicación.
5. Elaborad una pequeña lista con las decisiones que todavía están pendientes.

!!! tip "Consejo"

    No intentéis revisar toda la aplicación con el mismo nivel de detalle.

    Empezad por las funcionalidades más importantes y dejad las menos críticas para una revisión posterior.

---

## Aplicación al reto

Antes de comenzar el siguiente sprint o fase de desarrollo, comprobad que el equipo tiene claras las decisiones principales relacionadas con la seguridad.

Si detectáis algún aspecto sin definir, añadid una tarea al backlog antes de comenzar la implementación.

Un pequeño esfuerzo ahora puede evitar muchos cambios durante el desarrollo.

---

## Errores habituales

Es frecuente cometer algunos de estos errores:

❌ Empezar a programar sin haber decidido cómo proteger la aplicación.

❌ Pensar que las decisiones de seguridad pueden dejarse para el final del proyecto.

❌ Descubrir durante el desarrollo que faltan roles, permisos o validaciones importantes.

❌ No revisar el diseño antes de comenzar la implementación.

---

## Para profundizar

Elegid una funcionalidad importante de vuestra aplicación.

Por ejemplo:

- gestión de usuarios;
- publicación de contenidos;
- gestión de reservas;
- administración de productos.

Intentad responder a esta pregunta:

> **¿Qué podría ocurrir si desarrolláramos esta funcionalidad sin aplicar ninguna medida de seguridad?**

Comentad vuestras respuestas con el resto del equipo.

---

## Qué debes recordar

- La seguridad comienza mucho antes de escribir código.
- Un buen diseño reduce errores y facilita el desarrollo.
- Revisar el proyecto antes de programar ayuda a detectar problemas cuando todavía son fáciles de corregir.
- Las decisiones tomadas en este bloque serán la base de la implementación del Bloque 3.