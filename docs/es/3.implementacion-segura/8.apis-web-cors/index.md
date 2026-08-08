# APIs web y CORS

Las aplicaciones modernas suelen separar el cliente y el servidor mediante APIs.

JavaScript, Vue, Axios o `fetch()` pueden enviar peticiones HTTP a endpoints que devuelven datos en formatos como JSON.

Desde el punto de vista de la seguridad, una API debe aplicar los mismos principios que cualquier otra parte de la aplicación:

- validar entradas;
- autenticar usuarios;
- autorizar operaciones;
- proteger el acceso a datos;
- limitar la información expuesta;
- gestionar correctamente los orígenes permitidos.

## Una API no confía en su propio cliente

Un error frecuente consiste en asumir que una petición es fiable porque procede de nuestra aplicación JavaScript o Vue.

Por ejemplo:

```js
fetch('/api/calificaciones', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json'
    },
    body: JSON.stringify({
        alumnoId: 152,
        nota: 8.5
    })
});
```

El servidor no puede saber si esa petición se ha generado exactamente desde ese código.

Puede haber sido:

- modificada;
- construida manualmente;
- enviada desde otra herramienta;
- enviada desde otro cliente.

Por tanto, el endpoint debe volver a aplicar todas las comprobaciones necesarias.

## Seguridad en cada endpoint

Cada endpoint debe decidir:

```text
¿Quién realiza la petición?
        ↓
¿Está autenticado?
        ↓
¿Puede realizar esta operación?
        ↓
¿Los datos son válidos?
        ↓
¿Puede acceder a este recurso?
        ↓
Ejecutar operación
```

Por ejemplo:

```text
PATCH /api/alumnos/152/nota
```

no debería modificar directamente la base de datos únicamente porque el cliente haya enviado:

```json
{
    "nota": 8.5
}
```

El servidor debe comprobar también la identidad y los permisos del usuario.

## No exponer más datos de los necesarios

Una API debe devolver únicamente la información que necesita el cliente.

Por ejemplo, una respuesta podría ser:

```json
{
    "id": 152,
    "nombre": "Ane",
    "email": "ane@example.com"
}
```

No debería incluir sin necesidad campos internos como:

```json
{
    "password_hash": "...",
    "token_interno": "...",
    "ruta_servidor": "/var/www/app/..."
}
```

Aunque el cliente no muestre esos datos en pantalla, siguen estando presentes en la respuesta HTTP.

> **Ocultar un dato en la interfaz no evita que el navegador lo reciba.**

## Códigos HTTP

Una API debe utilizar códigos HTTP coherentes con el resultado de la operación.

Algunos ejemplos:

| Código | Significado habitual |
|---|---|
| `200` | Operación correcta |
| `201` | Recurso creado |
| `400` | Petición incorrecta |
| `401` | Usuario no autenticado |
| `403` | Usuario autenticado sin permiso |
| `404` | Recurso no encontrado |
| `422` | Datos recibidos no válidos |
| `500` | Error interno del servidor |

El código de respuesta forma parte de la interfaz entre cliente y servidor.

## Qué es CORS

**CORS (Cross-Origin Resource Sharing)** es un mecanismo aplicado por los navegadores para controlar determinadas peticiones entre orígenes diferentes.

Un origen se define mediante la combinación de:

```text
protocolo + host + puerto
```

Por ejemplo:

```text
https://app.ejemplo.com
```

y:

```text
https://api.ejemplo.com
```

son orígenes diferentes porque el host no coincide.

También lo son:

```text
http://localhost:5173
```

y:

```text
http://localhost:8000
```

porque utilizan puertos distintos.

## Ejemplo habitual en desarrollo

Durante el desarrollo puede existir:

```text
Vue
http://localhost:5173
```

y una API:

```text
PHP
http://localhost:8000
```

Cuando JavaScript intenta realizar:

```js
fetch('http://localhost:8000/api/alumnos');
```

el navegador detecta que la petición se dirige a otro origen.

El servidor debe indicar si permite que ese origen acceda a la respuesta.

## Cabecera `Access-Control-Allow-Origin`

Una respuesta puede incluir:

