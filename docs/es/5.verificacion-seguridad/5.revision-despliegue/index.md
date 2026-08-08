# Revisión del despliegue

En el Bloque 4 se trabajaron las decisiones necesarias para desplegar una aplicación de forma segura.

En este bloque no se vuelven a explicar esas configuraciones.

El objetivo cambia:

> comprobar que las decisiones previstas están realmente aplicadas en producción.

```text
Control previsto

        ↓

Configuración aplicada

        ↓

Comprobación

        ↓

Resultado

        ↓

Evidencia
```

Una configuración escrita en la documentación no equivale a una configuración verificada.

## Qué revisar

La revisión del despliegue puede centrarse en:

- HTTPS;
- configuración de producción;
- secretos;
- superficie de exposición;
- directorio público;
- permisos;
- base de datos;
- cabeceras de seguridad;
- errores y logs.

La pregunta no es únicamente:

> ¿Cómo debería estar configurado?

Ahora preguntamos:

> ¿Cómo puedo comprobar que realmente está configurado así?

## Mapa de comprobaciones

| Control | Cómo comprobarlo | Evidencia posible |
|---|---|---|
| HTTPS | Navegador, DevTools o `curl` | Certificado, redirección, respuesta HTTPS |
| Configuración de producción | Revisar configuración y provocar un error controlado | `DEBUG` desactivado, mensaje controlado |
| Secretos | Revisar código/repositorio y exposición web | Configuración sin valores sensibles |
| Superficie de exposición | Revisar servicios y reglas del entorno | Security Groups, diagrama o configuración |
| Directorio público | Comprobar qué rutas y archivos son accesibles | Respuesta 403/404 |
| Permisos | Revisar permisos efectivos | Configuración o listado sin datos sensibles |
| Base de datos | Revisar arquitectura y permisos de conexión | Diagrama, SG o configuración |
| Cabeceras | DevTools o `curl` | Response Headers |
| Errores | Provocar una situación controlada | Respuesta sin detalle interno |
| Logs | Revisar el registro generado | Fragmento anonimizado |

## HTTPS

Comprobar desde el entorno desplegado:

```text
[ ] La aplicación utiliza HTTPS

[ ] El certificado es válido

[ ] HTTP redirige a HTTPS

[ ] No existe contenido mixto

[ ] HSTS se utiliza únicamente cuando la configuración HTTPS es correcta
```

Evidencias posibles:

- navegador;
- pestaña Network;
- salida de `curl -I`.

## Configuración de producción

Revisar que la aplicación utiliza la configuración correspondiente al entorno real.

En Laravel, por ejemplo:

```text
APP_ENV=production

APP_DEBUG=false
```

Una comprobación útil consiste en provocar un error controlado.

Resultado esperado:

```text
Usuario

→ mensaje controlado


Servidor

→ detalle disponible en el log
```

Si aparece una traza completa en el navegador, la configuración debe revisarse.

## Secretos

Comprobar dos aspectos diferentes.

### Código y repositorio

```text
[ ] No existen credenciales escritas en el código

[ ] .env no está versionado

[ ] No existen claves API o tokens publicados
```

### Exposición

```text
[ ] .env no puede descargarse desde la web

[ ] Los archivos de configuración sensibles no son públicos

[ ] Los logs no son accesibles desde el navegador
```

Si un secreto ha sido publicado, eliminar el archivo no es suficiente.

El secreto debe revocarse o rotarse.

## Superficie de exposición

Comparar la arquitectura prevista con la configuración real.

Ejemplo:

```text
Internet

    ↓

HTTPS / 443

    ↓

Servidor web

    ↓

Aplicación

    ↓

Base de datos interna
```

Comprobar:

```text
[ ] Solo están expuestos los servicios necesarios

[ ] SSH está restringido cuando existe

[ ] La base de datos no está publicada directamente

[ ] No existen paneles de desarrollo accesibles
```

En AWS esta comprobación puede apoyarse en la revisión de VPC y Security Groups.

No es necesario convertir esta revisión en una práctica de administración de sistemas.

## Directorio público

