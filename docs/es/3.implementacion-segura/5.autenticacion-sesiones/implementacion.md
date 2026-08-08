# Implementación de autenticación y sesiones

La implementación de autenticación debe concentrar las decisiones de seguridad en el servidor.

El navegador envía las credenciales, pero es PHP quien debe:

1. validar los datos recibidos;
2. localizar al usuario;
3. comprobar la contraseña;
4. crear la sesión;
5. identificar al usuario en peticiones posteriores;
6. destruir la sesión cuando finaliza.

## Registro de usuarios

Cuando se crea una cuenta, la contraseña no debe almacenarse directamente.

Una implementación incorrecta sería:

```php
$clave = $_POST['password'] ?? '';

$sql = "
    INSERT INTO usuarios (email, password)
    VALUES (:email, :password)
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'email' => $email,
    'password' => $clave
]);
```

La base de datos contendría la contraseña original.

Esto no debe hacerse.

## Crear un hash con `password_hash()`

PHP proporciona `password_hash()` para generar una representación adecuada para almacenar contraseñas.

```php
$password = $_POST['password'] ?? '';

$hash = password_hash(
    $password,
    PASSWORD_DEFAULT
);
```

Después se almacena `$hash`:

```php
$sql = "
    INSERT INTO usuarios (email, password_hash)
    VALUES (:email, :password_hash)
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'email' => $email,
    'password_hash' => $hash
]);
```

La contraseña original no se guarda.

!!! tip "Utiliza `PASSWORD_DEFAULT`"

    `PASSWORD_DEFAULT` permite que PHP utilice el algoritmo recomendado por la plataforma sin fijar manualmente uno concreto en el código.

La columna de base de datos utilizada para almacenar el hash debe disponer de longitud suficiente. Una opción habitual es utilizar un campo `VARCHAR(255)`.

## No utilizar hashes genéricos para contraseñas

No deben utilizarse directamente funciones como:

```php
md5($password);
```

o:

```php
sha1($password);
```

Tampoco es necesario diseñar manualmente un sistema de *salt*.

Las funciones específicas de PHP para contraseñas gestionan estos aspectos de forma adecuada.

La regla práctica es:

```text
Crear contraseña
    ↓
password_hash()

Comprobar contraseña
    ↓
password_verify()
```

## Inicio de sesión

Supongamos un formulario:

```html
<form method="post" action="login.php">
    <label for="email">Correo electrónico</label>
    <input
        type="email"
        id="email"
        name="email"
        required
    >

    <label for="password">Contraseña</label>
    <input
        type="password"
        id="password"
        name="password"
        required
    >

    <button type="submit">Entrar</button>
</form>
```

PHP recibe y valida los datos:

```php
$email = trim($_POST['email'] ?? '');
$password = $_POST['password'] ?? '';

if (
    !filter_var($email, FILTER_VALIDATE_EMAIL) ||
    $password === ''
) {
    http_response_code(422);
    exit('Credenciales no válidas.');
}
```

## Buscar al usuario mediante una consulta preparada

```php
$sql = "
    SELECT id, email, password_hash, rol
    FROM usuarios
    WHERE email = :email
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'email' => $email
]);

$usuario = $stmt->fetch();
```

La consulta debe seguir los mismos principios de acceso seguro a datos estudiados anteriormente.

## Comprobar la contraseña

No se compara la contraseña con el hash mediante `===`.

Se utiliza:

```php
password_verify(
    $password,
    $usuario['password_hash']
);
```

El flujo puede implementarse así:

```php
if (
    $usuario === false ||
    !password_verify(
        $password,
        $usuario['password_hash']
    )
) {
    http_response_code(401);
    exit('Credenciales no válidas.');
}
```

El mensaje no necesita indicar si ha fallado:

- el correo;
- la contraseña;
- o ambos.

Esto evita proporcionar información innecesaria sobre qué cuentas existen.

## Configurar la cookie de sesión

