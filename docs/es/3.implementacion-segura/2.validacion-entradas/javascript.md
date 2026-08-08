# Validación en JavaScript

La validación en JavaScript permite detectar errores antes de enviar una petición al servidor.

Su principal función es mejorar la experiencia del usuario:

- avisar de campos incompletos;
- comprobar formatos;
- validar rangos;
- mostrar mensajes inmediatos;
- evitar peticiones innecesarias.

Sin embargo, **no debe utilizarse como único mecanismo de seguridad**.

## Validación con HTML5

Antes de escribir JavaScript, conviene aprovechar las posibilidades de validación que ofrece HTML.

Por ejemplo:

```html
<form id="formAlumno">
    <label for="email">Correo electrónico</label>
    <input
        type="email"
        id="email"
        name="email"
        required
    >

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

En este formulario el navegador puede comprobar:

- que los campos obligatorios tengan valor;
- que el correo tenga un formato compatible con `type="email"`;
- que la nota sea numérica;
- que se encuentre entre `0` y `10`.

Estas comprobaciones mejoran la interacción con el formulario, pero siguen ejecutándose en el navegador.

## Validación adicional con JavaScript

JavaScript permite aplicar reglas más específicas.

Por ejemplo, podemos comprobar una nota antes de enviar el formulario:

```js
const formulario = document.querySelector('#formAlumno');

formulario.addEventListener('submit', (event) => {
    const nota = Number(document.querySelector('#nota').value);

    if (nota < 0 || nota > 10) {
        event.preventDefault();
        alert('La nota debe estar comprendida entre 0 y 10.');
    }
});
```

Si el valor no cumple la regla, se evita el envío del formulario y se informa al usuario.

## Mostrar mensajes junto al campo

En una aplicación real resulta preferible mostrar el error cerca del dato que debe corregirse.

```html
<label for="email">Correo electrónico</label>
<input type="email" id="email" name="email">
<p id="errorEmail"></p>
```

```js
const email = document.querySelector('#email');
const errorEmail = document.querySelector('#errorEmail');

email.addEventListener('blur', () => {
    if (!email.value.includes('@')) {
        errorEmail.textContent = 'Introduce una dirección de correo válida.';
        return;
    }

    errorEmail.textContent = '';
});
```

Este tipo de validación ofrece una respuesta inmediata sin esperar a que el servidor procese la petición.

## Validar varias reglas

Cuando un formulario contiene varios campos conviene separar las reglas en funciones pequeñas.

```js
function notaValida(nota) {
    return Number.isFinite(nota) && nota >= 0 && nota <= 10;
}

function emailValido(email) {
    return email.includes('@') && email.length <= 120;
}
```

Después pueden utilizarse antes de enviar:

```js
formulario.addEventListener('submit', (event) => {
    const nota = Number(document.querySelector('#nota').value);
    const email = document.querySelector('#email').value.trim();

    let formularioValido = true;

    if (!notaValida(nota)) {
        formularioValido = false;
    }

    if (!emailValido(email)) {
        formularioValido = false;
    }

    if (!formularioValido) {
        event.preventDefault();
    }
});
```

Separar las reglas facilita su lectura, mantenimiento y reutilización.

## No confíes en valores ocultos o deshabilitados

Un error frecuente consiste en pensar que un dato es seguro porque el usuario no puede modificarlo desde la interfaz.

Por ejemplo:

```html
<input type="hidden" name="rol" value="alumno">
```

o:

```html
<input type="text" name="precio" value="25" disabled>
```

El navegador muestra estos valores de una forma determinada, pero el usuario puede modificar el HTML, cambiar la petición o construir una nueva desde otra herramienta.

Por tanto, valores como:

- roles;
- identificadores;
- precios;
- permisos;
- estados internos;

deben comprobarse siempre en el servidor.

!!! warning "Un campo oculto no es un dato protegido"

    `hidden`, `readonly` o `disabled` controlan la interfaz, no la seguridad de la aplicación.

## Validación en aplicaciones con JavaScript

En aplicaciones que utilizan JavaScript para enviar peticiones HTTP, la situación es exactamente la misma.

Por ejemplo:

```js
async function guardarNota(alumnoId, nota) {
    if (!notaValida(nota)) {
        throw new Error('La nota no es válida.');
    }

    const respuesta = await fetch('/api/notas', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            alumnoId,
            nota
        })
    });

    return respuesta.json();
}
```

La función comprueba el dato antes de enviarlo, pero el endpoint `/api/notas` debe volver a validar:

- `alumnoId`;
- `nota`;
- permisos del usuario;
- cualquier otra regla de negocio.

Una petición HTTP no tiene por qué proceder del código JavaScript de nuestra aplicación.

## Ejemplo en TxurdiGest

Supongamos que un profesor introduce una nota.

JavaScript puede comprobar:

```js
const nota = 8.5;

if (nota < 0 || nota > 10) {
    mostrarError('La nota debe estar entre 0 y 10.');
}
```

La interfaz impedirá normalmente que el profesor envíe un valor fuera del rango.

Pero alguien podría modificar la petición y enviar:

```json
{
    "alumnoId": 152,
    "nota": 99
}
```

Si el servidor acepta ese valor, la aplicación continúa siendo vulnerable aunque la validación JavaScript sea correcta.

## Buenas prácticas

- Utiliza primero las restricciones de HTML cuando sean suficientes.
- Añade JavaScript cuando mejore la experiencia del usuario.
- Mantén las reglas claras y fáciles de mantener.
- Muestra los errores junto a los campos afectados.
- No confíes en campos ocultos, deshabilitados o de solo lectura.
- No utilices JavaScript como único mecanismo de validación.
- Repite en el servidor todas las reglas necesarias para proteger la aplicación.

## Resumen

- La validación JavaScript mejora la experiencia del usuario.
- El navegador está bajo el control del usuario.
- Cualquier petición puede modificarse o construirse fuera de la interfaz.
- JavaScript no sustituye nunca a la validación del servidor.
