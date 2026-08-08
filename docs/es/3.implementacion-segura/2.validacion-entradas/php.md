# Validación en PHP

La validación en el servidor es la comprobación definitiva que decide si una aplicación acepta o rechaza los datos recibidos.

Aunque el navegador haya realizado validaciones mediante HTML o JavaScript, el servidor debe volver a comprobar todos los valores antes de utilizarlos.

## Leer los datos recibidos

En PHP, los datos pueden llegar desde diferentes fuentes:

- formularios;
- parámetros de URL;
- peticiones JSON;
- cookies;
- archivos;
- APIs.

Por ejemplo, en un formulario enviado mediante `POST`:

```php
$email = $_POST['email'] ?? '';
$nota = $_POST['nota'] ?? null;
```

Utilizar `??` evita avisos cuando el parámetro no existe y permite tratar explícitamente la ausencia del dato.

## Validar campos obligatorios

Antes de comprobar formatos o rangos, conviene verificar que los datos necesarios existen.

```php
$email = trim($_POST['email'] ?? '');

if ($email === '') {
    $errores['email'] = 'El correo electrónico es obligatorio.';
}
```

Para una nota:

```php
if (!isset($_POST['nota']) || $_POST['nota'] === '') {
    $errores['nota'] = 'La nota es obligatoria.';
}
```

## Validar tipos y formatos

PHP ofrece funciones que permiten validar algunos formatos habituales.

### Correo electrónico

```php
$email = trim($_POST['email'] ?? '');

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    $errores['email'] = 'El correo electrónico no tiene un formato válido.';
}
```

### Número entero

```php
$edad = filter_input(INPUT_POST, 'edad', FILTER_VALIDATE_INT);

if ($edad === false || $edad === null) {
    $errores['edad'] = 'La edad debe ser un número entero.';
}
```

### Número decimal

Para valores decimales puede realizarse una conversión y comprobar posteriormente el resultado.

```php
$nota = filter_input(INPUT_POST, 'nota', FILTER_VALIDATE_FLOAT);

if ($nota === false || $nota === null) {
    $errores['nota'] = 'La nota debe ser un número.';
}
```

## Validar rangos

Comprobar el tipo no es suficiente. También deben aplicarse las restricciones propias del dato.

```php
$nota = filter_input(INPUT_POST, 'nota', FILTER_VALIDATE_FLOAT);

if ($nota === false || $nota === null) {
    $errores['nota'] = 'La nota debe ser un número.';
} elseif ($nota < 0 || $nota > 10) {
    $errores['nota'] = 'La nota debe estar comprendida entre 0 y 10.';
}
```

Un valor como `99` es numéricamente correcto, pero no es válido para una calificación.

## Validar valores permitidos

Cuando un campo solo admite un conjunto cerrado de valores, es preferible comprobarlo mediante una lista explícita.

```php
$estadosPermitidos = [
    'pendiente',
    'aprobada',
    'rechazada'
];

$estado = $_POST['estado'] ?? '';

if (!in_array($estado, $estadosPermitidos, true)) {
    $errores['estado'] = 'El estado indicado no es válido.';
}
```

Este enfoque evita aceptar valores inesperados.

## Validar longitud

Las cadenas también deben respetar límites razonables.

```php
$nombre = trim($_POST['nombre'] ?? '');

if (mb_strlen($nombre) < 2 || mb_strlen($nombre) > 60) {
    $errores['nombre'] = 'El nombre debe tener entre 2 y 60 caracteres.';
}
```

Los límites deben definirse según las necesidades reales de la aplicación.

## Validar reglas de negocio

Las validaciones más importantes no siempre dependen del formato del dato.

Por ejemplo, en **TxurdiGest** una nota puede cumplir todas las reglas anteriores y, aun así, no debería aceptarse si el profesor intenta modificar las calificaciones de un grupo que no tiene asignado.

```php
if (!$profesorTieneGrupo($usuarioId, $grupoId)) {
    http_response_code(403);
    exit('No dispone de permisos para realizar esta operación.');
}
```

Otro ejemplo:

```php
if ($alumnoYaEstaMatriculado($alumnoId, $moduloId)) {
    $errores['matricula'] = 'El alumno ya está matriculado en este módulo.';
}
```

Estas comprobaciones forman parte de la lógica de negocio y deben realizarse siempre en el servidor.

## Reunir los errores antes de continuar

Una forma sencilla de organizar la validación consiste en almacenar todos los errores antes de ejecutar la operación.