```http
Access-Control-Allow-Origin: http://localhost:5173
```

Esto indica que el navegador puede permitir a ese origen acceder a la respuesta.

Una configuración amplia sería:

```http
Access-Control-Allow-Origin: *
```

pero no siempre es adecuada.

La aplicación debería permitir únicamente los orígenes necesarios.

## CORS no es autenticación

Una idea especialmente importante es:

> **CORS no identifica usuarios.**

Permitir:

```http
Access-Control-Allow-Origin: https://frontend.ejemplo.com
```

no significa que todas las peticiones procedentes de ese origen estén autorizadas.

El servidor sigue necesitando:

- autenticación;
- autorización;
- validación;
- controles sobre los recursos.

CORS y autorización resuelven problemas diferentes.

## CORS tampoco protege directamente el servidor

CORS es principalmente una política aplicada por el navegador.

Una herramienta que no esté sujeta a esas restricciones puede enviar igualmente una petición HTTP al servidor.

Por tanto:

```text
CORS
    ↓
controla qué respuestas puede utilizar código web de otro origen

Autorización
    ↓
controla si el servidor permite realizar la operación
```

No deben confundirse.

## Credenciales y CORS

Cuando una aplicación utiliza cookies o determinadas credenciales entre orígenes, la configuración debe ser más específica.

Por ejemplo, no puede plantearse simplemente:

```http
Access-Control-Allow-Origin: *
```

junto con un modelo que requiera compartir credenciales de forma indiscriminada.

El servidor debe conocer qué frontend está autorizado a comunicarse con la API y configurar de forma coherente:

- origen permitido;
- credenciales;
- cookies;
- HTTPS;
- sesión.

## Peticiones preflight

Algunas peticiones entre orígenes provocan que el navegador envíe primero una petición:

```http
OPTIONS
```

Esta petición se conoce habitualmente como **preflight**.

El navegador pregunta al servidor si permitirá la operación antes de enviar la petición principal.

Conceptualmente:

```text
Navegador
    ↓
OPTIONS
    ↓
Servidor responde qué permite
    ↓
Petición real
```

Esto puede aparecer, por ejemplo, con:

- determinados métodos HTTP;
- cabeceras personalizadas;
- ciertos tipos de contenido.

## CORS en desarrollo y producción

Durante el desarrollo puede permitirse:

```text
http://localhost:5173
```

porque allí se ejecuta el frontend.

En producción, la configuración debería adaptarse al origen real.

Por ejemplo:

```text
https://txurdigest.ejemplo
```

La configuración no debería permanecer abierta simplemente porque durante el desarrollo resultaba más cómodo.

## Ejemplo en TxurdiGest

Supongamos esta arquitectura:

```text
Vue
https://txurdigest.ejemplo
        ↓
API PHP
https://api.txurdigest.ejemplo
```

La API puede permitir explícitamente:

```http
Access-Control-Allow-Origin: https://txurdigest.ejemplo
```

Pero cuando recibe:

```text
PATCH /api/alumnos/152/nota
```

todavía debe comprobar:

```text
sesión
  ↓
usuario autenticado
  ↓
rol
  ↓
acceso al alumno 152
  ↓
nota válida
  ↓
actualización
```

CORS no sustituye ninguna de estas comprobaciones.

## Implementación

En [Implementación](implementacion.md) trabajaremos:

- recepción de JSON en PHP;
- respuestas JSON;
- validación de datos;
- autenticación y autorización en endpoints;
- exposición mínima de información;
- configuración básica de CORS;
- orígenes permitidos;
- peticiones preflight;
- relación entre cookies, credenciales y CORS.

## Resumen

- Una API debe aplicar las mismas reglas de seguridad que cualquier otra entrada al servidor.
- El servidor no puede confiar en que una petición proceda de su frontend JavaScript.
- Cada endpoint debe validar, autenticar y autorizar según corresponda.
- Una API debe devolver únicamente los datos necesarios.
- CORS controla determinadas interacciones entre orígenes desde el navegador.
- CORS no sustituye a la autenticación ni a la autorización.
- La configuración de orígenes debe adaptarse al entorno de desarrollo y producción.
