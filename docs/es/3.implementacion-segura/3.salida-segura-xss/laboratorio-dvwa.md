# Laboratorio DVWA: XSS

En este laboratorio se analizará una implementación vulnerable a **Cross-Site Scripting (XSS)** para identificar qué decisión de desarrollo provoca el problema y cómo debe corregirse.

El objetivo no es aprender a explotar aplicaciones, sino comprender por qué un dato no confiable puede convertirse en código cuando se genera una salida insegura.

## Escenario

Utilizaremos **DVWA (Damn Vulnerable Web Application)** en un entorno local y controlado.

Trabajaremos con uno de los ejercicios de XSS disponibles en DVWA.

La secuencia será:

```text
Entrada
   ↓
Aplicación vulnerable
   ↓
Salida HTML insegura
   ↓
El navegador interpreta el dato como código
```

## 1. Observar el comportamiento normal

Accede al ejercicio de XSS seleccionado e introduce primero un valor normal.

Por ejemplo:

```text
Ane
```

Observa cómo aparece posteriormente en la respuesta.

La aplicación está utilizando el dato recibido para construir el contenido HTML.

## 2. Comprobar si el dato se interpreta como HTML

Introduce ahora un fragmento sencillo:

```html
<strong>Prueba</strong>
```

Observa el resultado.

Si aparece la palabra en negrita, significa que el navegador no está tratando el contenido únicamente como texto.

Está interpretando las etiquetas recibidas.

Este comportamiento ya permite identificar el problema:

> **la aplicación está insertando un dato no confiable dentro del HTML sin aplicar una protección adecuada.**

## 3. Demostrar la ejecución de JavaScript

En el entorno controlado de DVWA puede utilizarse una prueba mínima como:

```html
<script>alert('XSS')</script>
```

Si el navegador ejecuta el código, queda demostrado que el dato introducido ha pasado a formar parte del documento como código ejecutable.

!!! warning "Entorno controlado"

    Esta prueba debe realizarse únicamente sobre DVWA u otras aplicaciones preparadas expresamente para prácticas de seguridad.

## 4. Identificar la causa

El problema no consiste simplemente en que el usuario pueda escribir caracteres como `<` o `>`.

El problema aparece porque la aplicación genera una salida equivalente a:

```php
echo $_GET['name'];
```

o:

```php
echo $_POST['message'];
```

El dato llega al navegador sin codificarse correctamente para el contexto HTML.

Conceptualmente:

```text
Dato recibido
   ↓
Se concatena o imprime directamente
   ↓
Respuesta HTML
   ↓
El navegador interpreta etiquetas
```

## 5. Revisar el código vulnerable

Utiliza la opción de DVWA que permite visualizar el código fuente del ejercicio.

Localiza el punto donde:

1. se recibe el dato;
2. se incorpora a la respuesta;
3. no se aplica ninguna función de escape adecuada.

No es necesario estudiar todo el código de DVWA.

La pregunta importante es:

> **¿En qué momento un dato pasa a formar parte del HTML sin ser tratado como texto?**

## 6. Corregir la implementación

Una forma habitual de proteger una salida de texto en PHP es utilizar:

```php
htmlspecialchars(
    $dato,
    ENT_QUOTES,
    'UTF-8'
);
```

Por ejemplo:

```php
$nombre = $_GET['name'] ?? '';

echo htmlspecialchars(
    $nombre,
    ENT_QUOTES,
    'UTF-8'
);
```

Ahora un valor como:

```html
<strong>Prueba</strong>
```

debe mostrarse como texto y no interpretarse como una etiqueta HTML.

Lo mismo debe ocurrir con:

```html
<script>alert('XSS')</script>
```

El navegador debe mostrar el contenido sin ejecutarlo.

## 7. Repetir la prueba

Después de aplicar o analizar la versión segura:

1. introduce nuevamente texto normal;
2. prueba el fragmento `<strong>Prueba</strong>`;
3. prueba el fragmento utilizado para demostrar XSS;
4. compara el comportamiento.

El resultado esperado es:

```text
ANTES

Dato
  ↓
salida directa
  ↓
HTML interpretado
  ↓
posible ejecución de código
```

frente a:

```text
DESPUÉS

Dato
  ↓
escape de salida
  ↓
texto
  ↓
sin ejecución
```

## 8. Relacionarlo con JavaScript

El mismo principio aparece en el navegador cuando JavaScript modifica el DOM.

Una construcción como:

```js
elemento.innerHTML = datoUsuario;
```

puede interpretar el contenido como HTML.

Cuando el objetivo es mostrar texto, debe preferirse:

```js
elemento.textContent = datoUsuario;
```

Aunque PHP y JavaScript utilizan mecanismos diferentes, ambos intentan mantener la misma separación:

> **datos por un lado, código por otro.**

## Aplicación a TxurdiGest

Imagina que TxurdiGest permite introducir observaciones sobre alumnos.

Una observación normal puede ser:

```text
Necesita reforzar programación asíncrona.
```

Si ese dato se guarda en la base de datos y posteriormente se imprime directamente:

```php
echo $observacion;
```

una observación manipulada podría afectar a cualquier usuario que visualizara posteriormente la página.

La salida debería generarse de forma segura:

```php
echo htmlspecialchars(
    $observacion,
    ENT_QUOTES,
    'UTF-8'
);
```

El hecho de que el dato proceda de la base de datos no cambia la regla.

## Qué debe quedar demostrado

Al finalizar el laboratorio debe quedar claro que:

- XSS aparece cuando datos no confiables se interpretan como código en el navegador;
- validar la entrada no sustituye a proteger la salida;
- el problema puede estar en una única línea que imprime o inserta datos de forma insegura;
- `htmlspecialchars()` permite mostrar texto de forma segura en un contexto HTML habitual;
- en JavaScript, `textContent` es preferible a `innerHTML` cuando se muestran datos;
- después de corregir una implementación hay que repetir la misma prueba para verificar que el problema ha desaparecido.
