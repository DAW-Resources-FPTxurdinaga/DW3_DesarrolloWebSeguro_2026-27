# Implementación segura de APIs y CORS

Una API segura debe aplicar en cada endpoint las mismas decisiones que ya hemos trabajado en el resto del bloque:

```text
Entrada
  ↓
Validación
  ↓
Autenticación
  ↓
Autorización
  ↓
Lógica de negocio
  ↓
Respuesta controlada
```

El hecho de que la petición proceda de una aplicación JavaScript, Vue o Axios no cambia estas responsabilidades.

## Recibir JSON en PHP

Una petición puede enviar un cuerpo JSON como:

```json
{
    "alumnoId": 152,
    "nota": 8.5
}
```

En PHP puede leerse con:

```php
$contenido = file_get_contents('php://input');

$datos = json_decode(
    $contenido,
    true
);
```

Después conviene comprobar que el JSON se ha interpretado correctamente.

```php
if (!is_array($datos)) {
    http_response_code(400);
    exit;
}
```

También puede comprobarse explícitamente el error de decodificación:

```php
if (json_last_error() !== JSON_ERROR_NONE) {
    http_response_code(400);
    exit;
}
```

## Validar los datos recibidos

No basta con que el JSON tenga una sintaxis correcta.

Los datos deben cumplir las reglas de la aplicación.

```php
$alumnoId = $datos['alumnoId'] ?? null;
$nota = $datos['nota'] ?? null;

if (!filter_var(
    $alumnoId,
    FILTER_VALIDATE_INT
)) {
    http_response_code(422);
    exit;
}

if (
    !is_numeric($nota) ||
    $nota < 0 ||
    $nota > 10
) {
    http_response_code(422);
    exit;
}
```

La API debe rechazar cualquier valor que no cumpla las reglas necesarias.

## Responder en JSON

Una API debería devolver respuestas coherentes.

Por ejemplo:

```php
header('Content-Type: application/json');
```

Una respuesta correcta:

```php
http_response_code(200);

echo json_encode([
    'ok' => true
]);
```

Una respuesta de validación:

```php
http_response_code(422);

echo json_encode([
    'errors' => [
        'nota' => 'La nota debe estar entre 0 y 10.'
    ]
]);
```

Conviene mantener una estructura consistente entre endpoints.

## No devolver detalles internos

Una respuesta no debería exponer información como:

```text
SQL completo
rutas del servidor
stack traces
credenciales
tokens internos
```

Por ejemplo, no debería hacerse:

```php
catch (Throwable $e) {
    echo $e->getMessage();
}
```

En producción puede registrarse internamente:

```php
catch (Throwable $e) {
    error_log($e->getMessage());

    http_response_code(500);

    echo json_encode([
        'error' => 'No se ha podido completar la operación.'
    ]);
}
```

El cliente recibe un mensaje controlado.

El detalle técnico queda en el servidor.

## Autenticación en endpoints

Si la API utiliza sesiones PHP, cada endpoint protegido debe iniciar la sesión y comprobarla.

```php
session_start();

if (!isset($_SESSION['usuario_id'])) {
    http_response_code(401);

    echo json_encode([
        'error' => 'Debes iniciar sesión.'
    ]);

    exit;
}
```

La identidad se obtiene de:

```php
$usuarioId = (int) $_SESSION['usuario_id'];
```

No debe recibirse desde el cuerpo JSON como prueba de identidad.

Una petición como:

```json
{
    "usuarioId": 12
}
```

no demuestra que quien la envía sea el usuario `12`.

## Autorización en cada operación

Supongamos un endpoint:

```text
PATCH /api/alumnos/152/nota
```

El servidor debe comprobar si el usuario autenticado puede actuar sobre el alumno `152`.

Por ejemplo:

```php
if (
    !profesorPuedeGestionarAlumno(
        $pdo,
        $usuarioId,
        $alumnoId
    )
) {
    http_response_code(403);

    echo json_encode([
        'error' => 'No dispone de permisos.'
    ]);

    exit;
}
```

Solo después se ejecuta la modificación.

## Ejemplo completo de endpoint

Una versión simplificada podría ser:

```php
<?php

header('Content-Type: application/json');

session_start();

if (!isset($_SESSION['usuario_id'])) {
    http_response_code(401);

    echo json_encode([
        'error' => 'Debes iniciar sesión.'
    ]);

    exit;
}

$contenido = file_get_contents('php://input');

$datos = json_decode(
    $contenido,
    true
);

if (!is_array($datos)) {
    http_response_code(400);

    echo json_encode([
        'error' => 'JSON no válido.'
    ]);

    exit;
}

$alumnoId = $datos['alumnoId'] ?? null;
$nota = $datos['nota'] ?? null;

if (
    !filter_var(
        $alumnoId,
        FILTER_VALIDATE_INT
    ) ||
    !is_numeric($nota) ||
    $nota < 0 ||
    $nota > 10
) {
    http_response_code(422);

    echo json_encode([
        'error' => 'Datos no válidos.'
    ]);

    exit;
}

$profesorId = (int) $_SESSION['usuario_id'];

if (
    !profesorPuedeGestionarAlumno(
        $pdo,
        $profesorId,
        (int) $alumnoId
    )
) {
    http_response_code(403);

    echo json_encode([
        'error' => 'No dispone de permisos.'
    ]);

    exit;
}

$sql = "
    UPDATE calificaciones
    SET nota = :nota
    WHERE alumno_id = :alumno_id
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'nota' => $nota,
    'alumno_id' => $alumnoId
]);

echo json_encode([
    'ok' => true
]);
```

Este endpoint combina:

- sesión;
- validación;
- autorización;
- consulta preparada;
- respuesta JSON.

## Devolver solo los campos necesarios

Supongamos que un endpoint consulta usuarios.

Una implementación poco cuidadosa podría devolver:

```php
echo json_encode($usuario);
```

si `$usuario` contiene todas las columnas de la base de datos.

Es preferible construir explícitamente la respuesta:

```php
echo json_encode([
    'id' => $usuario['id'],
    'nombre' => $usuario['nombre'],
    'email' => $usuario['email']
]);
```

Así se evita exponer accidentalmente campos internos.

## Configuración básica de CORS

Supongamos que durante el desarrollo el frontend se ejecuta en:

```text
http://localhost:5173
```

y la API en:

```text
http://localhost:8000
```

La API puede permitir explícitamente ese origen:

```php
header(
    'Access-Control-Allow-Origin: http://localhost:5173'
);
```

Esto indica al navegador que ese origen puede acceder a la respuesta.

## Evitar `*` cuando no es necesario

Una configuración como:

```php
header('Access-Control-Allow-Origin: *');
```

permite cualquier origen.

Puede ser válida para determinados recursos públicos, pero no debería utilizarse automáticamente en APIs privadas o autenticadas.

Si solo existe un frontend permitido, es preferible declararlo explícitamente.

## Lista de orígenes permitidos

Si existen varios orígenes válidos, pueden definirse en una lista controlada.

```php
$origenesPermitidos = [
    'http://localhost:5173',
    'https://txurdigest.ejemplo'
];

$origin = $_SERVER['HTTP_ORIGIN'] ?? '';

if (
    in_array(
        $origin,
        $origenesPermitidos,
        true
    )
) {
    header(
        'Access-Control-Allow-Origin: ' .
        $origin
    );
}
```

El valor de `Origin` no debe reflejarse automáticamente sin comprobarlo.

Una implementación incorrecta sería:

```php
header(
    'Access-Control-Allow-Origin: ' .
    $_SERVER['HTTP_ORIGIN']
);
```

porque estaría aceptando cualquier origen recibido.

## Peticiones preflight

Algunas peticiones provocan una petición previa `OPTIONS`.

Por ejemplo, una petición:

```text
PATCH
Content-Type: application/json
```

puede requerir preflight.

La API puede responder:

```php
header(
    'Access-Control-Allow-Methods: GET, POST, PATCH'
);

header(
    'Access-Control-Allow-Headers: Content-Type'
);
```

Y gestionar `OPTIONS`:

```php
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}
```

El servidor indica qué métodos y cabeceras permite.

## CORS con cookies de sesión

Si el frontend y la API están en orígenes diferentes y la autenticación utiliza cookies, el cliente puede necesitar enviar credenciales.

