# Actividad 1. Diseñar un formulario seguro

## Objetivos

Al finalizar esta actividad serás capaz de:

- Identificar los datos que recibirá un formulario web.
- Diseñar una estrategia de validación antes de comenzar a programar.
- Diferenciar qué comprobaciones mejoran la experiencia del usuario y cuáles son necesarias para proteger la aplicación.
- Decidir cómo responderá la aplicación cuando un dato no sea válido.

---

## Contexto

El equipo de desarrollo de **TxurdiGest** va a implementar el formulario de alta de alumnado.

Antes de comenzar a programar, es necesario decidir cómo se tratarán los datos introducidos por los usuarios.

Un buen diseño evitará muchos problemas durante el desarrollo y facilitará el mantenimiento de la aplicación.

---

## Actividad

Trabajad en equipos de 3 o 4 personas.

Analizad el formulario de alta de alumnado y decidid:

- qué datos solicitará el formulario;
- qué campos serán obligatorios;
- qué reglas de validación tendrá cada dato;
- qué comprobaciones realizará JavaScript;
- qué comprobaciones realizará PHP;
- qué mensaje verá el usuario cuando un dato no sea válido.

No es necesario escribir código.

El objetivo es tomar decisiones que os servirán durante el desarrollo del proyecto.

---

## ¿Cómo podéis abordarla?

Si no sabéis por dónde empezar, podéis seguir este proceso:

1. Haced una lista con todos los datos que recibirá el formulario.
2. Pensad qué problemas podrían aparecer si alguno de esos datos fuera incorrecto.
3. Decidid qué condiciones debe cumplir cada dato para considerarlo válido.
4. Diferenciad qué comprobaciones pueden realizarse para ayudar al usuario y cuáles son imprescindibles para proteger la aplicación.
5. Pensad qué información necesitará el usuario para corregir el error.

No intentéis encontrar la solución perfecta. Lo importante es que todas las decisiones estén justificadas.

!!! tip "Consejo"

    Si dudáis sobre una validación, preguntad:

    **¿Qué ocurriría si un usuario modificara manualmente este dato antes de enviarlo al servidor?**

---

## Aplicación al reto

Elegid uno de los formularios de vuestro proyecto y repetid el mismo proceso.

Cuando terminéis, comprobad que el equipo tiene claro:

- qué datos recibirá el formulario;
- qué reglas de validación tendrá cada uno;
- qué validaciones realizará JavaScript;
- qué validaciones realizará PHP.

Estas decisiones servirán como guía durante el Bloque 3.

---

## Errores habituales

Es frecuente cometer algunos de estos errores:

❌ Pensar que los datos recibidos desde el navegador son fiables.

❌ Validar únicamente en JavaScript.

❌ Diseñar las validaciones cuando el formulario ya está programado.

❌ Mostrar mensajes como:

> "Error SQL en la línea 42."

El usuario debe recibir un mensaje claro que le ayude a corregir el problema. La información técnica debe registrarse internamente.

---

## Para profundizar

Elegid otro formulario de vuestra aplicación y repetid el mismo proceso.

Después comparad las decisiones tomadas en ambos casos.

¿Habéis utilizado los mismos criterios de validación?

Si la respuesta es no, justificad el motivo.

---

## Qué debes recordar

- Todos los datos recibidos desde el navegador deben considerarse no confiables.
- Diseñar la validación antes de programar evita muchos errores.
- JavaScript puede ayudar al usuario, pero nunca sustituye la validación realizada en el servidor.
- Una buena validación mejora la calidad y la seguridad de la aplicación.