```php
$errores = [];

$email = trim($_POST['email'] ?? '');
$nota = filter_input(INPUT_POST, 'nota', FILTER_VALIDATE_FLOAT);

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    $errores['email'] = 'El correo electrónico no es válido.';
}

if ($nota === false || $nota === null) {
    $errores['nota'] = 'La nota debe ser un número.';
} elseif ($nota < 0 || $nota > 10) {
    $errores['nota'] = 'La nota debe estar comprendida entre 0 y 10.';
}

if (!empty($errores)) {
    // Devolver los errores al usuario.
    return;
}

// Solo aquí continúa la lógica de negocio.
```

La aplicación no debe procesar ni almacenar la información hasta que todas las validaciones necesarias hayan sido superadas.

## Validar peticiones JSON

En una API, los datos pueden llegar en el cuerpo de una petición JSON.

```php
$datos = json_decode(
    file_get_contents('php://input'),
    true
);
```

Después deben validarse exactamente igual que cualquier otro dato recibido.

```php
$nota = $datos['nota'] ?? null;

if (!is_numeric($nota)) {
    http_response_code(422);
    exit;
}

$nota = (float) $nota;

if ($nota < 0 || $nota > 10) {
    http_response_code(422);
    exit;
}
```

El hecho de que los datos procedan de una aplicación Vue, JavaScript o de una API interna no los convierte en datos fiables.

## Responder cuando la validación falla

Cuando un dato no es válido, el servidor debe:

1. detener la operación;
2. evitar cualquier modificación parcial;
3. informar al cliente de forma adecuada.

En una aplicación web tradicional puede mostrarse nuevamente el formulario con los errores.

En una API puede utilizarse un código como `422 Unprocessable Content` junto con una respuesta JSON.

```php
http_response_code(422);

header('Content-Type: application/json');

echo json_encode([
    'errors' => [
        'nota' => 'La nota debe estar comprendida entre 0 y 10.'
    ]
]);

exit;
```

El mensaje debe ser útil para el usuario o para el cliente que consume la API, pero no debe revelar información interna innecesaria.

## No confundir validar con escapar

La validación responde a una pregunta:

> **¿Este dato cumple las reglas de la aplicación?**

Escapar una salida responde a otra:

> **¿Cómo debe mostrarse este dato sin que se interprete como código?**

Por ejemplo:

```php
$nombre = $_POST['nombre'] ?? '';
```

Comprobar que `$nombre` tiene una longitud válida no significa que pueda imprimirse directamente en HTML.

La salida segura se estudiará en el apartado dedicado a XSS.

## Ejemplo completo en TxurdiGest

Supongamos que un profesor envía:

```text
alumnoId=152
nota=8.5
```

El servidor podría realizar un flujo similar:

```php
$errores = [];

$alumnoId = filter_input(INPUT_POST, 'alumnoId', FILTER_VALIDATE_INT);
$nota = filter_input(INPUT_POST, 'nota', FILTER_VALIDATE_FLOAT);

if ($alumnoId === false || $alumnoId === null) {
    $errores['alumnoId'] = 'El alumno indicado no es válido.';
}

if ($nota === false || $nota === null) {
    $errores['nota'] = 'La nota debe ser un número.';
} elseif ($nota < 0 || $nota > 10) {
    $errores['nota'] = 'La nota debe estar comprendida entre 0 y 10.';
}

if (!empty($errores)) {
    http_response_code(422);
    exit;
}

// Comprobaciones de autorización y reglas de negocio.
// Solo después se modificará la base de datos.
```

La validación JavaScript puede haber realizado comprobaciones similares previamente, pero el servidor toma la decisión definitiva.

## Buenas prácticas

- Considera no confiable cualquier dato recibido.
- Comprueba primero la existencia del dato.
- Valida tipo, formato, longitud y rango cuando corresponda.
- Utiliza listas cerradas para valores permitidos.
- Aplica también las reglas de negocio.
- No continúes el procesamiento cuando exista algún error.
- Devuelve mensajes comprensibles sin revelar información interna.
- Mantén las reglas de validación organizadas y reutilizables.
- No confíes en que JavaScript haya realizado correctamente las comprobaciones.

## Resumen

- PHP debe validar toda entrada necesaria para proteger la aplicación.
- Un dato puede tener un formato correcto y seguir siendo inválido según las reglas de negocio.
- La validación debe completarse antes de modificar el estado de la aplicación.
- Las peticiones procedentes de JavaScript o de una API deben tratarse como cualquier otra entrada externa.