Antes de iniciar la sesión conviene definir sus parámetros.

Por ejemplo:

```php
session_set_cookie_params([
    'httponly' => true,
    'secure' => true,
    'samesite' => 'Lax'
]);

session_start();
```

Estos atributos cumplen funciones diferentes.

### `HttpOnly`

```text
HttpOnly
```

impide que JavaScript acceda normalmente a la cookie mediante `document.cookie`.

### `Secure`

```text
Secure
```

indica que la cookie debe enviarse únicamente mediante HTTPS.

Por tanto, en producción la aplicación debe utilizar HTTPS.

### `SameSite`

```text
SameSite=Lax
```

limita determinados envíos de la cookie en peticiones iniciadas desde otros sitios.

La elección concreta de `Lax`, `Strict` o `None` depende del funcionamiento requerido por la aplicación.

!!! warning "Configurar antes de iniciar la sesión"

    Los parámetros de la cookie deben definirse antes de ejecutar `session_start()`.

## Crear la sesión después del login

Cuando las credenciales son correctas:

```php
session_regenerate_id(true);

$_SESSION['usuario_id'] = $usuario['id'];
$_SESSION['rol'] = $usuario['rol'];
```

`session_regenerate_id(true)` genera un nuevo identificador de sesión y elimina el anterior.

Es especialmente importante hacerlo cuando el usuario pasa de un estado no autenticado a autenticado.

El flujo queda:

```text
Credenciales correctas
        ↓
regenerar ID de sesión
        ↓
guardar identidad en $_SESSION
        ↓
usuario autenticado
```

## Qué almacenar en `$_SESSION`

Conviene almacenar únicamente la información necesaria.

Por ejemplo:

```php
$_SESSION['usuario_id'] = $usuario['id'];
```

y, si facilita la lógica:

```php
$_SESSION['rol'] = $usuario['rol'];
```

No es recomendable copiar en la sesión todos los datos de la cuenta sin necesidad.

Tampoco debe almacenarse la contraseña.

## Proteger una página

Una página que requiera autenticación puede comenzar comprobando la sesión.

```php
session_start();

if (!isset($_SESSION['usuario_id'])) {
    http_response_code(401);
    exit('Debes iniciar sesión.');
}
```

Después puede recuperarse la identidad:

```php
$usuarioId = $_SESSION['usuario_id'];
```

Esto comprueba que existe una sesión autenticada.

No comprueba todavía si el usuario puede realizar una operación concreta.

Ese control corresponde a la autorización.

## Centralizar la comprobación

En lugar de repetir el mismo código en todas las páginas, puede encapsularse.

Por ejemplo:

```php
function requireAuth(): int
{
    if (!isset($_SESSION['usuario_id'])) {
        http_response_code(401);
        exit('Debes iniciar sesión.');
    }

    return (int) $_SESSION['usuario_id'];
}
```

Después:

```php
session_start();

$usuarioId = requireAuth();
```

Centralizar estos controles reduce duplicación y facilita mantener un comportamiento coherente.

## Ejemplo completo de login

Una versión simplificada podría ser:

```php
<?php

session_set_cookie_params([
    'httponly' => true,
    'secure' => true,
    'samesite' => 'Lax'
]);

session_start();

$email = trim($_POST['email'] ?? '');
$password = $_POST['password'] ?? '';

if (
    !filter_var($email, FILTER_VALIDATE_EMAIL) ||
    $password === ''
) {
    http_response_code(422);
    exit('Credenciales no válidas.');
}

$sql = "
    SELECT id, password_hash, rol
    FROM usuarios
    WHERE email = :email
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'email' => $email
]);

$usuario = $stmt->fetch();

if (
    $usuario === false ||
    !password_verify(
        $password,
        $usuario['password_hash']
    )
) {
    http_response_code(401);
    exit('Credenciales no válidas.');
}

session_regenerate_id(true);

$_SESSION['usuario_id'] = $usuario['id'];
$_SESSION['rol'] = $usuario['rol'];
```

