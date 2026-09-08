# Semana 2 — HTTP y análisis de peticiones con DevTools

## Objetivos de la sesión

Al finalizar la sesión, el alumnado debería ser capaz de:

- describir el modelo básico de petición y respuesta HTTP;
- identificar método, URL, código de estado, cabeceras y cuerpo de una petición;
- diferenciar de forma básica GET y POST;
- comprender que el navegador construye y envía peticiones que el usuario puede inspeccionar y modificar;
- utilizar DevTools para analizar tráfico HTTP;
- relacionar HTTP con futuros problemas de validación, autenticación y autorización.

La idea central de la sesión es:

> Ver qué envía realmente el navegador y comprender cuánto control tiene el usuario sobre esos datos.

---

## Material del alumnado

Trabajar principalmente con:

- `1.fundamentos/3.protocolo-http.md`
- `1.fundamentos/6.herramientas-analisis-web.md`
- la actividad de observación de una aplicación con DevTools del Bloque 1.

No es necesario explicar todo el contenido de estas páginas.

El capítulo de HTTP debe utilizarse como material de referencia. En clase interesa dominar únicamente los elementos necesarios para comprender cómo viajan los datos entre cliente y servidor y cómo pueden ser inspeccionados.

---

## Contenidos que se trabajan en clase

### Modelo petición-respuesta

Trabajar especialmente:

- cliente y servidor;
- petición HTTP;
- respuesta HTTP;
- URL;
- método;
- cabeceras;
- cuerpo;
- código de estado.

### Métodos HTTP

Centrarse en:

- `GET`;
- `POST`.

Se pueden mencionar `PUT`, `PATCH` y `DELETE`, pero sin desarrollarlos en profundidad.

El objetivo no es memorizar métodos, sino comprender que el método forma parte de la petición y describe la intención de la operación.

### Códigos de estado

Priorizar:

- `200 OK`;
- `400 Bad Request`;
- `401 Unauthorized`;
- `403 Forbidden`;
- `404 Not Found`;
- `500 Internal Server Error`.

Se pueden mencionar de pasada:

- `201 Created`;
- `301 Moved Permanently`;
- `302 Found`.

No es necesario memorizar listas extensas de códigos.

### Cabeceras HTTP

Mostrar ejemplos reales:

- `Host`;
- `Content-Type`;
- `Accept`.

Se pueden enseñar también, sin desarrollarlas todavía:

- `Cookie`;
- `Set-Cookie`;
- `Authorization`.

Estas últimas se retomarán en la siguiente sesión al trabajar cookies, sesiones y autenticación.

### Estado en HTTP

Introducir únicamente esta idea:

> HTTP es, por sí mismo, un protocolo sin estado.

No desarrollar todavía cómo se resuelve este problema con sesiones y cookies.

---

## Guion orientativo para la explicación

### 1. Recuperar la idea de la semana anterior

Comenzar recordando el esquema:

```text
Usuario
   ↓
Navegador
   ↓
Servidor
   ↓
Aplicación
   ↓
Base de datos
```

Lanzar una pregunta:

> Cuando pulsamos un botón en una aplicación web, ¿qué viaja realmente entre navegador y servidor?

La respuesta que interesa construir durante la sesión es:

> Peticiones y respuestas HTTP.

---

### 2. Una aplicación web funciona mediante peticiones

Explicar que muchas acciones que el alumnado percibe como acciones de interfaz terminan convirtiéndose en peticiones HTTP.

Ejemplos:

- abrir una página;
- enviar un formulario;
- iniciar sesión;
- consultar un producto;
- guardar un dato;
- cargar un fichero JavaScript;
- solicitar datos mediante `fetch()` o Axios.

Se puede utilizar un ejemplo sencillo:

```text
Usuario pulsa "Ver perfil"
        ↓
Navegador envía petición
        ↓
Servidor procesa
        ↓
Servidor responde
        ↓
Navegador muestra resultado
```

La seguridad se aplica precisamente sobre estas interacciones.

---

### 3. Anatomía mínima de una petición HTTP

Mostrar una petición conceptual sencilla:

```http
GET /perfil.php?id=24 HTTP/1.1
Host: ejemplo.local
Accept: text/html
Cookie: PHPSESSID=abc123
```

