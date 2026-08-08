# Implementación de HTTPS y certificados

Activar HTTPS en producción implica configurar correctamente el servidor, instalar un certificado válido y comprobar que toda la aplicación utiliza comunicaciones seguras.

El objetivo no es únicamente que aparezca el candado del navegador, sino garantizar que:

- el dominio está correctamente identificado;
- la comunicación está cifrada;
- las cookies sensibles viajan protegidas;
- no existen accesos inseguros mediante HTTP.

## Certificado y clave privada

Un certificado TLS está formado por información pública que identifica al servidor.

La clave privada asociada permite demostrar la identidad del servidor durante la conexión.

La relación es:

```text
Certificado público
        +
Clave privada
        ↓
Comunicación HTTPS segura
```

La clave privada debe protegerse especialmente.

Nunca debe:

- incluirse en el repositorio;
- copiarse al código;
- compartirse innecesariamente.

## Instalación del certificado

El proceso habitual de despliegue es:

```text
Obtener certificado

        ↓

Instalar certificado en servidor web

        ↓

Configurar sitio HTTPS

        ↓

Reiniciar o recargar servidor

        ↓

Comprobar funcionamiento
```

La configuración concreta depende del servidor utilizado.

## Ejemplo conceptual con Apache

Un servidor Apache debe tener configurado un sitio HTTPS.

Conceptualmente:

```text
<VirtualHost *:443>

    ServerName txurdigest.ejemplo

    SSLEngine on

    SSLCertificateFile certificado.crt

    SSLCertificateKeyFile clave-privada.key

</VirtualHost>
```

Los nombres y rutas exactas dependen de la instalación.

Lo importante es comprender que:

- el certificado es público;
- la clave privada debe estar protegida;
- el servidor utiliza ambos para establecer HTTPS.

## Redirección HTTP a HTTPS

Después de activar HTTPS, no deberían mantenerse accesos inseguros mediante HTTP.

Una configuración habitual:

```text
Puerto 80
    ↓
Redirección 301
    ↓
Puerto 443
```

El usuario siempre termina utilizando HTTPS.

Ejemplo:

```text
http://txurdigest.ejemplo

        ↓

https://txurdigest.ejemplo
```

## Evitar contenido mixto

Una aplicación HTTPS puede perder parte de su protección si carga recursos mediante HTTP.

Ejemplo incorrecto:

```html
<script src="http://ejemplo.com/app.js"></script>
```

Aunque la página principal utilice HTTPS, ese recurso se solicita sin protección.

Debe utilizarse:

```html
<script src="https://ejemplo.com/app.js"></script>
```

o rutas relativas:

```html
<script src="/app.js"></script>
```

## Comprobación desde el navegador

Las herramientas del navegador permiten comprobar:

- certificado utilizado;
- peticiones HTTPS;
- recursos cargados;
- cookies enviadas.

Por ejemplo, en DevTools:

```text
Network

        ↓

comprobar protocolo HTTPS
```

También puede revisarse:

```text
Application

        ↓

Cookies

        ↓

atributo Secure
```

## Cookies de sesión y HTTPS

Una aplicación con sesiones debería proteger sus cookies.

Ejemplo:

```http
Set-Cookie:
session_id=abc123;
Secure;
HttpOnly;
SameSite=Lax
```

El atributo:

```text
Secure
```

evita enviar la cookie mediante conexiones HTTP.

HTTPS y una correcta configuración de cookies trabajan conjuntamente.

## Renovación automática

Los certificados tienen una duración limitada.

Un despliegue profesional debe contemplar:

```text
Certificado válido
        ↓
Fecha de caducidad
        ↓
Renovación
        ↓
Nueva comprobación
```

La renovación automática reduce el riesgo de interrupciones por certificados caducados.

## HTTPS en AWS

En despliegues habituales en AWS pueden existir diferentes posibilidades:

```text
Usuario

    ↓ HTTPS

Balanceador / servidor web

    ↓

Aplicación

    ↓

Base de datos privada
```

o:

```text
Usuario

    ↓ HTTPS

Servidor web Apache/Nginx

    ↓

Aplicación PHP/Laravel
```

La arquitectura concreta dependerá del despliegue realizado.

La decisión importante es que la comunicación externa esté protegida y que los servicios internos no estén innecesariamente expuestos.

## Verificación del despliegue

Antes de considerar HTTPS terminado:

```text
[ ] El dominio utiliza HTTPS

[ ] El certificado es válido

[ ] HTTP redirige a HTTPS

[ ] No existen recursos HTTP mezclados

[ ] La clave privada está protegida

[ ] Las cookies utilizan Secure cuando corresponde

[ ] El certificado tiene renovación prevista
```

## Ejemplo en TxurdiGest

Un despliegue correcto:

```text
Navegador

https://txurdigest.ejemplo

        ↓

Apache/Nginx

        ↓

Laravel/PHP

        ↓

Base de datos interna
```

El usuario nunca accede directamente a servicios internos.

La comunicación pública utiliza HTTPS.

## Idea clave

> Configurar HTTPS correctamente forma parte del despliegue seguro: no basta con instalar un certificado, hay que revisar todo el flujo de comunicación de la aplicación.
