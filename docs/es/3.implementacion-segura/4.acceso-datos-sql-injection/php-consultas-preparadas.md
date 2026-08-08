# PHP y consultas preparadas

La forma recomendada de trabajar con SQL desde PHP es utilizar **consultas preparadas**.

Su objetivo principal es mantener separados:

```text
Instrucción SQL
        +
Datos
```

de forma que los valores recibidos no puedan modificar la estructura de la consulta.

## Conexión mediante PDO

Un ejemplo sencillo de conexión puede ser:

```php
$dsn = 'mysql:host=localhost;dbname=txurdigest;charset=utf8mb4';

$pdo = new PDO(
    $dsn,
    'usuario_app',
    'clave_app',
    [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
    ]
);
```

En una aplicación real, las credenciales no deberían aparecer directamente en el código fuente. La gestión de secretos y configuración se abordará en el bloque dedicado al despliegue seguro.

## Consulta preparada con parámetros

Supongamos que queremos buscar un usuario por correo electrónico.

La consulta puede definirse así:

```php
$sql = "
    SELECT id, nombre, email
    FROM usuarios
    WHERE email = :email
";
```

El marcador `:email` representa un parámetro.

Después se prepara la consulta:

```php
$stmt = $pdo->prepare($sql);
```

Y finalmente se ejecuta enviando el valor por separado:

```php
$stmt->execute([
    'email' => $email
]);
```

El dato no se concatena dentro de la cadena SQL.

## Recuperar resultados

Después de ejecutar la consulta:

```php
$usuario = $stmt->fetch();
```

Podemos comprobar si existe:

```php
if ($usuario === false) {
    // No se ha encontrado ningún usuario.
}
```

Un ejemplo completo sería:

```php
$email = trim($_POST['email'] ?? '');

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    http_response_code(422);
    exit('Correo electrónico no válido.');
}

$sql = "
    SELECT id, nombre, email
    FROM usuarios
    WHERE email = :email
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'email' => $email
]);

$usuario = $stmt->fetch();
```

Aquí aparecen dos controles complementarios:

```text
filter_var()
    ↓
comprueba si el dato es válido

prepare() + execute()
    ↓
protege la estructura de la consulta SQL
```

## Consultar mediante un identificador

Un identificador recibido desde una URL también debe validarse y parametrizarse.

```php
$id = filter_input(
    INPUT_GET,
    'id',
    FILTER_VALIDATE_INT
);

if ($id === false || $id === null) {
    http_response_code(400);
    exit('Identificador no válido.');
}
```

Después:

```php
$sql = "
    SELECT id, nombre, email
    FROM alumnos
    WHERE id = :id
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'id' => $id
]);

$alumno = $stmt->fetch();
```

No debe construirse:

```php
$sql = "SELECT * FROM alumnos WHERE id = $id";
```

aunque previamente se espere que `$id` sea numérico.

Parametrizar sistemáticamente las consultas reduce errores y hace más claro el código.

## Insertar datos

Las consultas preparadas también deben utilizarse en operaciones `INSERT`.

```php
$sql = "
    INSERT INTO alumnos (nombre, email)
    VALUES (:nombre, :email)
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'nombre' => $nombre,
    'email' => $email
]);
```

Los valores continúan separados de la instrucción SQL.

## Actualizar datos

Ejemplo:

```php
$sql = "
    UPDATE alumnos
    SET email = :email
    WHERE id = :id
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'email' => $email,
    'id' => $id
]);
```

## Eliminar datos

También en `DELETE`:

```php
$sql = "
    DELETE FROM alumnos
    WHERE id = :id
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'id' => $id
]);
```

No existe una excepción por tratarse de una operación sencilla.

## Parámetros posicionales

PDO también permite utilizar `?`:

```php
$sql = "
    SELECT id, nombre
    FROM alumnos
    WHERE grupo_id = ?
      AND activo = ?
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    $grupoId,
    1
]);
```

Sin embargo, cuando una consulta tiene varios parámetros, los nombres suelen facilitar su lectura:

```php
$sql = "
    SELECT id, nombre
    FROM alumnos
    WHERE grupo_id = :grupo_id
      AND activo = :activo
";
```

```php
$stmt->execute([
    'grupo_id' => $grupoId,
    'activo' => 1
]);
```

## `bindValue()`

Otra posibilidad consiste en asociar explícitamente cada parámetro.

```php
$stmt = $pdo->prepare(
    "SELECT * FROM alumnos WHERE id = :id"
);

$stmt->bindValue(
    ':id',
    $id,
    PDO::PARAM_INT
);

$stmt->execute();
```

Esto puede ser útil cuando interesa indicar de forma explícita el tipo del parámetro.

Para muchos casos habituales, pasar un array a `execute()` resulta más sencillo y legible.

## Parámetros para datos, no para estructura SQL

Los parámetros representan **valores**.

No pueden utilizarse directamente para sustituir partes estructurales de SQL.

Por ejemplo, esto no debe plantearse como:

```php
$sql = "SELECT * FROM alumnos ORDER BY :campo";
```

si se pretende que `:campo` sustituya dinámicamente el nombre de una columna.