No es necesario explicar la sintaxis completa del protocolo.

Identificar:

- método: `GET`;
- recurso: `/perfil.php`;
- parámetro: `id=24`;
- servidor;
- cabeceras;
- cookie.

Después plantear:

> ¿Qué partes de esta petición podría modificar el usuario?

La respuesta debería ser: prácticamente todas las que genera su propio cliente.

Esta idea será importante en las semanas de validación y autorización.

---

### 4. GET y POST

Evitar presentar una falsa equivalencia:

```text
GET = inseguro
POST = seguro
```

Explicar que ambos pueden transportar datos manipulados.

Una diferencia visible es que los parámetros GET suelen aparecer en la URL, mientras que los datos POST suelen viajar en el cuerpo de la petición.

Ejemplo GET:

```http
GET /producto.php?id=15
```

Ejemplo POST:

```http
POST /login.php
Content-Type: application/x-www-form-urlencoded

usuario=ana&password=1234
```

Plantear:

> Si el usuario puede modificar ambos, ¿podemos confiar en los datos solo porque llegan mediante POST?

Respuesta: no.

---

### 5. Respuestas HTTP

Mostrar una respuesta conceptual:

```http
HTTP/1.1 200 OK
Content-Type: text/html
Set-Cookie: PHPSESSID=abc123

<html>
...
</html>
```

Identificar:

- código de estado;
- cabeceras;
- contenido.

No profundizar todavía en `Set-Cookie`.

---

### 6. Códigos de estado útiles

Utilizar ejemplos breves:

- `200`: la petición se ha procesado correctamente;
- `400`: la petición enviada no es válida;
- `401`: falta autenticación;
- `403`: el usuario está identificado, pero no tiene permiso;
- `404`: recurso no encontrado;
- `500`: error interno del servidor.

Conviene destacar especialmente la diferencia conceptual entre:

```text
401 → no estás autenticado
403 → estás autenticado, pero no estás autorizado
```

Se desarrollará posteriormente.

---

## Preguntas que puede lanzar el profesor

Durante la explicación:

- ¿POST es más seguro que GET?
- ¿Puede el usuario modificar una URL?
- ¿Puede modificar los datos enviados por un formulario?
- ¿Puede modificar una cabecera HTTP?
- ¿Qué diferencia hay entre un `401` y un `403`?
- Si un botón no aparece en pantalla, ¿significa que no podemos enviar su petición?
- ¿Qué ocurre realmente cuando pulsamos “Iniciar sesión”?
- ¿Qué información puede aparecer en la pestaña Network?

No es necesario resolver en profundidad cuestiones de autenticación o autorización.

La intención es sembrar preguntas que se retomarán más adelante.

---

## Temporalización orientativa

| Tiempo | Actividad |
|---|---|
| 00:00–00:10 | Recordatorio de la semana anterior |
| 00:10–00:30 | Peticiones y respuestas HTTP |
| 00:30–00:45 | GET y POST |
| 00:45–00:55 | Códigos de estado y cabeceras básicas |
| 00:55–01:10 | Demostración con DevTools |
| 01:10–01:45 | Actividad práctica |
| 01:45–01:55 | Mini-reto: modificar un parámetro |
| 01:55–02:00 | Conclusiones |

La práctica debe tener prioridad sobre intentar terminar todo el contenido teórico del capítulo.

---

## Demostración del profesor — DevTools Network

Utilizar una aplicación web conocida por el alumnado o TxurdiGest.

Abrir las herramientas de desarrollo del navegador y acceder a:

```text
Network
```

### Demostración mínima

1. Borrar las peticiones existentes.
2. Recargar la página.
3. Seleccionar la petición principal.
4. Mostrar:
   - método;
   - URL;
   - código de estado;
   - cabeceras de petición;
   - cabeceras de respuesta;
   - parámetros si existen.
5. Localizar una petición de un recurso CSS o JavaScript.
6. Si la aplicación dispone de formulario, realizar una petición `POST`.
7. Mostrar dónde aparecen los datos enviados.

No intentar explicar todas las opciones de DevTools.

El alumnado debe aprender a localizar información, no a dominar toda la herramienta en esta sesión.

---

## Actividad práctica — Detective HTTP

### Organización

