# Salida segura y XSS

Validar correctamente los datos de entrada no garantiza que una aplicación sea segura.

Un dato puede cumplir todas las reglas previstas y, aun así, resultar peligroso si se inserta en una página HTML de forma que el navegador lo interprete como código.

Este problema aparece especialmente cuando una aplicación muestra información procedente de:

- formularios;
- comentarios;
- perfiles de usuario;
- parámetros de URL;
- bases de datos;
- APIs.

## El problema está en la salida

Supongamos que una aplicación permite guardar el nombre de un alumno.

El dato recibido puede ser:

```text
Ane
```

y posteriormente mostrarse en una página:

```html
<p>Ane</p>
```

No existe ningún problema.

Pero si la aplicación inserta directamente un valor que contiene etiquetas HTML o código JavaScript, el navegador puede interpretarlo como parte del documento.

Por ejemplo:

```html
<script>alert('XSS')</script>
```

Si ese contenido se incorpora sin tratamiento dentro del HTML generado, deja de comportarse como texto y puede ejecutarse como código.

Esta familia de problemas se conoce como **Cross-Site Scripting (XSS)**.

## Validar y escapar son operaciones diferentes

La validación responde a una pregunta:

> **¿Este dato cumple las reglas de la aplicación?**

La salida segura responde a otra:

> **¿Cómo debe incorporarse este dato al documento para que se interprete como información y no como código?**

Por ejemplo, un comentario puede permitir caracteres como:

```text
< >
" '
&
```

porque forman parte de un texto perfectamente válido.

No sería correcto eliminar automáticamente esos caracteres para intentar evitar XSS.

La solución consiste en **codificar o escapar la salida según el contexto en el que vaya a utilizarse**.

## Ejemplo conceptual

Supongamos que un usuario introduce:

```text
<script>alert('Hola')</script>
```

Una implementación insegura podría generar:

```html
<p>
    <script>alert('Hola')</script>
</p>
```

El navegador interpreta la etiqueta `<script>` como código.

Una salida segura debe conseguir que el navegador trate ese contenido como texto:

```text
<script>alert('Hola')</script>
```

sin ejecutarlo.

## Dónde puede aparecer

XSS puede aparecer cuando datos no confiables se utilizan para construir:

- contenido HTML;
- atributos HTML;
- código JavaScript;
- URLs;
- elementos del DOM.

El mecanismo de protección depende del contexto.

En este bloque nos centraremos especialmente en dos situaciones habituales en DAW:

- generación de HTML desde PHP;
- modificación del DOM desde JavaScript.

## PHP y JavaScript

En PHP será importante evitar imprimir directamente datos no confiables.

Por ejemplo:

```php
echo $comentario;
```

puede ser peligroso si `$comentario` contiene contenido interpretable por el navegador.

En JavaScript también importa cómo se incorpora un dato al DOM.

No es equivalente utilizar:

```js
elemento.innerHTML = dato;
```

que:

```js
elemento.textContent = dato;
```

En ambos casos el problema es el mismo:

> **un dato debe seguir siendo un dato y no convertirse accidentalmente en código ejecutable.**

## Ejemplo en TxurdiGest

Supongamos que TxurdiGest permite que un profesor escriba una observación sobre un alumno:

```text
Necesita reforzar JavaScript.
```

La aplicación guarda esa información y posteriormente la muestra.

Si el contenido se inserta directamente como HTML, un valor manipulado podría alterar la página o ejecutar código en el navegador de otro usuario.

La protección debe aplicarse cuando la aplicación genera la salida.

## Apartados

En este tema trabajaremos:

- [Implementación](implementacion.md): salida segura en PHP y manipulación segura del DOM con JavaScript.
- [Laboratorio DVWA](laboratorio-dvwa.md): observación de una implementación vulnerable, identificación de la causa y corrección del problema.

## Resumen

- Validar la entrada y proteger la salida son tareas diferentes.
- XSS aparece cuando datos no confiables llegan al navegador y se interpretan como código.
- La protección debe adaptarse al contexto donde se utiliza el dato.
- PHP y JavaScript ofrecen mecanismos para mantener separados datos y código.
