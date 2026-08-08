# Laboratorio: comprobar los límites de la validación en el cliente

En este laboratorio se demostrará que una validación realizada únicamente en JavaScript puede evitarse y que el servidor debe volver a comprobar los datos recibidos.

La idea no es explotar una aplicación, sino comprobar una decisión básica de desarrollo seguro:

> **El cliente puede ayudar al usuario, pero el servidor debe decidir si el dato es válido.**

## Escenario

Vamos a trabajar con un formulario sencillo para introducir una calificación.

El navegador limitará el valor entre `0` y `10`.

```html
<form method="post" action="guardar-nota.php">
    <label for="nota">Nota</label>

    <input
        type="number"
        id="nota"
        name="nota"
        min="0"
        max="10"
        step="0.1"
        required
    >

    <button type="submit">Guardar</button>
</form>
```

También podemos añadir una comprobación con JavaScript:

```js
const formulario = document.querySelector('form');

formulario.addEventListener('submit', (event) => {
    const nota = Number(
        document.querySelector('#nota').value
    );

    if (nota < 0 || nota > 10) {
        event.preventDefault();
        alert('La nota debe estar entre 0 y 10.');
    }
});
```

Con esta implementación, la interfaz no permite normalmente enviar una nota como:

```text
25
```

## Primera comprobación

Prueba el formulario desde el navegador.

Introduce varios valores:

```text
8
9.5
-1
25
```

Comprueba cuáles permite enviar la interfaz y cuáles rechaza.

La validación funciona correctamente desde el punto de vista de la experiencia del usuario.

Pero todavía no sabemos si la aplicación está protegida.

## Interceptar la petición

Activa Burp Suite como proxy del navegador e intercepta el envío de una nota válida.

Por ejemplo:

```text
nota=8
```

La petición puede contener una línea similar a:

```http
POST /guardar-nota.php HTTP/1.1
Content-Type: application/x-www-form-urlencoded

nota=8
```

Antes de reenviar la petición, modifica el valor:

```text
nota=25
```

y permite que la petición continúe hacia el servidor.

!!! question "Comprueba el resultado"

    ¿Qué ocurre cuando el servidor recibe un valor que la interfaz original no permitía introducir?

## Implementación insegura

Supongamos que `guardar-nota.php` utiliza directamente el dato recibido:

```php
$nota = $_POST['nota'];

guardarNota($nota);
```

El servidor está confiando en que el navegador ya ha realizado la validación.

Esto es incorrecto.

Burp Suite ha permitido comprobar que la petición HTTP puede modificarse antes de llegar al servidor.

También podría construirse directamente sin utilizar el formulario original.

## Corregir la implementación

El servidor debe validar nuevamente el dato.

```php
$nota = filter_input(
    INPUT_POST,
    'nota',
    FILTER_VALIDATE_FLOAT
);

if ($nota === false || $nota === null) {
    http_response_code(422);
    exit('La nota debe ser un número.');
}

if ($nota < 0 || $nota > 10) {
    http_response_code(422);
    exit('La nota debe estar comprendida entre 0 y 10.');
}

guardarNota($nota);
```

Ahora repite exactamente la misma prueba:

1. introduce una nota válida;
2. intercepta la petición;
3. cambia el valor a `25`;
4. reenvía la petición.

El servidor debe rechazarla.

## Comparación

El comportamiento esperado es:

```text
Validación solo en JavaScript

Usuario
   ↓
Formulario
   ↓
JavaScript
   ↓
Petición modificada
   ↓
Servidor
   ↓
Dato aceptado
```

frente a:

```text
Validación en cliente y servidor

Usuario
   ↓
Formulario
   ↓
JavaScript
   ↓
Petición modificada
   ↓
PHP valida
   ↓
Dato rechazado
```

## Aplicación a TxurdiGest

El mismo problema puede aparecer en muchos datos de una aplicación:

- notas;
- identificadores de alumnos;
- identificadores de grupos;
- estados;
- fechas;
- precios;
- roles;
- permisos.

Por ejemplo, aunque la interfaz solo permita seleccionar los grupos asignados a un profesor, el servidor debe comprobar que el identificador recibido realmente pertenece a uno de esos grupos.

La interfaz limita las opciones visibles.

El servidor protege la operación.

## Qué debe quedar demostrado

Al finalizar el laboratorio debe quedar claro que:

- las restricciones HTML pueden evitarse;
- JavaScript puede modificarse o no ejecutarse;
- una petición HTTP puede modificarse antes de llegar al servidor;
- el servidor no puede confiar en que el cliente haya validado correctamente;
- PHP debe aplicar las reglas necesarias antes de procesar los datos.
