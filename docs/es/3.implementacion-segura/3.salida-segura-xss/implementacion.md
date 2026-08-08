# Implementación de una salida segura

La protección frente a XSS consiste en evitar que los datos no confiables se interpreten como código cuando llegan al navegador.

La regla general es sencilla:

> **Los datos deben tratarse como datos, no como fragmentos de HTML o JavaScript.**

## Salida segura en PHP

Una implementación insegura puede imprimir directamente un valor recibido:

```php
$comentario = $_POST['comentario'] ?? '';

echo $comentario;
```

Si `$comentario` contiene HTML, el navegador puede interpretarlo.

Por ejemplo:

```html
<script>alert('XSS')</script>
```

podría convertirse en código ejecutable dentro de la página.

## Escapar HTML con `htmlspecialchars()`

Cuando un dato debe mostrarse como texto dentro de HTML, PHP ofrece `htmlspecialchars()`.

```php
$comentario = $_POST['comentario'] ?? '';

echo htmlspecialchars(
    $comentario,
    ENT_QUOTES,
    'UTF-8'
);
```

Esta función transforma caracteres especiales para que el navegador los trate como texto.

Por ejemplo:

```text
<script>alert('XSS')</script>
```

se representa internamente utilizando entidades HTML en lugar de interpretarse como una etiqueta `<script>`.

El usuario verá el contenido, pero el navegador no lo ejecutará.

## Escapar en el momento de generar la salida

Una práctica recomendable es mantener el dato original y aplicar el escape cuando se incorpora al HTML.

```php
$nombre = $usuario['nombre'];

echo '<p>' .
    htmlspecialchars($nombre, ENT_QUOTES, 'UTF-8') .
    '</p>';
```

Esto permite conservar la información original en la base de datos y adaptar posteriormente su representación al contexto donde vaya a utilizarse.

!!! tip "Escapar al generar la salida"

    No es necesario modificar permanentemente el dato para proteger una página. La protección debe aplicarse cuando el valor se incorpora al contexto correspondiente.

## Ejemplo con plantillas PHP

También puede utilizarse directamente dentro del HTML:

```php
<p>
    <?= htmlspecialchars(
        $usuario['nombre'],
        ENT_QUOTES,
        'UTF-8'
    ) ?>
</p>
```

Este patrón debería utilizarse siempre que se muestre texto procedente de:

- usuarios;
- formularios;
- bases de datos;
- APIs;
- parámetros de petición.

## No utilizar `strip_tags()` como protección general

Puede resultar tentador eliminar etiquetas HTML:

```php
$comentario = strip_tags($_POST['comentario']);
```

Pero `strip_tags()` no sustituye al escape contextual.

Además, eliminar contenido puede modificar datos que la aplicación debería conservar.

La pregunta correcta no es:

> ¿Cómo elimino caracteres peligrosos?

sino:

> ¿Cómo hago que este dato se interprete correctamente en el contexto donde voy a mostrarlo?

## Contextos diferentes

No todos los lugares de una página se protegen exactamente igual.

Un dato puede utilizarse dentro de:

- contenido HTML;
- un atributo;
- una URL;
- JavaScript;
- CSS.

Por ejemplo:

```html
<p>Aquí aparece un dato</p>
```

no es el mismo contexto que:

```html
<a href="AQUI_APARECE_UN_DATO">
```

o:

```html
<script>
const valor = "AQUI_APARECE_UN_DATO";
</script>
```

En este módulo trabajaremos principalmente con salida de texto en HTML y manipulación segura del DOM.

## JavaScript y el DOM

JavaScript puede introducir datos en una página de diferentes formas.

Una de las diferencias más importantes es la existente entre `innerHTML` y `textContent`.

### `innerHTML`

```js
const comentario = '<strong>Hola</strong>';

elemento.innerHTML = comentario;
```

El navegador interpreta el contenido como HTML.

El resultado será texto en negrita.

Esto puede ser correcto si el HTML utilizado ha sido generado y controlado completamente por la aplicación.

El problema aparece cuando el valor procede de una fuente no confiable.

```js
elemento.innerHTML = datoUsuario;
```

Si `datoUsuario` contiene HTML manipulable, el navegador puede interpretarlo.

## `textContent`

Cuando el objetivo es mostrar texto, debe preferirse:

```js
elemento.textContent = datoUsuario;
```

Si el dato contiene:

```text
<strong>Hola</strong>
```

el navegador mostrará literalmente:

```text
<strong>Hola</strong>
```

No lo convertirá en una etiqueta HTML.

## Comparación

```js
const dato = '<em>Prueba</em>';

elemento1.innerHTML = dato;
elemento2.textContent = dato;
```

El resultado conceptual es:

