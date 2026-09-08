# Semana 4 — Validación de entradas y gestión segura de errores

## Foco docente

Esta sesión debe consolidar una idea fundamental del módulo:

> La validación realizada en el navegador no puede considerarse una medida de seguridad.

El alumnado ya ha visto que controla las peticiones que salen de su navegador.

Ahora debe comprobarlo de forma práctica:

```text
Formulario
    ↓
Validación HTML / JavaScript
    ↓
Petición HTTP
    ↓
Servidor
```

El servidor debe validar siempre los datos que recibe, independientemente de las comprobaciones realizadas en el cliente.

La gestión de errores se trabajará de forma breve y vinculada a la validación. No conviene convertir esta sesión en una clase completa sobre excepciones o logging.

---

## Objetivos de la sesión

Al finalizar la sesión, el alumnado debería ser capaz de:

- explicar por qué los datos procedentes del cliente no son confiables;
- diferenciar validación en cliente y validación en servidor;
- reconocer el papel de HTML5 y JavaScript en la experiencia de usuario;
- implementar comprobaciones básicas en PHP;
- identificar validaciones de tipo, rango, longitud y formato;
- comprobar que una validación del cliente puede ser evitada;
- devolver mensajes de error útiles sin exponer información interna.

---

## Material del alumnado

Trabajar principalmente con:

- `2.desarrollo-seguro/2.validacion-de-entradas.md`
- `2.desarrollo-seguro/3.gestion-de-errores.md`
- `3.implementacion-segura/2.validacion-entradas/javascript.md`
- `3.implementacion-segura/2.validacion-entradas/php.md`

No es necesario explicar todo el contenido de estas páginas.

En esta sesión se mezclan deliberadamente contenidos de diseño e implementación:

```text
Qué debemos validar
        ↓
Dónde debemos validarlo
        ↓
Cómo se implementa
        ↓
Cómo comprobamos si funciona
```

---

## Contenidos que se trabajan en clase

### Datos no confiables

Recordar la conclusión de las semanas anteriores:

> El usuario controla el navegador y puede modificar los datos enviados al servidor.

Considerar como datos externos, entre otros:

- parámetros GET;
- datos POST;
- campos de formularios;
- cabeceras;
- cookies;
- datos JSON;
- identificadores incluidos en URLs.

No es necesario desarrollar todos estos casos.

---

### Tipos de validación

Trabajar ejemplos sencillos de:

- tipo;
- presencia;
- longitud;
- rango;
- formato;
- pertenencia a un conjunto permitido.

Ejemplos:

```text
edad → entero entre 0 y 120
email → formato válido
rol → alumno | profesor
nombre → longitud máxima
cantidad → entero positivo
```

---

### Validación en cliente

Explicar que HTML5 y JavaScript pueden mejorar la experiencia de usuario.

Ejemplos:

```html
<input type="number" min="1" max="10" required>
```

o una comprobación JavaScript.

Ventajas:

- respuesta inmediata;
- mejor experiencia de usuario;
- reducción de errores accidentales.

Pero:

> El cliente está bajo control del usuario.

Por tanto, esta validación puede evitarse.

---

### Validación en servidor

La validación de seguridad debe realizarse en el servidor.

En PHP pueden utilizarse:

- comprobaciones explícitas;
- conversión controlada de tipos;
- `filter_var()`;
- `filter_input()`;
- listas permitidas.

No es necesario presentar todas las funciones de filtrado de PHP.

---

### Gestión segura de errores

Trabajar únicamente estas ideas:

- indicar al usuario qué debe corregir;
- no mostrar trazas;
- no mostrar consultas SQL;
- no mostrar rutas internas;
- no mostrar credenciales;
- distinguir entre mensaje para usuario y detalle técnico para diagnóstico.

Ejemplo adecuado:

```text
La cantidad debe estar entre 1 y 10.
```

Ejemplo inadecuado:

```text
Fatal error in /var/www/html/app/form.php on line 37...
```