Cuando una parte estructural de la consulta debe variar, debe seleccionarse a partir de una lista controlada por la aplicación.

Por ejemplo:

```php
$camposPermitidos = [
    'nombre',
    'email',
    'fecha_alta'
];

$orden = $_GET['orden'] ?? 'nombre';

if (!in_array($orden, $camposPermitidos, true)) {
    $orden = 'nombre';
}

$sql = "
    SELECT id, nombre, email
    FROM alumnos
    ORDER BY $orden
";
```

Aquí `$orden` no procede libremente del usuario: la aplicación solo permite valores de una lista cerrada.

!!! warning "Los parámetros no sustituyen nombres SQL"

    Las consultas preparadas parametrizan valores. Los nombres de tablas, columnas y otras partes de la estructura SQL deben controlarse mediante lógica de aplicación.

## Consultas dinámicas

En ocasiones una consulta depende de filtros opcionales.

Por ejemplo:

- grupo;
- estado;
- nombre.

Una forma segura consiste en construir únicamente fragmentos SQL definidos por la aplicación y almacenar por separado los parámetros.

```php
$sql = "
    SELECT id, nombre, email
    FROM alumnos
    WHERE 1 = 1
";

$parametros = [];

if ($grupoId !== null) {
    $sql .= " AND grupo_id = :grupo_id";
    $parametros['grupo_id'] = $grupoId;
}

if ($estado !== null) {
    $sql .= " AND estado = :estado";
    $parametros['estado'] = $estado;
}

$stmt = $pdo->prepare($sql);
$stmt->execute($parametros);
```

La aplicación construye la estructura SQL.

Los datos continúan enviándose mediante parámetros.

## No concatenar aunque el dato haya sido validado

Este patrón sigue siendo desaconsejable:

```php
$id = filter_input(
    INPUT_GET,
    'id',
    FILTER_VALIDATE_INT
);

$sql = "SELECT * FROM alumnos WHERE id = $id";
```

La validación reduce el riesgo en este caso concreto, pero mezcla responsabilidades y genera un patrón de programación fácil de utilizar incorrectamente en otros puntos.

Es preferible mantener una regla uniforme:

> **Todo dato utilizado como valor SQL se envía como parámetro.**

## No intentar escapar manualmente las consultas

Tampoco conviene construir consultas de esta forma:

```php
$email = addslashes($email);

$sql = "
    SELECT *
    FROM usuarios
    WHERE email = '$email'
";
```

Ni mediante sustituciones improvisadas:

```php
$email = str_replace("'", "", $email);
```

Estas técnicas intentan adaptar manualmente el dato a la sintaxis SQL.

Las consultas preparadas resuelven el problema de forma más clara y robusta.

## Errores de base de datos

Una aplicación tampoco debería mostrar al usuario errores SQL completos.

Por ejemplo, no debería devolver directamente:

```php
echo $e->getMessage();
```

si ese mensaje puede contener:

- nombres de tablas;
- columnas;
- consultas;
- rutas internas;
- detalles del servidor.

En producción, el usuario debe recibir un mensaje controlado y el detalle técnico debe registrarse internamente.

```php
try {
    $stmt = $pdo->prepare($sql);
    $stmt->execute($parametros);
} catch (PDOException $e) {
    error_log($e->getMessage());

    http_response_code(500);
    exit('No se ha podido completar la operación.');
}
```

## Principio de mínimo privilegio

La cuenta utilizada por la aplicación para acceder a la base de datos debería disponer únicamente de los permisos necesarios.

Por ejemplo, una aplicación no debería conectarse normalmente utilizando una cuenta administrativa de MySQL.

La parametrización protege la construcción de consultas, mientras que los permisos de la cuenta limitan el impacto de posibles errores o fallos.

Ambos controles son complementarios.

## Ejemplo en TxurdiGest

Supongamos que un profesor modifica una calificación.

La aplicación recibe:

```text
alumno_id=152
nota=8.5
```

Primero valida los datos:

```php
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
```

Después comprueba la autorización correspondiente.

Y finalmente actualiza mediante parámetros:

```php
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

El flujo seguro completo no depende de una única medida:

```text
Entrada
   ↓
Validación
   ↓
Autorización
   ↓
Consulta preparada
   ↓
Base de datos
```

## Buenas prácticas

- Utiliza PDO y consultas preparadas.
- No concatentes datos recibidos dentro de SQL.
- Parametriza `SELECT`, `INSERT`, `UPDATE` y `DELETE`.
- Valida los datos antes de utilizarlos.
- Utiliza listas cerradas para elementos estructurales dinámicos como campos de ordenación.
- No escapes manualmente valores SQL.
- No muestres errores internos de base de datos al usuario.
- Utiliza una cuenta de base de datos con los permisos mínimos necesarios.
- Mantén una regla uniforme: los valores se envían mediante parámetros.

## Resumen

- `prepare()` define la estructura de la consulta.
- `execute()` proporciona los datos de forma separada.
- Los parámetros sirven para valores, no para nombres de tablas o columnas.
- Las consultas preparadas deben utilizarse de forma sistemática en todas las operaciones SQL.
- Validación, autorización, parametrización y permisos de base de datos son controles complementarios.
