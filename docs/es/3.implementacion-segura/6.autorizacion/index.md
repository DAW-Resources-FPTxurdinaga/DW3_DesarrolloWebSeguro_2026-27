# Autorización

La autenticación permite saber quién realiza una petición.

La autorización decide si ese usuario puede ejecutar la operación solicitada.

Esta diferencia es fundamental:

```text
Autenticación
    ↓
¿Quién eres?

Autorización
    ↓
¿Puedes hacer esto?
```

Una aplicación puede identificar correctamente a un usuario y, aun así, permitirle acceder a funciones o recursos que no le corresponden.

## Autenticado no significa autorizado

Supongamos que un profesor ha iniciado sesión correctamente.

La sesión puede contener:

```php
$_SESSION['usuario_id'] = 12;
$_SESSION['rol'] = 'profesor';
```

Esto demuestra que existe un usuario autenticado.

Pero no significa que pueda:

- modificar cualquier calificación;
- consultar cualquier grupo;
- eliminar usuarios;
- acceder a funciones administrativas.

Cada operación sensible debe comprobar sus propios requisitos de autorización.

## Autorización por rol

Una forma sencilla de autorización consiste en asignar permisos según el rol.

Por ejemplo:

```text
Administrador
    ↓
gestiona usuarios

Profesor
    ↓
gestiona grupos y calificaciones

Alumno
    ↓
consulta sus propios datos
```

En PHP puede comprobarse:

```php
if ($_SESSION['rol'] !== 'administrador') {
    http_response_code(403);
    exit('No dispone de permisos.');
}
```

Este control puede ser suficiente para operaciones asociadas claramente a un rol.

## El rol no siempre es suficiente

En muchas aplicaciones, dos usuarios con el mismo rol no deben acceder a los mismos recursos.

Por ejemplo, dos profesores pueden tener el rol:

```text
profesor
```

pero cada uno debería modificar únicamente las calificaciones de los grupos que tiene asignados.

Por tanto, una comprobación como:

```php
if ($_SESSION['rol'] === 'profesor') {
    // permitir
}
```

puede ser insuficiente.

También debe comprobarse la relación entre:

- usuario;
- recurso;
- acción solicitada.

## Autorización sobre recursos

Supongamos una petición:

```text
POST /calificaciones/actualizar.php
```

con:

```text
alumno_id=152
nota=8.5
```

El servidor debe comprobar:

1. que el usuario está autenticado;
2. que tiene el rol adecuado;
3. que el alumno pertenece a un grupo gestionado por ese profesor;
4. que la operación solicitada está permitida.

Conceptualmente:

```text
Usuario autenticado
        ↓
Rol adecuado
        ↓
Acceso al recurso
        ↓
Operación permitida
        ↓
Ejecutar acción
```

## No confiar en identificadores enviados por el cliente

Un error frecuente consiste en asumir que un identificador es seguro porque procede de un enlace o de un campo oculto.

Por ejemplo:

```html
<input
    type="hidden"
    name="alumno_id"
    value="152"
>
```

El usuario puede modificar ese valor antes de enviar la petición.

Por tanto, el servidor no puede interpretar:

```text
alumno_id=152
```

como una prueba de que el usuario tiene permiso sobre ese alumno.

Debe comprobarlo utilizando información controlada por la aplicación.

## Ocultar botones no es autorización

JavaScript puede adaptar la interfaz según el usuario.

Por ejemplo:

```js
if (usuario.rol !== 'administrador') {
    botonEliminar.hidden = true;
}
```

Esto puede mejorar la experiencia de uso.

Pero el usuario puede:

- modificar JavaScript;
- volver a mostrar el botón;
- construir la petición manualmente;
- enviar directamente la solicitud HTTP.

Por tanto:

> **Ocultar una función en la interfaz no impide ejecutarla.**

El servidor debe comprobar siempre el permiso.

## Código de respuesta

Cuando un usuario no está autenticado, suele utilizarse:

```text
401 Unauthorized
```

Cuando está autenticado pero no tiene permiso para la operación:

```text
403 Forbidden
```

Esta diferencia ayuda a representar correctamente el estado de la petición.

## Ejemplo en TxurdiGest

Supongamos que el profesor con identificador `12` intenta modificar la nota del alumno `152`.

La aplicación no debería limitarse a comprobar:

```php
$_SESSION['rol'] === 'profesor'
```

También debería verificar una relación como:

```text
profesor 12
    ↓
grupo asignado
    ↓
alumno 152
```

Solo si la relación existe debería permitirse modificar la calificación.

Esto evita que un profesor pueda cambiar manualmente el identificador de alumno y actuar sobre registros ajenos.

## Autorización en cada operación

Las comprobaciones deben realizarse en todas las operaciones protegidas.

Por ejemplo:

```text
GET
↓
consultar recurso
↓
comprobar permiso

POST
↓
crear recurso
↓
comprobar permiso

PUT / PATCH
↓
modificar recurso
↓
comprobar permiso

DELETE
↓
eliminar recurso
↓
comprobar permiso
```

No basta con proteger únicamente las páginas de navegación.

La autorización debe aplicarse donde realmente se ejecuta la acción.

## Implementación

En [Implementación](implementacion.md) trabajaremos:

- comprobaciones de rol;
- comprobaciones sobre recursos;
- funciones reutilizables de autorización;
- uso de la identidad almacenada en sesión;
- respuestas `401` y `403`;
- relación entre interfaz JavaScript y protección real en servidor.

## Resumen

- Autenticación y autorización son mecanismos distintos.
- Estar autenticado no implica tener permiso para cualquier operación.
- Los roles permiten aplicar controles generales.
- Muchas operaciones requieren comprobar también la relación del usuario con el recurso.
- Los identificadores enviados por el cliente no demuestran autorización.
- Ocultar controles mediante JavaScript no protege la operación.
- La autorización debe comprobarse siempre en el servidor.
