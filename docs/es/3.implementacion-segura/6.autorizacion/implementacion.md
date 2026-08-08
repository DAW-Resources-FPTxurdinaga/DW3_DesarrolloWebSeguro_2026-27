# Implementación de la autorización

La autorización debe aplicarse en el servidor antes de ejecutar cualquier operación protegida.

El flujo general es:

```text
Petición
   ↓
¿Usuario autenticado?
   ↓
¿Tiene el rol adecuado?
   ↓
¿Puede actuar sobre este recurso?
   ↓
Ejecutar operación
```

La aplicación no debe confiar en que la interfaz haya ocultado una opción ni en que el cliente haya enviado un identificador aparentemente válido.

## Comprobar que existe una sesión autenticada

Antes de autorizar una acción, la aplicación debe conocer la identidad del usuario.

Por ejemplo:

```php
session_start();

if (!isset($_SESSION['usuario_id'])) {
    http_response_code(401);
    exit('Debes iniciar sesión.');
}
```

Después puede recuperarse:

```php
$usuarioId = (int) $_SESSION['usuario_id'];
```

La identidad debe proceder de la sesión y no de un campo enviado por el navegador.

## Autorización por rol

Para algunas operaciones puede bastar con comprobar el rol.

Por ejemplo, una función administrativa:

```php
if (
    !isset($_SESSION['rol']) ||
    $_SESSION['rol'] !== 'administrador'
) {
    http_response_code(403);
    exit('No dispone de permisos.');
}
```

Este control puede encapsularse:

```php
function requireRole(string $rol): void
{
    if (
        !isset($_SESSION['rol']) ||
        $_SESSION['rol'] !== $rol
    ) {
        http_response_code(403);
        exit('No dispone de permisos.');
    }
}
```

Y utilizarse:

```php
session_start();

requireRole('administrador');
```

Centralizar este tipo de comprobaciones evita repetir lógica y reduce inconsistencias.

## Permitir varios roles

En algunos casos una operación puede estar disponible para más de un rol.

```php
function requireAnyRole(array $roles): void
{
    $rolActual = $_SESSION['rol'] ?? null;

    if (!in_array($rolActual, $roles, true)) {
        http_response_code(403);
        exit('No dispone de permisos.');
    }
}
```

Ejemplo:

```php
requireAnyRole([
    'administrador',
    'profesor'
]);
```

## Comprobar acceso a un recurso

El rol no siempre determina por sí solo si una operación está autorizada.

Supongamos que un profesor intenta modificar una calificación.

La petición contiene:

```text
alumno_id=152
```

El servidor debe comprobar si ese alumno pertenece realmente a un grupo gestionado por el profesor autenticado.

La identidad del profesor se obtiene de la sesión:

```php
$profesorId = (int) $_SESSION['usuario_id'];
```

El identificador del alumno se valida:

```php
$alumnoId = filter_input(
    INPUT_POST,
    'alumno_id',
    FILTER_VALIDATE_INT
);

if ($alumnoId === false || $alumnoId === null) {
    http_response_code(422);
    exit('Alumno no válido.');
}
```

Después debe comprobarse la relación entre ambos.

## Comprobación mediante consulta preparada

Una función podría ser:

```php
function profesorPuedeGestionarAlumno(
    PDO $pdo,
    int $profesorId,
    int $alumnoId
): bool {
    $sql = "
        SELECT 1
        FROM alumnos a
        INNER JOIN grupos g
            ON g.id = a.grupo_id
        WHERE a.id = :alumno_id
          AND g.profesor_id = :profesor_id
        LIMIT 1
    ";

    $stmt = $pdo->prepare($sql);

    $stmt->execute([
        'alumno_id' => $alumnoId,
        'profesor_id' => $profesorId
    ]);

    return $stmt->fetchColumn() !== false;
}
```

Después:

```php
if (
    !profesorPuedeGestionarAlumno(
        $pdo,
        $profesorId,
        $alumnoId
    )
) {
    http_response_code(403);
    exit('No dispone de permisos.');
}
```

Solo después se ejecuta la operación.

## Autorizar antes de modificar

El orden es importante.

Una secuencia incorrecta sería:

```text
Actualizar base de datos
        ↓
comprobar permisos
```

La comprobación debe realizarse antes:

```text
Validar entrada
        ↓
comprobar autenticación
        ↓
comprobar autorización
        ↓
ejecutar operación
```

Por ejemplo:

```php
session_start();

if (!isset($_SESSION['usuario_id'])) {
    http_response_code(401);
    exit;
}

$profesorId = (int) $_SESSION['usuario_id'];

$alumnoId = filter_input(
    INPUT_POST,
    'alumno_id',
    FILTER_VALIDATE_INT
);

$nota = filter_input(
    INPUT_POST,
    'nota',
    FILTER_VALIDATE_FLOAT
);

if (
    $alumnoId === false ||
    $alumnoId === null ||
    $nota === false ||
    $nota === null ||
    $nota < 0 ||
    $nota > 10
) {
    http_response_code(422);
    exit;
}

if (
    !profesorPuedeGestionarAlumno(
        $pdo,
        $profesorId,
        $alumnoId
    )
) {
    http_response_code(403);
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
```

Este ejemplo combina varios controles del bloque:

- sesión;
- validación;
- autorización;
- consulta preparada.

## No confiar en el rol enviado por el cliente

Una implementación incorrecta sería:

```html
<input
    type="hidden"
    name="rol"
    value="profesor"
>
```

y después:

