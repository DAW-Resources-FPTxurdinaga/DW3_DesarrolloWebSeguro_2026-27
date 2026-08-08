# Verificación de la seguridad

Una aplicación no puede considerarse segura únicamente porque se hayan aplicado medidas de seguridad durante el diseño, la implementación o el despliegue.

Es necesario comprobar que esas medidas funcionan realmente.

```text
Diseñar

    ↓

Implementar

    ↓

Desplegar

    ↓

Verificar
```

La verificación permite detectar errores antes de que lleguen a los usuarios y comprobar que las decisiones tomadas durante el desarrollo se mantienen en el producto final.

## Verificar no es atacar

En este módulo la verificación de seguridad se aborda desde el punto de vista del desarrollo.

El objetivo no es realizar pentesting profesional ni intentar comprometer sistemas ajenos.

El objetivo es comprobar preguntas como:

```text
¿La entrada se valida realmente?

¿Un usuario puede acceder únicamente a sus recursos?

¿Las consultas a la base de datos están protegidas?

¿Los secretos están fuera del código?

¿La aplicación funciona únicamente mediante HTTPS?

¿Los errores muestran información sensible?
```

Verificar significa comprobar que los controles definidos funcionan en situaciones reales.

## Qué debemos verificar

La revisión de una aplicación puede realizarse en diferentes niveles.

### Código

Comprobar decisiones de implementación:

- validación de entradas;
- salida segura;
- consultas preparadas;
- autenticación;
- autorización;
- gestión de sesiones;
- subida de archivos;
- gestión de errores.

### Comportamiento

Comprobar qué ocurre cuando el usuario realiza acciones inesperadas.

Por ejemplo:

```text
Enviar un dato inválido

Intentar acceder sin autenticación

Modificar un identificador

Solicitar un recurso de otro usuario

Enviar un archivo no permitido
```

Una aplicación segura debe responder de forma controlada.

### Despliegue

Comprobar que la configuración de producción mantiene las medidas de seguridad:

- HTTPS;
- secretos fuera del código;
- depuración desactivada;
- permisos adecuados;
- base de datos protegida;
- cabeceras de seguridad;
- logs configurados.

## Pruebas positivas y negativas

Las pruebas funcionales habituales comprueban que una operación funciona correctamente.

Ejemplo:

```text
Usuario válido

        ↓

Inicio de sesión correcto
```

La verificación de seguridad también debe comprobar situaciones que deberían ser rechazadas.

```text
Usuario no autenticado

        ↓

Acceso a recurso protegido

        ↓

Acceso denegado
```

Estas pruebas permiten comprobar el comportamiento de la aplicación ante entradas o acciones no previstas.

## Herramientas de apoyo

Durante el módulo ya se han utilizado herramientas que permiten observar y verificar el comportamiento de una aplicación.

Entre ellas:

- Chrome DevTools;
- Burp Suite;
- DVWA;
- herramientas del navegador;
- logs de la aplicación y del servidor.

En este bloque no se pretende aprender muchas herramientas nuevas.

El objetivo es utilizar las herramientas conocidas para comprobar decisiones concretas de seguridad.

## Revisión de código

Muchas vulnerabilidades pueden detectarse revisando el código antes de desplegarlo.

Una revisión puede comprobar, por ejemplo:

```text
¿Se confía directamente en datos recibidos?

¿Se construyen consultas SQL concatenando valores?

¿Se comprueba la autorización antes de acceder a un recurso?

¿Existen secretos escritos en el código?

¿Se muestran excepciones directamente al usuario?
```

La revisión puede realizarla:

- el propio desarrollador;
- otro miembro del equipo;
- otro equipo.

La revisión entre iguales ayuda a detectar problemas que el autor del código puede no haber visto.

## Evidencias

En un proyecto profesional no basta con afirmar:

> La aplicación es segura.

Debe poder demostrarse qué se ha comprobado.

Una evidencia puede ser:

- una captura de DevTools;
- una petición y su respuesta;
- un fragmento de configuración;
- un resultado de prueba;
- un checklist completado;
- una explicación breve de una corrección realizada.

La evidencia debe ser suficiente para justificar la decisión, pero no necesita convertirse en un informe extenso.

## Integración con los retos ETHAZI

La verificación debe formar parte del desarrollo del reto.

No debería realizarse únicamente al final.

```text
Implementar funcionalidad

        ↓

Revisar

        ↓

Probar

        ↓

Corregir

        ↓

Continuar desarrollando
```

De esta forma, la seguridad se incorpora al ciclo normal de trabajo del equipo.

## Contenidos del bloque

En este bloque se trabajará:

1. revisión de código;
2. pruebas de seguridad;
3. herramientas de verificación;
4. revisión del despliegue;
5. checklist de seguridad;
6. evidencias de seguridad;
7. revisión final del proyecto.

El objetivo final es que el alumnado sea capaz de revisar una aplicación web y justificar que las principales decisiones de seguridad han sido comprobadas.

## Idea clave

> La seguridad no debe suponerse. Debe verificarse mediante revisiones, pruebas y evidencias.
