# HTTPS y certificados

HTTPS es el mecanismo que permite proteger la comunicación entre el navegador y el servidor mediante cifrado y autenticación.

En el Bloque 1 se estudió el funcionamiento conceptual de HTTPS y la cadena de confianza de certificados.

En este capítulo nos centramos en su aplicación durante el despliegue:

- activar HTTPS en producción;
- configurar correctamente el servidor;
- utilizar certificados válidos;
- redirigir tráfico inseguro;
- comprobar que la aplicación funciona correctamente sobre HTTPS.

## De HTTP a HTTPS

Una aplicación publicada mediante HTTP transmite las comunicaciones sin protección criptográfica.

```text
Cliente
   |
   | HTTP
   |
Servidor
```

Esto puede permitir que la información sea observada o modificada durante la comunicación.

HTTPS añade una capa de protección:

```text
Cliente
   |
   | HTTPS
   |
Servidor
```

La comunicación queda protegida mediante TLS.

## HTTPS en producción

Durante el desarrollo es habitual utilizar:

```text
http://localhost
```

o certificados de prueba.

Sin embargo, una aplicación accesible por usuarios reales debe utilizar:

```text
https://dominio-ejemplo.com
```

El despliegue debe incluir:

- certificado válido;
- configuración del servidor web;
- renovación del certificado;
- redirección del tráfico HTTP.

## Certificados digitales

Un certificado permite asociar una identidad digital con un servidor.

Conceptualmente:

```text
Servidor
    ↓
Certificado digital
    ↓
Autoridad de Certificación
    ↓
Confianza del navegador
```

El navegador comprueba que:

- el certificado es válido;
- pertenece al dominio solicitado;
- está firmado por una autoridad reconocida;
- no ha caducado.

## Obtener un certificado

En un entorno real, los certificados suelen obtenerse mediante una Autoridad de Certificación.

Una opción habitual es utilizar certificados emitidos por:

```text
Let's Encrypt
```

Estos certificados son reconocidos por los navegadores modernos y permiten automatizar la renovación.

El proceso general:

```text
Solicitud del certificado

        ↓

Validación del dominio

        ↓

Instalación en el servidor

        ↓

Configuración HTTPS

        ↓

Renovación periódica
```

## Configuración del servidor web

El servidor debe conocer:

- certificado público;
- clave privada asociada;
- configuración del sitio HTTPS.

La clave privada debe mantenerse protegida.

Nunca debe:

- subirse a Git;
- enviarse a terceros;
- incluirse en el código de la aplicación.

## Redirección HTTP a HTTPS

Una práctica habitual es evitar que existan dos versiones accesibles:

```text
http://ejemplo.com

https://ejemplo.com
```

La configuración recomendada:

```text
HTTP
  ↓
redirección permanente
  ↓
HTTPS
```

Así se fuerza a los usuarios a utilizar la comunicación protegida.

## Ejemplo conceptual

Petición inicial:

```text
Usuario

http://txurdigest.ejemplo
```

Servidor:

```text
301 Redirect

https://txurdigest.ejemplo
```

Nueva petición:

```text
Usuario

https://txurdigest.ejemplo
```

La comunicación continúa utilizando HTTPS.

## Renovación de certificados

Los certificados tienen una fecha de caducidad.

Por tanto, el despliegue debe contemplar:

- revisión periódica;
- renovación automática cuando sea posible;
- comprobación posterior.

Un certificado caducado provoca avisos de seguridad en los navegadores.

## HTTPS y cookies

Cuando una aplicación utiliza sesiones mediante cookies, HTTPS permite utilizar atributos de seguridad adicionales.

Por ejemplo:

```text
Secure
HttpOnly
SameSite
```

El atributo:

```text
Secure
```

indica que la cookie solo debe enviarse mediante HTTPS.

Ejemplo conceptual:

```http
Set-Cookie:
session=abc123;
Secure;
HttpOnly;
SameSite=Lax
```

## HTTPS y APIs

En arquitecturas con frontend y backend separados, ambos componentes deben utilizar HTTPS.

Ejemplo:

```text
Frontend Vue

https://txurdigest.ejemplo

        ↓

API PHP

https://api.txurdigest.ejemplo
```

Mezclar HTTPS y HTTP puede provocar:

- advertencias del navegador;
- problemas con cookies;
- exposición de información;
- bloqueos por políticas del navegador.

## No confiar únicamente en HTTPS

HTTPS protege la comunicación, pero no sustituye otros controles.

Una aplicación sigue necesitando:

- autenticación;
- autorización;
- validación;
- protección de datos;
- configuración segura.

HTTPS protege el canal.

No decide quién puede utilizar la aplicación.

## Comprobaciones antes de publicar

Antes del despliegue:

```text
[ ] Certificado válido instalado

[ ] Dominio correcto

[ ] HTTP redirige a HTTPS

[ ] Clave privada protegida

[ ] Cookies sensibles utilizan Secure

[ ] No existen recursos HTTP mezclados

[ ] Renovación configurada
```

## Ejemplo en TxurdiGest

Un despliegue correcto sería:

```text
Usuario

https://txurdigest.ejemplo

        ↓

Servidor web

        ↓

Aplicación PHP/Laravel

        ↓

Base de datos interna
```

La aplicación no debería estar disponible mediante HTTP.

La sesión del usuario debe transmitirse únicamente mediante una conexión protegida.

## Idea clave

> HTTPS no es una mejora opcional en producción: es una condición necesaria para proteger la comunicación entre usuarios y aplicación.