---

## Guion orientativo para la explicación

### 1. Recuperar la Semana 2

Comenzar planteando:

> La semana pasada comprobamos que podemos inspeccionar y modificar las peticiones enviadas por el navegador.

Mostrar un formulario aparentemente restrictivo:

```html
<input type="number" name="cantidad" min="1" max="10">
```

Preguntar:

> Si el navegador no permite escribir 100, ¿significa que el servidor nunca recibirá 100?

No responder inmediatamente.

Esta será la pregunta que resolverá la práctica.

---

### 2. Validar no significa “comprobar que el formulario está bien”

Explicar la diferencia:

```text
Validación del formulario
        ≠
Validación de los datos recibidos
```

El formulario es solo una forma habitual de construir la petición.

Un usuario podría:

- modificar el HTML;
- desactivar JavaScript;
- modificar parámetros;
- construir otra petición;
- utilizar herramientas distintas del navegador.

La aplicación debe considerar la petición recibida, no la interfaz que supuestamente la generó.

---

### 3. Cliente y servidor tienen objetivos distintos

Puede utilizarse esta comparación:

| Cliente | Servidor |
|---|---|
| UX | Seguridad e integridad |
| Respuesta inmediata | Autoridad final |
| Puede ser modificado | Controlado por la aplicación |
| Validación conveniente | Validación obligatoria |

Frase clave:

> Validar dos veces no significa duplicar inútilmente el trabajo: cada validación tiene una finalidad distinta.

---

### 4. Qué validar

Usar ejemplos cercanos:

#### Edad

```text
¿Existe?
¿Es un número?
¿Es entero?
¿Está en un rango razonable?
```

#### Rol

No aceptar cualquier texto:

```text
administrador
hacker
root
```

Utilizar una lista permitida:

```php
$rolesPermitidos = ['alumno', 'profesor'];
```

#### Identificador

Un `id` no debería asumirse correcto solo porque venga de:

```text
?id=23
```

Debe comprobarse al menos que tenga el tipo y formato esperado.

La autorización sobre ese identificador se trabajará posteriormente.

---

### 5. Validación en PHP

Mostrar un ejemplo deliberadamente sencillo.

Código insuficiente:

```php
$cantidad = $_POST['cantidad'];

echo "Cantidad recibida: " . $cantidad;
```

Código con comprobación básica:

```php
$cantidad = filter_input(INPUT_POST, 'cantidad', FILTER_VALIDATE_INT);

if ($cantidad === false || $cantidad < 1 || $cantidad > 10) {
    die("Cantidad no válida");
}

echo "Cantidad aceptada: " . $cantidad;
```

No presentar este fragmento como patrón universal.

La finalidad es visualizar que el servidor toma la decisión final.

---

### 6. Validación y transformación no son lo mismo

Introducir brevemente:

> Validar consiste en decidir si un dato cumple las reglas esperadas.

Modificar silenciosamente un dato no siempre es validar.

Ejemplo:

```text
Usuario envía: 150
Aplicación convierte automáticamente: 10
```

Puede ocultar un error o una manipulación.

En muchos casos es preferible rechazar el dato y pedir que se corrija.

---

### 7. Mensajes de error seguros

Comparar:

```text
ERROR: mysqli_sql_exception at /var/www/html/config/db.php...
```

con:

```text
No se ha podido procesar la solicitud.
```

Para errores de validación sí conviene ser específico:

```text
La cantidad debe ser un número entre 1 y 10.
```

La regla:

> Información suficiente para corregir el dato, pero no información interna innecesaria.

---

## Preguntas que puede lanzar el profesor

- ¿Quién controla el atributo `max="10"`?
- ¿Puede el usuario modificar el HTML?
- ¿Puede desactivar JavaScript?
- ¿Puede enviar una petición sin utilizar nuestro formulario?
- ¿Por qué validar también en JavaScript si igualmente tenemos que validar en PHP?
- ¿Qué diferencia hay entre dato inválido y dato no autorizado?
- ¿Es buena idea corregir automáticamente cualquier entrada incorrecta?
- ¿Qué información debería mostrar un error al usuario?
- ¿Qué información no debería mostrar nunca?

