# Acceso seguro a datos y SQL Injection

Una aplicación web suele construir consultas a base de datos utilizando información recibida desde formularios, URLs, sesiones o APIs.

Si esos datos se incorporan directamente a una consulta SQL, pueden modificar la instrucción que el servidor pretendía ejecutar.

Este problema se conoce como **SQL Injection**.

## El problema no está en SQL, sino en cómo se construye la consulta

Supongamos una búsqueda sencilla por correo electrónico.

Una implementación insegura podría ser:

```php
$email = $_POST['email'] ?? '';

$sql = "SELECT * FROM usuarios WHERE email = '$email'";
```

Aquí el valor de `$email` se concatena directamente dentro de la consulta.

La aplicación está mezclando dos cosas diferentes:

```text
Código SQL
+
Dato recibido
```

Si el dato contiene caracteres con significado para SQL, puede alterar la estructura de la consulta.

## Separar instrucciones y datos

La idea fundamental para evitar SQL Injection es:

> **El código SQL debe definirse por un lado y los datos deben enviarse por otro.**

En PHP con PDO se consigue mediante consultas preparadas.

Por ejemplo:

```php
$sql = "SELECT * FROM usuarios WHERE email = :email";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'email' => $email
]);
```

Ahora `:email` representa un parámetro.

El motor de base de datos conoce la estructura de la consulta antes de recibir el valor concreto y trata ese valor como dato, no como parte de la instrucción SQL.

## Validar no sustituye a parametrizar

La validación de entradas sigue siendo necesaria.

Por ejemplo, un correo electrónico debe comprobarse:

```php
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    // Rechazar el dato.
}
```

Pero una validación correcta no debe utilizarse como sustituto de las consultas preparadas.

Son controles diferentes:

| Validación | Consulta preparada |
|---|---|
| Comprueba si el dato cumple las reglas de la aplicación. | Separa los datos de la instrucción SQL. |
| Puede rechazar formatos o valores incorrectos. | Evita que el dato modifique la estructura de la consulta. |
| Forma parte del tratamiento de entradas. | Forma parte del acceso seguro a la base de datos. |

Una aplicación segura utiliza ambos mecanismos cuando corresponda.

## No confiar en datos internos

SQL Injection no aparece únicamente con valores escritos directamente en un formulario.

Un dato puede proceder de:

- parámetros de URL;
- campos ocultos;
- cookies;
- peticiones JSON;
- datos almacenados previamente;
- servicios externos.

Por ejemplo:

```php
$id = $_GET['id'] ?? '';

$sql = "SELECT * FROM alumnos WHERE id = $id";
```

Aunque la interfaz genere normalmente identificadores válidos, la petición puede modificarse.

La consulta sigue estando construida de forma insegura.

## Ejemplo en TxurdiGest

Supongamos que TxurdiGest permite consultar los datos de un alumno mediante su identificador.

Una implementación insegura podría construir:

```php
$id = $_GET['id'] ?? '';

$sql = "SELECT * FROM alumnos WHERE id = $id";
```

La forma segura será utilizar un parámetro:

```php
$sql = "SELECT * FROM alumnos WHERE id = :id";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'id' => $id
]);
```

Además, el identificador debería validarse antes de utilizarlo:

```php
$id = filter_input(
    INPUT_GET,
    'id',
    FILTER_VALIDATE_INT
);
```

La validación comprueba el dato.

La consulta preparada protege la estructura SQL.

## Consultas de lectura y escritura

La parametrización debe utilizarse tanto al consultar datos como al modificarlos.

Por ejemplo:

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

Lo mismo se aplica a:

- `SELECT`;
- `INSERT`;
- `UPDATE`;
- `DELETE`.

## Lo que no debe hacerse

No es recomendable intentar proteger una consulta mediante concatenaciones acompañadas de filtros improvisados.

Por ejemplo:

```php
$email = str_replace("'", "", $_POST['email']);
```

o:

```php
$sql = "SELECT * FROM usuarios WHERE email = '" .
       addslashes($email) .
       "'";
```

Estas soluciones mezclan el problema de los datos con la construcción de la consulta y pueden generar una falsa sensación de seguridad.

La estrategia correcta es utilizar la interfaz de acceso a datos de forma segura desde el principio.

## Apartados

En este tema trabajaremos:

- [PHP y consultas preparadas](php-consultas-preparadas.md): uso de PDO, parámetros y patrones seguros de acceso a datos.
- [Laboratorio DVWA](laboratorio-dvwa.md): análisis de una consulta vulnerable, identificación de la causa y comparación con una implementación parametrizada.

## Resumen

- SQL Injection aparece cuando datos no confiables pueden modificar una instrucción SQL.
- Concatenar valores dentro de una consulta es una práctica insegura.
- Las consultas preparadas mantienen separados código SQL y datos.
- Validar entradas y parametrizar consultas son controles complementarios.
- La parametrización debe aplicarse tanto a consultas de lectura como de escritura.