Trabajo preferentemente por parejas.

Duración aproximada: 35 minutos.

Cada pareja debe utilizar DevTools para analizar una aplicación web.

### Tarea 1 — Localizar una petición

Seleccionar una petición y completar:

| Dato | Valor observado |
|---|---|
| Método | |
| URL | |
| Código de estado | |
| `Content-Type` de la respuesta | |
| ¿Tiene parámetros? | |
| ¿Envía cookies? | |

---

### Tarea 2 — Encontrar distintos tipos de petición

Localizar, si la aplicación lo permite:

- una petición `GET`;
- una petición `POST`;
- una petición a un fichero CSS;
- una petición a un fichero JavaScript;
- una respuesta con código `200`.

Si alguna no aparece en la aplicación utilizada, no es necesario forzarla.

---

### Tarea 3 — Analizar un formulario

Si existe un formulario:

1. rellenarlo con datos reconocibles;
2. enviarlo;
3. localizar la petición correspondiente;
4. encontrar dónde aparecen los datos introducidos;
5. comprobar si se han enviado mediante URL o cuerpo.

Responder:

> ¿Puede el servidor saber si esos datos fueron escritos realmente mediante el formulario original?

La conclusión esperada es:

> El servidor recibe una petición. No puede confiar únicamente en la interfaz que generó esa petición.

---

## Mini-reto — Modificar un parámetro

Si la aplicación utilizada tiene una URL similar a:

```text
/producto.php?id=12
```

pedir al alumnado que modifique manualmente el identificador:

```text
/producto.php?id=13
```

Observar el resultado.

No presentar todavía esto como una vulnerabilidad de autorización.

Simplemente preguntar:

> ¿Quién ha decidido el valor del parámetro `id`?

La respuesta es:

> El cliente.

Esta observación servirá posteriormente para explicar controles de autorización.

---

## Puesta en común

Preguntas para los últimos minutos:

1. ¿Qué información os ha resultado más fácil de localizar?
2. ¿Qué diferencias habéis observado entre GET y POST?
3. ¿Los datos POST están ocultos al usuario?
4. ¿Puede el usuario modificar los datos enviados?
5. ¿Qué información debería validar el servidor?

Conviene terminar reforzando:

> Todo lo que llega en una petición debe tratarse como información potencialmente manipulada.

---

## Ideas clave para cerrar la sesión

El alumnado debería quedarse con estas ideas:

1. Navegador y servidor se comunican mediante peticiones y respuestas HTTP.
2. Una petición contiene método, URL, cabeceras y, en ocasiones, cuerpo.
3. GET y POST no determinan por sí mismos si una operación es segura.
4. El usuario puede inspeccionar y modificar los datos enviados desde su navegador.
5. El servidor no debe confiar automáticamente en la información recibida.
6. DevTools permite observar qué está ocurriendo realmente entre cliente y servidor.

---

## Conexión con la siguiente semana

La siguiente sesión utilizará lo aprendido para responder a una nueva pregunta:

> Si HTTP no mantiene estado, ¿cómo sabe una aplicación quién es el usuario entre una petición y la siguiente?

A partir de ahí se trabajarán:

- cookies;
- sesiones;
- atributos de seguridad de las cookies;
- HTTPS.

---

## Si falta tiempo

Priorizar:

- petición y respuesta;
- GET y POST;
- método, URL, estado y cabeceras;
- demostración Network;
- actividad práctica.

Reducir:

- códigos secundarios (`201`, `301`, `302`);
- explicación detallada de cabeceras;
- mini-reto de modificación de parámetros.

No eliminar la práctica con DevTools.

---

## Si sobra tiempo

Se pueden realizar una o varias de estas ampliaciones:

### Comparar GET y POST

Enviar los mismos datos utilizando ambas técnicas y localizar dónde aparecen.

### Observar una petición Fetch/XHR

Si la aplicación utiliza JavaScript para cargar datos, filtrar en Network por:

```text
Fetch/XHR
```

Identificar la petición y observar si devuelve HTML o JSON.

### Buscar información sensible

Preguntar:

> ¿Hay algún dato en las peticiones o respuestas que no esperaríais encontrar visible?

No entrar todavía en un análisis exhaustivo. El objetivo es fomentar la observación.
