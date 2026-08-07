# Actividad 3. Diseñar una configuración segura

## Situación

El equipo de desarrollo de **TxurdiGest** va a comenzar el desarrollo de la aplicación.

Antes de escribir el código, debe decidir qué información formará parte de la aplicación y cuál deberá mantenerse fuera del código fuente.

## Actividad

En equipos de 3 o 4 personas, analizad vuestra aplicación y decidid:

- qué información necesita para funcionar;
- qué datos son sensibles;
- qué información puede formar parte del código fuente;
- qué información debe mantenerse fuera del código;
- qué valores cambiarán entre los entornos de desarrollo, pruebas y producción.

No es necesario definir la implementación. El objetivo es identificar correctamente la información que debe protegerse.

!!! tip "Una pregunta útil"

    ¿Qué ocurriría si este repositorio fuese público durante unos minutos?

## Aplicación al reto

Comprobad que el equipo tiene claro:

- qué datos deberán protegerse;
- qué datos cambiarán según el entorno;
- qué información nunca debería subirse al repositorio.

## Errores habituales

- Escribir contraseñas o claves directamente en el código.
- Guardar secretos en un repositorio Git.
- Utilizar la misma configuración para todos los entornos.
- Pensar que un repositorio privado elimina la necesidad de proteger los secretos.

## Resumen

- El código y la configuración deben mantenerse separados.
- La información sensible nunca debe formar parte del código fuente.
- Cada entorno puede necesitar una configuración diferente.
- Una buena gestión de la configuración mejora la seguridad y facilita el despliegue.