Con `fetch()`:

```js
fetch('https://api.txurdigest.ejemplo/alumnos', {
    credentials: 'include'
});
```

En Axios:

```js
axios.get(
    'https://api.txurdigest.ejemplo/alumnos',
    {
        withCredentials: true
    }
);
```

El servidor debe permitir credenciales:

```php
header(
    'Access-Control-Allow-Credentials: true'
);
```

Y debe utilizar un origen explícito:

```php
header(
    'Access-Control-Allow-Origin: https://txurdigest.ejemplo'
);
```

No debe combinarse un modelo con credenciales con:

```http
Access-Control-Allow-Origin: *
```

## Cookies y `SameSite`

Cuando una arquitectura utiliza frontend y API en contextos diferentes, la configuración de las cookies puede afectar al envío de la sesión.

Los atributos relevantes incluyen:

```text
Secure
HttpOnly
SameSite
```

La configuración concreta depende de la arquitectura y del dominio utilizado.

No debe modificarse `SameSite` únicamente para “hacer que CORS funcione” sin comprender el efecto sobre las cookies.

## CORS no sustituye al control del endpoint

Aunque el servidor permita únicamente:

```text
https://txurdigest.ejemplo
```

el endpoint debe seguir comprobando:

```text
sesión
autorización
validación
```

CORS no impide que otros clientes HTTP contacten con el servidor.

La protección real de la operación está en el endpoint.

## No utilizar CORS para ocultar una API

Una API no se vuelve privada simplemente porque solo permita un origen.

Por ejemplo:

```php
header(
    'Access-Control-Allow-Origin: https://frontend.ejemplo'
);
```

no impide que alguien envíe una petición HTTP desde una herramienta externa.

CORS controla el comportamiento del navegador.

No es un firewall ni un sistema de autorización.

## Ejemplo con JavaScript

El frontend puede enviar:

```js
async function actualizarNota(
    alumnoId,
    nota
) {
    const respuesta = await fetch(
        'https://api.txurdigest.ejemplo/calificaciones',
        {
            method: 'PATCH',
            credentials: 'include',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                alumnoId,
                nota
            })
        }
    );

    if (!respuesta.ok) {
        throw new Error(
            'No se ha podido actualizar la nota.'
        );
    }

    return respuesta.json();
}
```

JavaScript interpreta la respuesta.

PHP decide si la operación está permitida.

## Ejemplo en TxurdiGest

Supongamos esta arquitectura:

```text
Frontend Vue
https://txurdigest.ejemplo

API PHP
https://api.txurdigest.ejemplo
```

La API puede definir:

```text
Origen permitido
https://txurdigest.ejemplo
```

y, para una operación de modificación:

```text
PATCH /api/calificaciones
        ↓
sesión válida
        ↓
profesor autenticado
        ↓
datos válidos
        ↓
profesor autorizado sobre el alumno
        ↓
consulta preparada
        ↓
respuesta JSON
```

CORS únicamente participa en la comunicación entre ambos orígenes.

No sustituye ninguna de las comprobaciones de seguridad.

## Buenas prácticas

- Trata todo JSON recibido como entrada no confiable.
- Valida todos los campos necesarios.
- Comprueba autenticación y autorización en cada endpoint.
- Obtén la identidad desde la sesión o mecanismo de autenticación del servidor.
- Devuelve únicamente los campos necesarios.
- No expongas errores internos.
- Utiliza códigos HTTP coherentes.
- Define explícitamente los orígenes permitidos.
- No reflejes `Origin` sin validarlo.
- Evita `Access-Control-Allow-Origin: *` por defecto.
- Gestiona correctamente las peticiones `OPTIONS`.
- Configura de forma coherente cookies, credenciales y CORS.
- No utilices CORS como sustituto de autenticación o autorización.

## Resumen

- Una API segura aplica validación, autenticación y autorización en el servidor.
- El frontend no demuestra la legitimidad de una petición.
- Las respuestas deben limitar la información expuesta.
- CORS define qué orígenes puede utilizar el navegador para acceder a una respuesta.
- Con credenciales, el origen debe configurarse explícitamente.
- La seguridad del endpoint no depende de CORS.
