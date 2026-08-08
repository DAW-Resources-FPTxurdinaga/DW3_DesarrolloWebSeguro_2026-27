# Cabeceras de seguridad HTTP

Las cabeceras HTTP permiten que el servidor proporcione información adicional al navegador sobre cómo debe gestionar una respuesta.

Además de transportar datos, HTTP permite establecer determinadas políticas de seguridad que ayudan a reducir algunos riesgos durante la ejecución de una aplicación web.

Estas cabeceras forman parte de la configuración del despliegue.

## El servidor como origen de las políticas

Una aplicación web no solo debe generar contenido seguro.

También debe indicar al navegador qué comportamientos están permitidos.

Conceptualmente:

```text
Servidor

    ↓

Respuesta HTTP

    ↓

Cabeceras de seguridad

    ↓

Navegador aplica políticas
```

El servidor comunica determinadas restricciones al cliente.

## Cabeceras y desarrollo seguro

Las cabeceras de seguridad complementan otras medidas trabajadas anteriormente:

```text
Validación de entradas

        +

Salida segura

        +

Autenticación

        +

Configuración del servidor

        +

Cabeceras HTTP
```

No sustituyen al código seguro.

Son una capa adicional de protección.

## Content-Security-Policy (CSP)

La cabecera:

```http
Content-Security-Policy
```

permite definir desde qué orígenes pueden cargarse determinados recursos.

Puede controlar elementos como:

- scripts;
- estilos;
- imágenes;
- fuentes;
- conexiones externas.

Ejemplo conceptual:

```http
Content-Security-Policy:
default-src 'self'
```

Indica que, por defecto, los recursos deben proceder del propio origen.

## Relación con XSS

CSP puede ayudar a reducir el impacto de determinados ataques XSS.

Por ejemplo, una política restrictiva puede dificultar que un navegador ejecute scripts no autorizados.

Sin embargo:

```text
CSP

no sustituye

escape de salida + validación
```

La aplicación debe seguir generando contenido seguro.

## X-Content-Type-Options

La cabecera:

```http
X-Content-Type-Options
```

permite evitar que el navegador intente interpretar un recurso con un tipo diferente al declarado.

Ejemplo:

```http
X-Content-Type-Options: nosniff
```

Reduce ciertos comportamientos inesperados relacionados con la interpretación de contenidos.

## Strict-Transport-Security (HSTS)

La cabecera:

```http
Strict-Transport-Security
```

indica al navegador que debe utilizar HTTPS durante un periodo determinado.

Ejemplo:

```http
Strict-Transport-Security:
max-age=31536000
```

Esto ayuda a evitar accesos posteriores mediante HTTP.

Debe utilizarse únicamente cuando HTTPS está correctamente configurado.

## Referrer-Policy

Cuando un navegador realiza una petición desde una página a otra, puede enviar información sobre la página de origen.

La cabecera:

```http
Referrer-Policy
```

permite controlar qué información se comparte.

Ejemplo:

```http
Referrer-Policy: strict-origin
```

Reduce la cantidad de información enviada a otros sitios.

## Permissions-Policy

La cabecera:

```http
Permissions-Policy
```

permite controlar determinadas capacidades del navegador.

Ejemplos:

- cámara;
- micrófono;
- geolocalización.

Una aplicación que no utiliza una capacidad puede restringirla.

## Configuración desde el servidor

Estas cabeceras normalmente se configuran en:

- Apache;
- Nginx;
- servidores de aplicaciones;
- plataformas de despliegue.

Ejemplo conceptual en Apache:

```apache
Header always set X-Content-Type-Options "nosniff"
```

La ubicación exacta depende del servidor utilizado.

## No añadir cabeceras sin comprenderlas

Una mala práctica es copiar una lista de cabeceras sin conocer su efecto.

Cada política debe responder a una necesidad:

```text
¿Qué protege?

¿Qué puede romper?

¿La aplicación necesita esta funcionalidad?
```

Una configuración demasiado restrictiva puede impedir que la aplicación funcione correctamente.

## Comprobación en el navegador

Las cabeceras pueden revisarse mediante DevTools:

```text
Network

    ↓

Seleccionar petición

    ↓

Response Headers
```

También pueden comprobarse herramientas externas de análisis de configuración HTTPS y cabeceras.

## Ejemplo en TxurdiGest

Una respuesta HTTPS podría incluir:

```http
Content-Security-Policy: default-src 'self'

X-Content-Type-Options: nosniff

Referrer-Policy: strict-origin
```

El navegador recibe instrucciones adicionales sobre cómo interpretar la aplicación.

## Checklist

```text
[ ] HTTPS configurado correctamente

[ ] Cabeceras revisadas

[ ] CSP adaptada a la aplicación

[ ] No se utilizan políticas copiadas sin analizar

[ ] DevTools permite comprobar respuestas

[ ] La aplicación continúa funcionando después de aplicar políticas
```

## Idea clave

> Las cabeceras de seguridad permiten añadir políticas desde el servidor, pero funcionan como una capa complementaria: no sustituyen a un desarrollo seguro.
