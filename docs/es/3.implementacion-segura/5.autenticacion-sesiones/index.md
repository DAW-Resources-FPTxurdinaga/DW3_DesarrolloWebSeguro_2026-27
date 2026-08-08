# Autenticación y sesiones

La autenticación permite comprobar la identidad de un usuario antes de concederle acceso a determinadas funciones de la aplicación.

En una aplicación web, este proceso suele implicar:

- recibir unas credenciales;
- comprobarlas en el servidor;
- crear una sesión;
- identificar al usuario en las peticiones posteriores;
- cerrar la sesión cuando deja de ser necesaria.

En este bloque no volveremos a desarrollar los conceptos generales de autenticación vistos anteriormente. El objetivo ahora es **implementarlos correctamente en PHP**.

## Flujo básico de autenticación

Un proceso de inicio de sesión puede representarse así:

```text
Usuario introduce credenciales
        ↓
Petición al servidor
        ↓
Validación de datos
        ↓
Búsqueda del usuario
        ↓
Comprobación de contraseña
        ↓
Creación de sesión
        ↓
Acceso autenticado
```

Cada fase debe realizarse en el servidor.

El navegador puede mostrar formularios o mensajes, pero no debe decidir si una identidad es válida.

## Contraseñas

Las contraseñas no deben almacenarse directamente en texto plano.

Una aplicación debe guardar una representación derivada mediante una función específica para contraseñas.

En PHP se utilizan funciones como:

```php
password_hash()
```

y:

```php
password_verify()
```

La aplicación almacena el hash generado y posteriormente compara la contraseña introducida con ese hash.

```text
Registro

Contraseña
    ↓
password_hash()
    ↓
Hash almacenado
```

```text
Inicio de sesión

Contraseña introducida
        ↓
password_verify()
        ↓
Comparación con el hash
        ↓
Identidad verificada
```

## Sesiones

Después de autenticar correctamente al usuario, la aplicación necesita reconocerlo en las peticiones posteriores.

PHP permite gestionar este estado mediante sesiones.

Conceptualmente:

```text
Inicio de sesión correcto
        ↓
Servidor crea una sesión
        ↓
Navegador recibe identificador de sesión
        ↓
Peticiones posteriores
        ↓
Servidor recupera la sesión
```

La información sensible permanece en el servidor.

El navegador conserva únicamente el identificador necesario para asociar cada petición con su sesión.

## Qué puede almacenarse en la sesión

Una sesión puede contener información como:

```php
$_SESSION['usuario_id']
```

o:

```php
$_SESSION['rol']
```

Por ejemplo:

```php
$_SESSION['usuario_id'] = $usuario['id'];
$_SESSION['rol'] = $usuario['rol'];
```

No es necesario almacenar todos los datos del usuario.

Conviene conservar únicamente la información necesaria para identificarlo y gestionar la petición.

## Autenticación no es autorización

Que un usuario haya iniciado sesión correctamente no significa que pueda realizar cualquier operación.

Por ejemplo:

```text
Usuario autenticado
        ↓
quiere modificar una calificación
        ↓
¿Tiene permiso?
```

La autenticación responde:

> **¿Quién es el usuario?**

La autorización responde:

> **¿Puede realizar esta operación?**

La autorización se estudiará en el siguiente apartado del bloque.

## Cookies de sesión

En PHP, el identificador de sesión suele enviarse mediante una cookie.

Esta cookie debe configurarse adecuadamente.

Entre los atributos relevantes se encuentran:

- `Secure`;
- `HttpOnly`;
- `SameSite`.

Estos atributos ya se estudiaron desde el punto de vista conceptual. En la implementación veremos cómo configurarlos y cómo afectan al comportamiento de la sesión.

## Regenerar el identificador de sesión

Cuando cambia el nivel de confianza asociado a una sesión —por ejemplo, después de un inicio de sesión correcto— conviene generar un nuevo identificador.

En PHP puede realizarse mediante:

```php
session_regenerate_id(true);
```

Esto evita continuar utilizando innecesariamente el mismo identificador de sesión existente antes de autenticar al usuario.

## Cierre de sesión

Cerrar una sesión correctamente implica eliminar el estado asociado al usuario.

No basta con ocultar la interfaz o redirigir a otra página.

Conceptualmente:

```text
Usuario solicita cerrar sesión
        ↓
Servidor elimina los datos de sesión
        ↓
Invalida la sesión actual
        ↓
Usuario deja de estar autenticado
```

## Ejemplo en TxurdiGest

Supongamos que un profesor inicia sesión.

El flujo podría ser:

```text
email + contraseña
        ↓
PHP valida los datos
        ↓
consulta preparada busca el usuario
        ↓
password_verify()
        ↓
session_regenerate_id()
        ↓
$_SESSION['usuario_id']
        ↓
usuario autenticado
```

A partir de ese momento, cada operación protegida podrá comprobar la existencia de una sesión válida.

Por ejemplo:

```php
if (!isset($_SESSION['usuario_id'])) {
    http_response_code(401);
    exit;
}
```

Esta comprobación identifica que existe un usuario autenticado.

Todavía será necesario comprobar después si tiene permiso para ejecutar la acción solicitada.

## Implementación

En [Implementación](implementacion.md) trabajaremos:

- almacenamiento seguro de contraseñas;
- registro de usuarios;
- comprobación de credenciales;
- creación de sesiones;
- regeneración del identificador;
- configuración de cookies de sesión;
- protección de páginas;
- cierre de sesión.

## Resumen

- La autenticación debe comprobarse en el servidor.
- Las contraseñas deben almacenarse mediante funciones específicas de hash.
- `password_verify()` permite comprobar una contraseña sin almacenar su valor original.
- Las sesiones permiten mantener el estado de autenticación entre peticiones.
- El identificador de sesión debe gestionarse de forma segura.
- Autenticación y autorización son mecanismos diferentes.
