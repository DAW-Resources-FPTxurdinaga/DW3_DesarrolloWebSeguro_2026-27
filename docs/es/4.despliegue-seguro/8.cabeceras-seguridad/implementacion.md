# Implementación de cabeceras de seguridad HTTP

Las cabeceras de seguridad se configuran normalmente en el servidor que entrega la aplicación.

El objetivo es que cada respuesta HTTP incluya políticas adecuadas para el navegador.

Flujo:

```text
Usuario

    ↓

Servidor web

    ↓

Respuesta HTTP

    ↓

Cabeceras de seguridad

    ↓

Navegador aplica restricciones
```

## Configuración en Apache

Apache permite añadir cabeceras mediante módulos de configuración.

Ejemplo:

```apache
Header always set X-Content-Type-Options "nosniff"
```

La respuesta del servidor incluirá:

```http
X-Content-Type-Options: nosniff
```

El navegador aplicará esa política.

## Configuración en Nginx

En Nginx se pueden añadir cabeceras mediante:

```nginx
add_header X-Content-Type-Options "nosniff";
```

La idea es la misma:

```text
Servidor

        ↓

Añade cabecera

        ↓

Cliente recibe política
```

## Content-Security-Policy

CSP es una de las cabeceras más importantes porque permite controlar qué recursos puede ejecutar o cargar el navegador.

Ejemplo inicial:

```http
Content-Security-Policy:
default-src 'self'
```

Significa:

```text
Por defecto

↓

Solo recursos del propio origen
```

## CSP y evolución de la aplicación

Una política CSP debe adaptarse a la aplicación real.

Una aplicación puede necesitar:

- scripts propios;
- hojas de estilo;
- imágenes;
- fuentes;
- APIs externas.

Por tanto, no debe aplicarse una política demasiado restrictiva sin comprobar el funcionamiento.

Ejemplo:

```text
Aplicación

        ↓

Revisar recursos utilizados

        ↓

Definir política adecuada
```

## Evitar configuraciones inseguras de CSP

Una configuración como:

```http
script-src 'unsafe-inline'
```

puede reducir la protección frente a determinados problemas.

Debe utilizarse únicamente cuando exista una necesidad concreta y comprendiendo sus consecuencias.

## HSTS

La cabecera:

```http
Strict-Transport-Security
```

indica al navegador que debe utilizar HTTPS.

Ejemplo:

```http
Strict-Transport-Security:
max-age=31536000
```

Antes de activarla deben comprobarse:

- HTTPS funciona correctamente;
- todos los recursos están disponibles mediante HTTPS;
- no existen partes de la aplicación que dependan de HTTP.

## X-Content-Type-Options

Configuración habitual:

```http
X-Content-Type-Options: nosniff
```

Evita que el navegador intente interpretar un recurso con un tipo diferente al declarado.

Es especialmente útil cuando la aplicación sirve:

- archivos;
- imágenes;
- documentos;
- recursos descargables.

## Referrer-Policy

Ejemplo:

```http
Referrer-Policy: strict-origin
```

Permite controlar la información que se envía cuando el usuario navega hacia otros sitios.

La política elegida debe equilibrar:

```text
Privacidad

        +

Necesidades funcionales
```

## Permissions-Policy

Una aplicación puede restringir capacidades del navegador que no utiliza.

Ejemplo conceptual:

```http
Permissions-Policy:
camera=(), microphone=()
```

Indica que la aplicación no necesita acceso a cámara ni micrófono.

## Comprobar cabeceras con DevTools

Las cabeceras pueden revisarse desde el navegador:

```text
DevTools

    ↓

Network

    ↓

Seleccionar petición

    ↓

Response Headers
```

Ejemplo:

```http
Content-Security-Policy

X-Content-Type-Options

Strict-Transport-Security
```

La comprobación permite verificar que el servidor está enviando realmente la configuración esperada.

## Comprobar desde línea de comandos

También pueden revisarse respuestas HTTP mediante herramientas como:

```bash
curl -I https://txurdigest.ejemplo
```

La respuesta mostrará las cabeceras enviadas por el servidor.

Ejemplo:

```http
HTTP/2 200

content-type: text/html

strict-transport-security: ...

x-content-type-options: nosniff
```

## Aplicación en Laravel

Las cabeceras pueden configurarse mediante:

- servidor web;
- middleware;
- configuración específica de la aplicación.

La decisión depende de dónde tenga más sentido aplicar la política.

Las cabeceras generales de seguridad suelen pertenecer al nivel de infraestructura.

## Ejemplo en TxurdiGest

Una respuesta del servidor podría incluir:

```http
Content-Security-Policy:
default-src 'self'

X-Content-Type-Options:
nosniff

Referrer-Policy:
strict-origin

Strict-Transport-Security:
max-age=31536000
```

El navegador recibe instrucciones sobre cómo debe tratar la aplicación.

## Revisar después de aplicar cabeceras

Después de añadir políticas debe comprobarse:

```text
[ ] La aplicación sigue cargando correctamente

[ ] Los scripts funcionan

[ ] Los estilos funcionan

[ ] Las imágenes funcionan

[ ] Las peticiones API funcionan

[ ] No aparecen errores CSP en consola
```

Una política de seguridad incorrecta puede romper funcionalidades legítimas.

## No utilizar cabeceras como sustituto del desarrollo seguro

Las cabeceras ayudan, pero no corrigen errores de programación.

Ejemplo:

```text
CSP

        +

Código vulnerable a XSS

```

sigue siendo una aplicación con problemas.

La solución principal continúa siendo:

- validación;
- salida segura;
- autenticación;
- autorización.

## Checklist

```text
[ ] HTTPS activo antes de utilizar HSTS

[ ] Cabeceras revisadas

[ ] CSP adaptada a la aplicación

[ ] No se han copiado políticas sin analizar

[ ] DevTools permite verificar respuestas

[ ] No se han roto funcionalidades

[ ] La configuración está documentada
```

## Idea clave

> Las cabeceras de seguridad permiten configurar cómo el navegador debe interpretar una aplicación, pero su eficacia depende de que el resto de medidas de seguridad estén correctamente implementadas.
