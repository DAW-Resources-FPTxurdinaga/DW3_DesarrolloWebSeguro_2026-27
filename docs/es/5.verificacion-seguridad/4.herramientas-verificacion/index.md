# Herramientas de verificación

Las herramientas ayudan a observar cómo se comporta realmente una aplicación.

No sustituyen el conocimiento del desarrollador.

Sirven para responder preguntas concretas como:

```text
¿Qué petición se ha enviado?

¿Qué datos contiene?

¿Qué cabeceras devuelve el servidor?

¿Qué cookies se están utilizando?

¿Qué ocurre si modificamos un parámetro?

¿Qué error devuelve la aplicación?
```

En este módulo utilizaremos principalmente herramientas ya conocidas.

## Chrome DevTools

Chrome DevTools permite observar el comportamiento del navegador y de las peticiones HTTP.

Las secciones más útiles para la verificación son:

- Network;
- Application;
- Console.

## Network

La pestaña Network permite revisar las peticiones realizadas por la aplicación.

Puede mostrar:

- URL;
- método HTTP;
- código de estado;
- cabeceras;
- parámetros;
- cuerpo de la petición;
- respuesta.

Ejemplo:

```text
POST /login

Status: 200
```

También permite detectar situaciones como:

```text
HTTP en lugar de HTTPS

errores 4xx

errores 5xx

peticiones inesperadas
```

## Headers

Dentro de una petición pueden revisarse:

```text
Request Headers

Response Headers
```

Esto permite comprobar, por ejemplo:

- cabeceras de seguridad;
- tipo de contenido;
- origen;
- cookies;
- autorización.

## Payload

La pestaña Payload permite observar los datos enviados.

Ejemplo:

```json
{
  "email": "usuario@ejemplo.com",
  "personas": 2
}
```

Es útil para verificar exactamente qué información llega al servidor.

## Response

La respuesta permite comprobar:

- datos devueltos;
- mensajes de error;
- información interna expuesta;
- códigos de estado.

Una aplicación segura debe evitar devolver información innecesaria.

## Application

La sección Application permite observar información almacenada en el navegador.

Especialmente:

- cookies;
- almacenamiento local;
- almacenamiento de sesión.

En este módulo interesa especialmente comprobar atributos de cookies:

```text
Secure

HttpOnly

SameSite
```

## Console

La consola puede mostrar:

- errores JavaScript;
- advertencias;
- problemas CSP;
- recursos bloqueados.

Ejemplo:

```text
Refused to load script because it violates Content-Security-Policy
```

Este tipo de mensaje puede ayudar a verificar una política CSP.

## Burp Suite

Burp Suite permite interceptar y modificar peticiones HTTP.

En este módulo se utiliza como herramienta de observación y verificación.

No se pretende realizar pentesting avanzado.

Flujo básico:

```text
Navegador

    ↓

Burp Proxy

    ↓

Servidor
```

Burp permite observar la petición antes de que llegue al servidor.

## Interceptar una petición

Ejemplo:

```text
POST /reservas
```

Datos:

```text
fecha=2026-08-10

personas=2
```

Burp permite modificar:

```text
personas=2
```

por:

```text
personas=-5
```

y comprobar si el servidor valida correctamente el dato.

## Repeater

Burp Repeater permite reenviar una petición varias veces modificando algunos valores.

Es útil para comprobar:

- identificadores;
- parámetros;
- cabeceras;
- autenticación;
- autorización;
- validación.

Ejemplo:

```text
GET /reservas/25
```

Modificar:

```text
25 → 26
```

y observar el resultado.

## DVWA

DVWA es una aplicación deliberadamente vulnerable.

Durante el módulo se utiliza como laboratorio controlado para comprender determinados errores de implementación.

Se ha utilizado especialmente para:

- XSS;
- SQL Injection;
- subida insegura de archivos.

DVWA no representa una aplicación que deba desplegarse en producción.

Su función es permitir observar:

```text
Implementación vulnerable

        ↓

Comportamiento

        ↓

Corrección
```

## Logs

Los logs también son una herramienta de verificación.

Permiten comprobar qué ha ocurrido en el servidor aunque el usuario reciba un mensaje genérico.

Ejemplo:

```text
Usuario

No se ha podido completar la operación
```

Mientras:

```text
Log interno

fecha

usuario

operación

error técnico
```

La revisión debe evitar utilizar logs que expongan secretos.

## Herramientas de línea de comandos

Algunas comprobaciones sencillas pueden realizarse mediante herramientas como `curl`.

Ejemplo:

```bash
curl -I https://txurdigest.ejemplo
```

Puede utilizarse para revisar cabeceras HTTP.

También puede enviarse una petición:

```bash
curl https://txurdigest.ejemplo/api/reservas
```

No es necesario dominar todas las opciones de `curl`.

El objetivo es comprender que una aplicación puede verificarse sin depender únicamente de su interfaz gráfica.

## Elegir la herramienta según la pregunta

No todas las herramientas sirven para lo mismo.

| Necesidad | Herramienta |
|---|---|
| Observar peticiones | DevTools Network |
| Revisar cookies | DevTools Application |
| Revisar errores JavaScript o CSP | DevTools Console |
| Modificar una petición | Burp Suite |
| Repetir una petición | Burp Repeater |
| Analizar vulnerabilidades en laboratorio | DVWA |
| Revisar errores internos | Logs |
| Consultar cabeceras rápidamente | curl |

La herramienta debe elegirse después de definir qué se quiere comprobar.

## No confundir herramienta con objetivo

Una mala aproximación sería:

```text
Abrir Burp

        ↓

Probar cosas
```

Una aproximación más útil:

```text
Objetivo:

comprobar autorización

        ↓

Herramienta:

Burp Repeater

        ↓

Prueba:

cambiar ID del recurso

        ↓

Resultado esperado:

403
```

La herramienta está al servicio de la prueba.

## Evidencias

Las herramientas también permiten obtener evidencias.

Por ejemplo:

- captura de Network;
- respuesta 403;
- cabeceras HTTP;
- cookie segura;
- petición modificada;
- fragmento de log anonimizado.

Las evidencias deben mostrar únicamente la información necesaria.

No deben incluir:

- contraseñas;
- tokens completos;
- cookies de sesión completas;
- claves API;
- secretos.

## Aplicación a TxurdiGest

Para una funcionalidad de reservas podrían utilizarse:

```text
DevTools

→ observar petición


Burp Suite

→ modificar ID o datos


Servidor

→ responder


DevTools/Burp

→ comprobar código de estado


Logs

→ comprobar error interno si procede
```

El objetivo es obtener una evidencia clara de que el control funciona.

## Idea clave

> Una herramienta de seguridad es útil cuando responde a una pregunta concreta. Primero se define qué queremos verificar y después se elige la herramienta adecuada.