```php
if ($_POST['rol'] === 'profesor') {
    // permitir
}
```

Ese valor puede modificarse.

El rol debe obtenerse de una fuente controlada por el servidor, por ejemplo:

```php
$rol = $_SESSION['rol'];
```

o recuperarse de la base de datos utilizando la identidad autenticada.

## No confiar en el propietario enviado por el cliente

También sería incorrecto recibir:

```text
profesor_id=12
```

y asumir que ese es el usuario que realiza la acción.

```php
$profesorId = $_POST['profesor_id'];
```

La identidad real debe ser:

```php
$profesorId = $_SESSION['usuario_id'];
```

El cliente puede indicar sobre qué recurso desea actuar.

No debe indicar quién es.

## Ocultar botones con JavaScript

La interfaz puede utilizar JavaScript para mostrar únicamente las opciones disponibles.

Por ejemplo:

```js
if (usuario.rol !== 'administrador') {
    botonEliminar.hidden = true;
}
```

Esto es útil para no mostrar controles que el usuario no puede utilizar.

Pero el endpoint debe seguir comprobando:

```php
if ($_SESSION['rol'] !== 'administrador') {
    http_response_code(403);
    exit;
}
```

La relación correcta es:

```text
JavaScript
    ↓
adapta la interfaz

PHP
    ↓
protege la operación
```

## Comprobar autorización también en consultas

La autorización puede integrarse directamente en la consulta.

Supongamos que un alumno solo puede consultar sus propias calificaciones.

En lugar de:

```php
$sql = "
    SELECT *
    FROM calificaciones
    WHERE alumno_id = :alumno_id
";
```

recibiendo `alumno_id` desde el cliente, puede utilizarse directamente la identidad autenticada:

```php
$alumnoId = (int) $_SESSION['usuario_id'];

$sql = "
    SELECT *
    FROM calificaciones
    WHERE alumno_id = :alumno_id
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'alumno_id' => $alumnoId
]);
```

Así el usuario ni siquiera decide qué identificador de alumno consultar.

## Recursos inexistentes y recursos no autorizados

En determinados casos conviene evitar revelar si un recurso existe cuando el usuario no tiene acceso a él.

Por ejemplo, ante:

```text
/alumnos/152
```

puede ser preferible responder:

```text
404 Not Found
```

en lugar de distinguir siempre entre:

```text
403 Forbidden
```

y:

```text
404 Not Found
```

si esa diferencia revela información innecesaria sobre recursos internos.

La estrategia concreta dependerá de la aplicación.

## Funciones reutilizables

Conviene concentrar las reglas de autorización en funciones o servicios reutilizables.

Por ejemplo:

```php
function requireAuth(): int
{
    if (!isset($_SESSION['usuario_id'])) {
        http_response_code(401);
        exit;
    }

    return (int) $_SESSION['usuario_id'];
}
```

```php
function requireRole(string $rol): void
{
    if (($_SESSION['rol'] ?? null) !== $rol) {
        http_response_code(403);
        exit;
    }
}
```

```php
function requireProfesorAlumno(
    PDO $pdo,
    int $profesorId,
    int $alumnoId
): void {
    if (
        !profesorPuedeGestionarAlumno(
            $pdo,
            $profesorId,
            $alumnoId
        )
    ) {
        http_response_code(403);
        exit;
    }
}
```

Esto evita que cada controlador implemente los permisos de una forma diferente.

## Ejemplo en una API

El mismo principio se aplica a endpoints JSON.

Por ejemplo:

```text
PATCH /api/alumnos/152/nota
```

El servidor debe:

1. comprobar la sesión;
2. obtener el profesor autenticado;
3. validar `152`;
4. comprobar que puede gestionar ese alumno;
5. validar la nueva nota;
6. actualizar mediante una consulta preparada.

No importa que la petición proceda de Vue, Axios o cualquier otro cliente.

La autorización sigue siendo responsabilidad del servidor.

## Ejemplo en TxurdiGest

Un profesor con identificador `12` solicita modificar la nota del alumno `152`.

La aplicación debe comprobar:

```text
Sesión válida
    ↓
usuario_id = 12
    ↓
rol = profesor
    ↓
¿el alumno 152 pertenece a uno de sus grupos?
    ↓
sí
    ↓
actualizar nota
```

Si modifica la petición y cambia:

```text
alumno_id=152
```

por:

```text
alumno_id=487
```

el servidor debe volver a comprobar la relación y rechazar la operación si ese alumno no pertenece a sus grupos.

## Buenas prácticas

- Comprueba autorización en el servidor.
- Obtén la identidad desde la sesión.
- No confíes en roles ni identificadores de usuario enviados por el cliente.
- Utiliza roles para permisos generales.
- Comprueba también la relación entre usuario y recurso cuando sea necesario.
- Autoriza antes de ejecutar la operación.
- Centraliza las reglas de autorización.
- Protege tanto páginas HTML como endpoints y APIs.
- Utiliza JavaScript únicamente para adaptar la interfaz.
- No confundas que un recurso exista con que el usuario pueda acceder a él.

## Resumen

- La autorización se comprueba después de identificar al usuario y antes de ejecutar la acción.
- Los roles no siempre son suficientes: muchas operaciones dependen del recurso concreto.
- La identidad autenticada debe obtenerse de la sesión.
- Los datos enviados por el cliente nunca demuestran por sí mismos que exista permiso.
- Las funciones reutilizables ayudan a aplicar políticas de autorización de forma consistente.