```text
innerHTML
    ↓
interpreta HTML
    ↓
Prueba aparece en cursiva

textContent
    ↓
interpreta texto
    ↓
<em>Prueba</em>
```

Por tanto:

> **Si quieres mostrar texto, utiliza `textContent`.**

## Crear elementos de forma segura

En lugar de construir fragmentos HTML mediante cadenas:

```js
lista.innerHTML += `
    <li>${nombreUsuario}</li>
`;
```

pueden crearse los elementos mediante el DOM:

```js
const li = document.createElement('li');

li.textContent = nombreUsuario;

lista.appendChild(li);
```

De esta forma, `nombreUsuario` se trata como texto.

## Ejemplo con datos recibidos desde una API

Supongamos que una aplicación recibe:

```json
{
    "nombre": "Ane",
    "observacion": "Necesita reforzar JavaScript"
}
```

Una implementación segura puede ser:

```js
const nombre = document.querySelector('#nombre');
const observacion = document.querySelector('#observacion');

nombre.textContent = datos.nombre;
observacion.textContent = datos.observacion;
```

Aunque los datos procedan de nuestra propia API, deben tratarse como información no confiable si originalmente pueden haber sido introducidos por usuarios.

## Ejemplo en TxurdiGest

Supongamos que un profesor guarda una observación:

```text
Buen progreso en <JavaScript>.
```

La aplicación debe poder almacenar ese texto y mostrarlo correctamente.

En PHP:

```php
<p>
    <?= htmlspecialchars(
        $observacion,
        ENT_QUOTES,
        'UTF-8'
    ) ?>
</p>
```

En JavaScript:

```js
observacionElemento.textContent = observacion;
```

Ambos mecanismos persiguen el mismo objetivo:

> **evitar que el contenido del usuario cambie la estructura o el comportamiento de la página.**

## ¿Cuándo puede utilizarse `innerHTML`?

`innerHTML` no es inseguro por sí mismo.

Puede utilizarse cuando el contenido HTML está completamente controlado por la aplicación.

Por ejemplo:

```js
mensaje.innerHTML = '<strong>Operación completada</strong>';
```

Aquí no intervienen datos externos.

El problema aparece cuando se mezclan cadenas HTML con información no confiable:

```js
mensaje.innerHTML =
    '<strong>Usuario:</strong> ' + nombreUsuario;
```

Si `nombreUsuario` puede ser manipulado, la construcción deja de ser segura.

Una alternativa es:

```js
const etiqueta = document.createElement('strong');
etiqueta.textContent = 'Usuario: ';

mensaje.appendChild(etiqueta);
mensaje.appendChild(
    document.createTextNode(nombreUsuario)
);
```

## No confiar en datos almacenados

Un error habitual consiste en pensar que un dato es seguro porque procede de la base de datos.

Por ejemplo:

```php
$comentario = obtenerComentario($id);

echo $comentario;
```

La base de datos no convierte automáticamente un dato en confiable.

Si el valor fue introducido originalmente por un usuario, puede seguir conteniendo contenido peligroso.

Este escenario da lugar a lo que habitualmente se denomina **XSS almacenado**.

## XSS reflejado y almacenado

De forma simplificada pueden distinguirse dos situaciones frecuentes.

### XSS reflejado

El dato llega en una petición y se devuelve inmediatamente en la respuesta.

```text
Petición
   ↓
dato manipulable
   ↓
respuesta HTML
```

### XSS almacenado

El dato se guarda primero y se muestra posteriormente.

```text
Usuario A
   ↓
dato manipulable
   ↓
base de datos
   ↓
Usuario B visualiza el dato
```

En ambos casos, la protección principal sigue siendo generar una salida segura.

## Buenas prácticas

- Escapa los datos cuando se incorporan al HTML.
- Utiliza `htmlspecialchars()` para mostrar texto en PHP.
- Especifica `ENT_QUOTES` y `UTF-8`.
- Prefiere `textContent` cuando JavaScript debe mostrar texto.
- Evita construir HTML concatenando datos no confiables.
- Utiliza `createElement()` y `createTextNode()` cuando sea apropiado.
- No consideres segura una información simplemente porque provenga de la base de datos.
- Adapta la protección al contexto donde se utilice el dato.

## Resumen

- XSS aparece cuando un dato acaba interpretándose como código en el navegador.
- En PHP, `htmlspecialchars()` permite generar salida de texto segura en HTML.
- En JavaScript, `textContent` evita interpretar el contenido como HTML.
- `innerHTML` debe utilizarse con especial cuidado cuando intervienen datos externos.
- La seguridad debe aplicarse al contexto de salida, no mediante la eliminación indiscriminada de caracteres.
