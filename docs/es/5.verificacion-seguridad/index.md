# Verificación de la seguridad

Una medida de seguridad no debe darse por válida únicamente porque haya sido diseñada o implementada.

Debe comprobarse que funciona realmente.

```text
Diseñar

    ↓

Implementar

    ↓

Desplegar

    ↓

Verificar
```

La verificación permite comparar lo que esperamos que haga la aplicación con su comportamiento real.

## Verificar no es atacar

En este módulo la verificación se aborda desde el punto de vista del desarrollo seguro.

El objetivo no es realizar pentesting profesional ni intentar comprometer sistemas ajenos.

Se trata de responder preguntas concretas:

```text
¿Los datos se validan realmente en el servidor?

¿Un usuario solo puede acceder a los recursos permitidos?

¿Las consultas a la base de datos están protegidas?

¿Los secretos están fuera del código?

¿La configuración de producción es adecuada?

¿Los errores evitan mostrar información sensible?
```

La comprobación se realiza únicamente sobre aplicaciones propias, entornos educativos o sistemas expresamente autorizados.

## Qué verificamos

La revisión puede realizarse en tres niveles.

### Código

Comprobar decisiones de implementación:

- validación de entradas;
- salida segura;
- acceso a datos;
- autenticación;
- autorización;
- sesiones;
- archivos;
- APIs;
- secretos;
- gestión de errores.

### Comportamiento

Comprobar qué ocurre ante casos válidos y ante situaciones que deben rechazarse.

Por ejemplo:

```text
Entrada inválida

Acceso sin autenticación

Identificador manipulado

Recurso de otro usuario

Archivo no permitido
```

### Despliegue

Comprobar que las decisiones de seguridad se mantienen en producción:

- HTTPS;
- configuración de producción;
- secretos;
- superficie de exposición;
- permisos;
- base de datos;
- cabeceras;
- errores y logs.

## Método de verificación

Una comprobación útil sigue un proceso sencillo:

```text
Control esperado

        ↓

Prueba

        ↓

Resultado obtenido

        ↓

Comparación

        ↓

Evidencia
```

Si el resultado no coincide con lo esperado:

```text
Detectar

    ↓

Corregir

    ↓

Repetir la prueba
```

La verificación forma parte del desarrollo, no únicamente de la entrega final.

## Aplicación en los retos

Este bloque proporciona el método de revisión.

Las comprobaciones se aplicarán sobre los proyectos desarrollados en los dos retos del curso.

### Reto 1 — PHP, JavaScript y CSS3

La verificación permitirá comprobar, entre otros aspectos:

- validación JavaScript como apoyo a la experiencia de usuario;
- validación real en PHP;
- salida segura;
- acceso seguro a la base de datos;
- autenticación y sesiones;
- autorización;
- gestión de errores;
- secretos y configuración;
- despliegue mediante HTTPS.

### Reto 2 — Laravel, Vue 3 y Tailwind

La verificación se aplicará a aspectos como:

- validación en Vue como apoyo a la interfaz;
- validación en Laravel como control del servidor;
- autenticación y autorización;
- protección de recursos;
- APIs y respuestas HTTP;
- CORS cuando corresponda;
- variables de entorno y secretos;
- configuración y despliegue de producción.

No se realizará una actividad final independiente del bloque.

La revisión, las pruebas y las evidencias se integrarán en los propios retos.

## Herramientas

Se utilizarán principalmente herramientas ya conocidas:

- Chrome DevTools;
- Burp Suite;
- DVWA como laboratorio de referencia;
- logs;
- `curl` cuando resulte útil.

La herramienta se elige según la pregunta que queremos responder.

## Evidencias

Una evidencia permite demostrar el resultado de una comprobación.

Puede ser:

- una petición y su respuesta;
- una captura de DevTools;
- una cabecera HTTP;
- un fragmento de configuración sin secretos;
- un resultado de prueba;
- un fragmento de log anonimizado;
- una checklist.

Las evidencias deben ser breves, relevantes y seguras.

## Contenidos del bloque

1. introducción a la verificación de la seguridad;
2. revisión de código;
3. pruebas de seguridad;
4. herramientas de verificación;
5. revisión del despliegue;
6. checklist de seguridad;
7. evidencias de seguridad;
8. conclusiones.

## Idea clave

> La seguridad no debe suponerse. Debe comprobarse mediante revisiones, pruebas y evidencias.