Este ejemplo reúne varios mecanismos del bloque:

- validación;
- consulta preparada;
- hash de contraseñas;
- sesión;
- configuración de cookie.

## Cierre de sesión

Cerrar sesión requiere eliminar los datos almacenados:

```php
$_SESSION = [];
```

Después puede eliminarse la cookie de sesión:

```php
if (ini_get('session.use_cookies')) {
    $params = session_get_cookie_params();

    setcookie(
        session_name(),
        '',
        time() - 42000,
        $params['path'],
        $params['domain'],
        $params['secure'],
        $params['httponly']
    );
}
```

Y finalmente destruir la sesión:

```php
session_destroy();
```

Una versión completa:

```php
session_start();

$_SESSION = [];

if (ini_get('session.use_cookies')) {
    $params = session_get_cookie_params();

    setcookie(
        session_name(),
        '',
        time() - 42000,
        $params['path'],
        $params['domain'],
        $params['secure'],
        $params['httponly']
    );
}

session_destroy();
```

Después puede redirigirse al usuario:

```php
header('Location: /login.php');
exit;
```

## No utilizar datos del cliente para decidir la identidad

Una implementación insegura sería confiar en un identificador enviado por el navegador:

```html
<input
    type="hidden"
    name="usuario_id"
    value="15"
>
```

y después utilizarlo como identidad:

```php
$usuarioId = $_POST['usuario_id'];
```

El usuario puede modificar ese valor.

La identidad autenticada debe obtenerse de la sesión:

```php
$usuarioId = $_SESSION['usuario_id'];
```

Esta diferencia es fundamental.

## JavaScript no autentica al usuario

JavaScript puede cambiar la interfaz después del login:

```js
botonLogin.hidden = true;
panelUsuario.hidden = false;
```

Pero esto solo modifica lo que se muestra.

No protege ninguna operación.

Una petición al servidor debe comprobar siempre la sesión correspondiente.

```text
Interfaz
    ↓
JavaScript puede adaptarla

Operación protegida
    ↓
PHP comprueba la sesión
```

## Ejemplo en TxurdiGest

Supongamos que un profesor entra en TxurdiGest.

Después de comprobar las credenciales:

```php
session_regenerate_id(true);

$_SESSION['usuario_id'] = $usuario['id'];
$_SESSION['rol'] = 'profesor';
```

Cuando solicita modificar una calificación:

```php
session_start();

if (!isset($_SESSION['usuario_id'])) {
    http_response_code(401);
    exit;
}

$profesorId = $_SESSION['usuario_id'];
```

La aplicación sabe quién está realizando la petición.

En el siguiente apartado deberá comprobar además que ese profesor puede modificar la calificación solicitada.

## Buenas prácticas

- Nunca almacenes contraseñas en texto plano.
- Utiliza `password_hash()` para crear hashes.
- Utiliza `password_verify()` para comprobar contraseñas.
- Utiliza mensajes de error que no revelen si una cuenta concreta existe.
- Configura adecuadamente la cookie de sesión.
- Usa HTTPS cuando la cookie tenga `Secure`.
- Regenera el identificador después de autenticar al usuario.
- Obtén la identidad desde la sesión, no desde campos enviados por el cliente.
- Protege en el servidor todas las páginas y operaciones que requieran autenticación.
- Destruye correctamente la sesión durante el logout.
- No confundas autenticación con autorización.

## Resumen

- Las credenciales se comprueban siempre en el servidor.
- Las contraseñas se almacenan mediante hashes específicos para contraseñas.
- La sesión mantiene la identidad entre peticiones.
- `session_regenerate_id(true)` debe utilizarse al establecer una sesión autenticada.
- `Secure`, `HttpOnly` y `SameSite` ayudan a proteger la cookie de sesión.
- La identidad debe obtenerse de `$_SESSION`, no de datos controlados por el cliente.
