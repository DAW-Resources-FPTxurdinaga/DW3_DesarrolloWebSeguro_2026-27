# Actividad 3. Diseñar una configuración segura

## Objetivos

Al finalizar esta actividad serás capaz de:

- Identificar la información sensible de una aplicación web.
- Diferenciar el código fuente de la configuración.
- Decidir qué información debe mantenerse protegida.
- Preparar una configuración adecuada para los distintos entornos de trabajo.

---

## Contexto

El equipo de desarrollo de **TxurdiGest** va a comenzar el desarrollo de la aplicación.

Antes de escribir el código, quiere decidir qué información formará parte de la aplicación y cuál deberá mantenerse fuera del código fuente.

Tomar estas decisiones desde el principio evitará problemas de seguridad y facilitará el despliegue de la aplicación.

---

## Actividad

Trabajad en equipos de 3 o 4 personas.

Analizad vuestra aplicación y decidid:

- qué información utilizará la aplicación para funcionar;
- qué información es sensible;
- qué datos pueden formar parte del código fuente;
- qué datos deben mantenerse fuera del código;
- qué información cambiará entre los entornos de desarrollo y producción.

No es necesario decidir todavía cómo implementar esta configuración.

El objetivo es identificar correctamente qué información debe protegerse.

---

## ¿Cómo podéis abordarla?

Podéis seguir un proceso parecido al siguiente:

1. Haced una lista con toda la información que utilizará vuestra aplicación.
2. Marcad qué información podría comprometer la seguridad si se hiciera pública.
3. Pensad qué datos cambiarán cuando la aplicación pase de desarrollo a producción.
4. Decidid qué información nunca debería almacenarse directamente en el código.

!!! tip "Consejo"

    Preguntaos siempre:

    **¿Qué ocurriría si este repositorio fuera público durante unos minutos?**

    Si la respuesta es que alguien podría acceder a vuestra base de datos, utilizar una API en vuestro nombre o comprometer la aplicación, esa información no debería estar escrita directamente en el código.

---

## Aplicación al reto

Revisad vuestro proyecto y elaborad una pequeña lista con la información sensible que utilizará vuestra aplicación.

Comprobad que el equipo tiene claro:

- qué datos deberán protegerse;
- qué datos podrán cambiar según el entorno;
- qué información nunca debería subirse al repositorio.

Estas decisiones servirán como guía cuando configuréis la aplicación durante el Bloque 4.

---

## Errores habituales

Es frecuente cometer algunos de estos errores:

❌ Escribir la contraseña de la base de datos directamente en el código.

❌ Guardar claves API en un repositorio Git.

❌ Utilizar la misma configuración para desarrollo y producción.

❌ Pensar que un repositorio privado elimina la necesidad de proteger los secretos.

---

## Para profundizar

Buscad un proyecto desarrollado con PHP o Laravel.

Sin entrar a analizar el código, intentad identificar:

- dónde almacena la configuración;
- cómo separa el código de los datos de configuración;
- qué información cambia entre distintos entornos.

Comentad con vuestro equipo qué ventajas aporta esta organización.

---

## Qué debes recordar

- El código y la configuración cumplen funciones diferentes.
- La información sensible nunca debe formar parte del código fuente.
- Cada entorno puede necesitar una configuración distinta.
- Una buena gestión de la configuración facilita el mantenimiento y mejora la seguridad de la aplicación.