---

## Temporalización orientativa

| Tiempo | Actividad |
|---|---|
| 00:00–00:10 | Recuperar la idea de cliente no confiable |
| 00:10–00:30 | Qué validar y tipos de validación |
| 00:30–00:45 | Cliente vs servidor |
| 00:45–00:55 | Gestión segura de errores |
| 00:55–01:15 | Demostración: saltarse la validación |
| 01:15–01:50 | Actividad práctica |
| 01:50–02:00 | Puesta en común y conclusiones |

Esta sesión debe ser claramente práctica.

Si la explicación se alarga, reducir ejemplos teóricos antes que reducir la práctica.

---

## Demostración del profesor — Saltarse una validación

Preparar una miniaplicación con un formulario.

### `formulario.html`

```html
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Validación</title>
</head>
<body>

<h1>Realizar pedido</h1>

<form action="procesar.php" method="post">
    <label>
        Cantidad:
        <input
            type="number"
            name="cantidad"
            min="1"
            max="10"
            required
        >
    </label>

    <button type="submit">Enviar</button>
</form>

</body>
</html>
```

### Primera versión de `procesar.php`

```php
<?php

$cantidad = $_POST['cantidad'] ?? '';

echo "El servidor ha recibido: " . htmlspecialchars($cantidad);
```

### Paso 1 — Comportamiento normal

Intentar introducir:

```text
100
```

El navegador debería impedir el envío normal debido a `max="10"`.

Preguntar:

> ¿Estamos seguros entonces de que el servidor nunca puede recibir 100?

---

### Paso 2 — Modificar el formulario

Desde DevTools:

1. inspeccionar el campo;
2. localizar:

```html
max="10"
```

3. cambiarlo, por ejemplo, a:

```html
max="1000"
```

4. introducir `100`;
5. enviar.

El servidor mostrará:

```text
El servidor ha recibido: 100
```

Conclusión:

> La restricción del navegador no protege al servidor.

---

### Paso 3 — Mostrar otra posibilidad

También puede eliminarse directamente:

```html
max="10"
```

o modificarse el valor desde las herramientas del navegador.

No es necesario utilizar Burp Suite en esta sesión.

DevTools es suficiente para demostrar el concepto.

---

### Paso 4 — Corregir el servidor

Modificar `procesar.php`:

```php
<?php

$cantidad = filter_input(INPUT_POST, 'cantidad', FILTER_VALIDATE_INT);

if ($cantidad === false || $cantidad < 1 || $cantidad > 10) {
    http_response_code(400);
    die("La cantidad debe ser un número entre 1 y 10.");
}

echo "Cantidad aceptada: " . htmlspecialchars((string) $cantidad);
```

Repetir exactamente la misma manipulación.

Ahora el servidor debe rechazar el valor.

Preguntar:

> ¿Qué ha cambiado?

La interfaz sigue siendo manipulable.

La diferencia es que el servidor ya no confía en ella.

---

## Actividad práctica — Romper y corregir una validación

### Organización

Trabajo por parejas.

Duración aproximada: 35 minutos.

Entregar o proporcionar una pequeña aplicación con un formulario.

Por ejemplo:

```html
<input
    type="number"
    name="edad"
    min="18"
    max="100"
    required
>
```

El servidor inicialmente acepta directamente:

```php
$edad = $_POST['edad'];
```

---

### Tarea 1 — Comprobar la validación normal

Intentar enviar:

```text
10
```

o:

```text
150
```

Observar qué hace el navegador.

---

### Tarea 2 — Evitar la restricción

Utilizar DevTools para conseguir que el servidor reciba un dato fuera del rango permitido.

No se proporciona inicialmente un procedimiento exacto.

Si un grupo necesita ayuda:

> Inspeccionad el elemento HTML y pensad quién controla los atributos `min` y `max`.

---

### Tarea 3 — Demostrar el problema

Anotar:

- valor que el formulario permitía;
- valor manipulado;
- valor que finalmente recibió el servidor.

Responder:

> ¿Por qué la validación HTML no ha protegido la aplicación?

---

### Tarea 4 — Corregir el servidor

Implementar una validación PHP que compruebe:

- presencia;
- tipo entero;
- rango permitido.

El servidor debe rechazar cualquier valor fuera de las reglas.

---

### Tarea 5 — Verificar la corrección

Repetir exactamente el mismo intento utilizado anteriormente.

Completar:

| Prueba | Antes | Después |
|---|---|---|
| Valor válido | | |
| Valor menor del mínimo | | |
| Valor mayor del máximo | | |
| Texto en lugar de número | | |

El objetivo no es únicamente corregir el código.

También deben demostrar que la corrección funciona.

---

## Puesta en común

Preguntas para cerrar:

1. ¿Qué validación fue posible evitar?
2. ¿Por qué pudo evitarse?
3. ¿Significa eso que no debemos validar en JavaScript?
4. ¿Qué función tiene entonces la validación cliente?
5. ¿Dónde debe tomarse la decisión final?
6. ¿Qué diferencia hay entre validar y mostrar un error seguro?

Conviene dejar muy clara esta conclusión:

> El cliente puede ayudar al usuario, pero el servidor debe proteger la aplicación.

---

## Ideas clave para cerrar la sesión

El alumnado debería quedarse con estas ideas:

1. Todo dato externo debe considerarse potencialmente manipulable.
2. HTML y JavaScript no constituyen una frontera de seguridad.
3. La validación en cliente mejora la experiencia de usuario.
4. La validación en servidor es obligatoria.
5. Deben validarse tipo, formato, rango y demás reglas necesarias.
6. Los errores deben informar sin revelar detalles internos.
7. Una medida de seguridad debe probarse intentando evitarla.

---

## Conexión con la siguiente semana

Hasta ahora hemos trabajado principalmente la **entrada** de datos.

La siguiente sesión planteará otra pregunta:

> ¿Qué ocurre cuando mostramos en una página datos que proceden de un usuario?

Esto permitirá introducir:

- salida segura;
- contexto HTML;
- XSS;
- escape de salida.

La dinámica será:

```text
Aplicación vulnerable
        ↓
Reproducir XSS
        ↓
Corregir la salida
        ↓
Repetir el ataque
```

---

## Si falta tiempo

Priorizar:

- cliente vs servidor;
- demostración de manipulación;
- validación PHP;
- actividad práctica;
- verificación de la corrección.

Reducir:

- número de tipos de validación;
- explicación de `filter_input()`;
- gestión de errores a un ejemplo breve.

No eliminar la demostración de cómo se evita la validación del navegador.

---

## Si sobra tiempo

### Manipular un `select`

Crear:

```html
<select name="rol">
    <option value="alumno">Alumno</option>
    <option value="profesor">Profesor</option>
</select>
```

Modificar desde DevTools uno de los valores a:

```text
administrador
```

Enviar la petición.

Preguntar:

> ¿Debe el servidor aceptar un valor solo porque originalmente no aparecía en el `<select>`?

La solución debe usar una lista permitida.

---

### Campo oculto

Mostrar:

```html
<input type="hidden" name="precio" value="100">
```

Preguntar:

> ¿Un campo oculto es un dato confiable?

Modificar el valor desde DevTools.

Esto permite anticipar problemas de lógica de negocio que se trabajarán posteriormente.

---

### Comparar mensaje seguro e inseguro

Mostrar dos respuestas:

```text
No se ha podido procesar la solicitud.
```

y:

```text
mysqli_sql_exception: Access denied for user...
```

Pedir al alumnado que valore qué información debería recibir un usuario y cuál debería reservarse para diagnóstico interno.