Comprobar qué parte del proyecto publica realmente el servidor web.

En Laravel, el punto público debe ser:

```text
public/
```

No deberían ser accesibles desde la web:

- `.env`;
- `.git`;
- logs;
- copias de seguridad;
- archivos de configuración;
- código interno.

La evidencia puede ser una respuesta 403 o 404 al solicitar un recurso que no debería ser público.

## Permisos

No es necesario volver a estudiar la administración de permisos.

La revisión debe responder a preguntas concretas:

```text
¿Solo las carpetas necesarias permiten escritura?

¿Los archivos sensibles están protegidos?

¿Se ha evitado utilizar chmod 777 como solución general?

¿Los directorios de subida impiden la ejecución?
```

En Laravel deben revisarse especialmente las necesidades de escritura de:

```text
storage/

bootstrap/cache/
```

## Base de datos

La revisión debe comprobar que la arquitectura desplegada coincide con las decisiones de seguridad.

```text
[ ] La aplicación no utiliza root o un administrador

[ ] El usuario dispone únicamente de los permisos necesarios

[ ] Las credenciales están fuera del código

[ ] La base de datos no está expuesta directamente a Internet

[ ] Las copias de seguridad están contempladas
```

En un entorno AWS puede comprobarse que la base de datos solo acepta conexiones desde los componentes autorizados.

## Cabeceras de seguridad

Utilizar DevTools o `curl` para comprobar las cabeceras definidas en el proyecto.

Por ejemplo:

```text
Content-Security-Policy

X-Content-Type-Options

Strict-Transport-Security

Referrer-Policy

Permissions-Policy
```

La revisión debe comprobar:

```text
[ ] La cabecera está presente

[ ] El valor coincide con la configuración prevista

[ ] No rompe funcionalidades legítimas
```

No se trata de añadir cabeceras simplemente para completar una lista.

## Errores y logs

Provocar una situación controlada:

```text
Recurso inexistente

Dato inválido

Operación no permitida
```

Comprobar la respuesta pública:

```text
[ ] No muestra rutas internas

[ ] No muestra SQL

[ ] No muestra trazas completas

[ ] No muestra secretos
```

Después revisar el registro interno:

```text
[ ] El error queda registrado

[ ] El log permite investigar

[ ] No contiene secretos

[ ] No es accesible públicamente
```

## Aplicación al Reto 1

En el proyecto con PHP, JavaScript y CSS3 la revisión puede centrarse especialmente en:

- HTTPS;
- configuración de errores de producción;
- secretos fuera del código;
- acceso de la aplicación a la base de datos;
- permisos necesarios;
- exposición de archivos internos;
- respuesta ante errores.

## Aplicación al Reto 2

En Laravel, Vue 3 y Tailwind deben comprobarse además de los controles anteriores:

- `APP_ENV`;
- `APP_DEBUG`;
- protección de `.env`;
- publicación correcta de `public/`;
- permisos de `storage/` y `bootstrap/cache/`;
- respuestas de la API;
- cabeceras y CORS cuando correspondan;
- logs de producción.

## Evidencias mínimas

No es necesario documentar cada comprobación con una captura.

Conviene seleccionar las evidencias que demuestren los controles más importantes.

Por ejemplo:

| Control | Evidencia |
|---|---|
| HTTPS | Certificado o respuesta HTTPS |
| DEBUG desactivado | Error controlado |
| Secretos | Configuración sin valores sensibles |
| Base de datos interna | Arquitectura o regla de acceso |
| Cabeceras | Response Headers |
| Logs | Fragmento anonimizado |

## Aplicación a TxurdiGest

Una revisión de despliegue podría seleccionar:

```text
HTTPS

APP_DEBUG=false

.env no accesible

Base de datos interna

Cabeceras

Errores controlados

Logs protegidos
```

Para cada punto:

```text
Control

    ↓

Comprobación

    ↓

Resultado

    ↓

Evidencia
```

## Idea clave

> Revisar el despliegue significa comprobar desde el entorno real que las decisiones de seguridad previstas se han aplicado y siguen funcionando.
