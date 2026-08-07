# Actividad 1. Diseñar un formulario seguro

## Situación

El equipo de desarrollo de **TxurdiGest** va a implementar el formulario de alta de alumnado.

Antes de comenzar a programar, conviene decidir cómo se validarán los datos que recibirá la aplicación.

## Actividad

En equipos de 3 o 4 personas, analizad el formulario y decidid:

- qué datos solicitará;
- qué campos serán obligatorios;
- qué reglas de validación tendrá cada dato;
- qué comprobaciones realizará JavaScript;
- qué comprobaciones realizará el servidor;
- qué mensaje recibirá el usuario cuando un dato no sea válido.

No es necesario escribir código. El objetivo es definir las decisiones de diseño que servirán de guía durante la implementación.

!!! tip "Una pregunta útil"

    ¿Qué ocurriría si un usuario modificara manualmente un dato antes de enviarlo al servidor?

## Aplicación al reto

Repetid el mismo análisis sobre uno de los formularios de vuestro proyecto.

Comprobad que todo el equipo tiene claro:

- qué datos recibirá el formulario;
- cómo se validará cada uno;
- qué validaciones se realizarán en el navegador;
- cuáles deberán comprobarse obligatoriamente en el servidor.

## Errores habituales

- Confiar en los datos recibidos desde el navegador.
- Validar únicamente con JavaScript.
- Diseñar la validación cuando el formulario ya está terminado.
- Mostrar mensajes de error técnicos al usuario.

## Resumen

- Todos los datos recibidos deben considerarse no confiables.
- La validación debe diseñarse antes de implementar el formulario.
- JavaScript mejora la experiencia del usuario, pero no sustituye la validación del servidor.
