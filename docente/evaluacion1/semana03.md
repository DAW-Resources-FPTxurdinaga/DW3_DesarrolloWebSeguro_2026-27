# Semana 3 — Cookies, sesiones y HTTPS

## Foco docente

La sesión debe responder a dos preguntas:

1. Si HTTP no mantiene estado, ¿cómo sabe una aplicación quién es el usuario entre una petición y la siguiente?
2. ¿Cómo protegemos la comunicación entre navegador y servidor?

No es necesario profundizar en criptografía, PKI ni funcionamiento interno de TLS.

El objetivo es que el alumnado comprenda el papel de las cookies y las sesiones, identifique sus atributos de seguridad y entienda qué protege HTTPS y qué no.

---

## Objetivos de la sesión

Al finalizar la sesión, el alumnado debería ser capaz de:

- explicar la diferencia entre cookie y sesión;
- describir de forma básica cómo una aplicación mantiene el estado de autenticación;
- localizar cookies desde DevTools;
- identificar los atributos `HttpOnly`, `Secure` y `SameSite`;
- comprender que una cookie de sesión actúa como identificador de una sesión almacenada en el servidor;
- explicar qué protege HTTPS;
- entender que HTTPS no corrige vulnerabilidades de la aplicación.

---

## Material del alumnado

Trabajar principalmente con:

- `1.fundamentos/4.cookies-sesiones.md`
- `1.fundamentos/5.https-certificados.md`
- `1.fundamentos/6.herramientas-analisis-web.md`

No es necesario explicar todo el contenido de estos apartados.

En clase interesa priorizar:

- diferencia entre cookie y sesión;
- flujo de autenticación;
- atributos de seguridad;
- observación de cookies en DevTools;
- finalidad de HTTPS.

Dejar como material de consulta:

- detalles criptográficos;
- funcionamiento interno del handshake TLS;
- infraestructura de clave pública;
- algoritmos criptográficos;
- jerarquías de autoridades certificadoras.

---

## Contenidos que se trabajan en clase

### HTTP no mantiene estado

Recuperar brevemente la idea de la semana anterior:

> Cada petición HTTP es independiente.

Plantear:

> Si cada petición es independiente, ¿cómo sabe una aplicación que seguimos siendo el mismo usuario después de iniciar sesión?

A partir de esta pregunta se introducen cookies y sesiones.

### Cookies

Trabajar:

- qué es una cookie;
- dónde se almacena;
- cuándo la envía el navegador;
- diferencia entre cookie de sesión y cookie persistente;
- atributos de seguridad.

### Sesiones

Trabajar:

- sesión almacenada en el servidor;
- identificador de sesión;
- relación entre cookie e identificador de sesión;
- cierre de sesión;
- pérdida de la sesión cuando desaparece o deja de ser válida la cookie correspondiente.

### Atributos de seguridad

Trabajar especialmente:

- `HttpOnly`;
- `Secure`;
- `SameSite`.

Mencionar también, sin profundizar:

- `Path`;
- `Domain`;
- `Expires`;
- `Max-Age`.

### HTTPS

Explicar:

- cifrado de la comunicación;
- integridad de los datos;
- autenticación del servidor mediante certificado;
- diferencia entre HTTP y HTTPS.

Reforzar:

> HTTPS protege la comunicación, no la lógica de la aplicación.

---

## Guion orientativo para la explicación

### 1. Recuperar la semana anterior

Comenzar con:

> La semana pasada vimos que navegador y servidor se comunican mediante peticiones HTTP y que HTTP es un protocolo sin estado.

Plantear:

> Imaginad que iniciáis sesión. Después hacéis clic en “Mi perfil”. ¿Cómo sabe el servidor que seguís siendo vosotros?

Escuchar respuestas antes de introducir cookies y sesiones.

---

### 2. Cookie y sesión no son lo mismo

Este punto conviene explicarlo con claridad porque suele generar confusión.

Mostrar el flujo:

```text
Usuario envía login
        ↓
Servidor valida credenciales
        ↓
Servidor crea una sesión
        ↓
Servidor genera un identificador de sesión
        ↓
Navegador guarda ese identificador en una cookie
        ↓
El navegador envía la cookie en peticiones posteriores
        ↓
El servidor recupera la sesión correspondiente
```

Idea clave:

> La cookie no contiene necesariamente toda la sesión.

En un caso típico de PHP:

```text
Cookie en navegador
PHPSESSID=abc123
        ↓
Servidor
Sesión abc123
        ↓
usuario_id = 15
rol = profesor
...
```

El navegador conserva el identificador.

El servidor conserva la información asociada a ese identificador.

---

### 3. Qué ocurre cuando iniciamos sesión

Explicar un flujo básico:

```text
POST /login.php
usuario=ana
password=...
        ↓
Servidor comprueba credenciales
        ↓
Crea sesión
        ↓
Respuesta:
Set-Cookie: PHPSESSID=abc123
```

En una petición posterior:

```http
GET /perfil.php HTTP/1.1
Cookie: PHPSESSID=abc123
```

El servidor utiliza el identificador para localizar la sesión.

No es necesario explicar todavía en profundidad la seguridad del login ni el almacenamiento de contraseñas. Se trabajará posteriormente.

---

### 4. Por qué una cookie de sesión es sensible

Plantear:

> Si alguien obtiene el identificador de sesión de otro usuario, ¿qué podría intentar hacer?

El objetivo es que comprendan que el identificador de sesión debe protegerse.

No desarrollar todavía ataques de secuestro de sesión en profundidad.

Simplemente introducir:

> Quien posee una cookie de sesión válida puede intentar hacerse pasar por ese usuario.

Esto justifica los atributos de seguridad.

---

### 5. Atributo HttpOnly

Explicar:

```text
HttpOnly
```

indica al navegador que JavaScript no debe poder acceder a esa cookie mediante `document.cookie`.

Idea clave:

> Reduce el riesgo de robo de cookies mediante JavaScript malicioso.

No decir que “evita XSS”. No lo evita.

Solo limita uno de los posibles impactos.

---

### 6. Atributo Secure

Explicar:

```text
Secure
```

indica que la cookie solo debe enviarse mediante HTTPS.

Idea clave:

> Una cookie sensible no debería viajar por conexiones HTTP sin cifrar.

---

### 7. Atributo SameSite

Explicar de forma sencilla:

```text
SameSite
```

limita cuándo se envía una cookie en peticiones iniciadas desde otros sitios.

No profundizar todavía en CSRF.

Basta con introducir:

> Ayuda a reducir determinados ataques en los que otro sitio intenta provocar peticiones utilizando nuestra sesión.

Los valores pueden mencionarse:

- `Strict`;
- `Lax`;
- `None`.

Pero no es necesario entrar en todos sus matices en esta sesión.

---

### 8. HTTPS

Plantear:

> Si enviamos una contraseña o una cookie por la red, ¿qué problema habría si alguien pudiera leer el tráfico?

Explicar que HTTPS proporciona principalmente:

- confidencialidad;
- integridad;
- autenticación del servidor.

Es suficiente con esta idea:

```text
HTTP
Navegador -------- Servidor
      datos legibles

HTTPS
Navegador ======== Servidor
      canal cifrado
```

No explicar el protocolo TLS paso a paso.

---

### 9. Qué NO protege HTTPS

Conviene terminar esta parte con ejemplos.

HTTPS no evita:

- SQL Injection;
- XSS;
- errores de autorización;
- contraseñas mal almacenadas;
- subida de archivos peligrosos;
- errores de lógica;
- exposición de información por la propia aplicación.

Frase clave:

> HTTPS puede proteger perfectamente una conexión con una aplicación vulnerable.

---

## Preguntas que puede lanzar el profesor

Durante la explicación:

- ¿Cookie y sesión son lo mismo?
- ¿Dónde se guarda normalmente la sesión?
- ¿Qué contiene realmente una cookie de sesión?
- ¿Qué ocurriría si eliminamos la cookie?
- ¿Qué ocurriría si otra persona obtiene una cookie de sesión válida?
- ¿Para qué sirve `HttpOnly`?
- ¿`HttpOnly` evita XSS?
- ¿Para qué sirve `Secure`?
- ¿HTTPS hace que una aplicación sea segura?
- ¿Una SQL Injection deja de funcionar si usamos HTTPS?

---

## Temporalización orientativa

| Tiempo | Actividad |
|---|---|
| 00:00–00:10 | Recordatorio: HTTP sin estado |
| 00:10–00:35 | Cookies y sesiones |
| 00:35–00:50 | Flujo de login y cookie de sesión |
| 00:50–01:05 | `HttpOnly`, `Secure` y `SameSite` |
| 01:05–01:20 | HTTPS: qué protege y qué no |
| 01:20–01:30 | Demostración con DevTools |
| 01:30–01:55 | Actividad práctica |
| 01:55–02:00 | Conclusiones |

La explicación de HTTPS debe mantenerse breve para asegurar tiempo suficiente para la práctica.

---

## Demostración del profesor — Observar una sesión

Utilizar una aplicación que disponga de autenticación.

Puede ser:

- TxurdiGest;
- una miniaplicación PHP;
- cualquier aplicación local preparada para la sesión.

### Paso 1 — Antes del login

Abrir DevTools.

Según el navegador:

```text
Application → Cookies
```

o equivalente.

Mostrar qué cookies existen antes de iniciar sesión.

---

### Paso 2 — Iniciar sesión

Realizar el login.

Volver a revisar las cookies.

Localizar la cookie de sesión.

En PHP podría aparecer como:

```text
PHPSESSID
```

No es obligatorio que tenga ese nombre si la aplicación utiliza otro mecanismo.

---

### Paso 3 — Revisar atributos

Mostrar, si están disponibles:

- nombre;
- valor;
- dominio;
- ruta;
- expiración;
- `HttpOnly`;
- `Secure`;
- `SameSite`.

No es necesario que la aplicación utilizada tenga todos los atributos configurados.

De hecho, si falta alguno puede utilizarse como pregunta:

> ¿Debería estar activado en una aplicación real?

---

### Paso 4 — Observar Network

Realizar una petición dentro de la aplicación.

En:

```text
Network → Request Headers
```

localizar:

```text
Cookie: ...
```

Explicar:

> El navegador envía automáticamente la cookie al servidor cuando corresponde.

Si aparece una respuesta que crea o actualiza una cookie, mostrar:

```text
Set-Cookie
```

---

### Paso 5 — Eliminar la cookie

Eliminar la cookie de sesión desde DevTools.

Recargar la página o acceder a una zona protegida.

Observar el resultado.

Lo esperable es que la aplicación deje de reconocer al usuario o solicite autenticación nuevamente.

Preguntar:

> ¿Hemos borrado todos los datos de la sesión o solo el identificador que permitía localizarla?

---

## Actividad práctica — Investigar una sesión web

### Organización

Trabajo por parejas.

Duración aproximada: 25 minutos.

Cada pareja debe utilizar una aplicación con autenticación.

---

### Tarea 1 — Localizar la cookie

Después de iniciar sesión:

1. abrir DevTools;
2. localizar el almacenamiento de cookies;
3. identificar la cookie relacionada con la sesión.

Completar:

| Dato | Valor observado |
|---|---|
| Nombre de la cookie | |
| Dominio | |
| Path | |
| Expiración | |
| `HttpOnly` | |
| `Secure` | |
| `SameSite` | |

Si algún atributo no aparece, indicarlo.

---

### Tarea 2 — Localizar la cookie en una petición

En Network:

1. realizar una petición dentro de la aplicación;
2. abrir la petición;
3. localizar la cabecera `Cookie`.

Responder:

> ¿Quién añade esta cabecera a la petición?

La conclusión esperada es:

> El navegador la envía automáticamente según las reglas asociadas a la cookie.

---

### Tarea 3 — Eliminar la cookie

Eliminar la cookie de sesión.

Después:

1. recargar la página;
2. intentar acceder a una zona que requiera autenticación;
3. observar el comportamiento.

Responder:

- ¿sigue la aplicación reconociendo al usuario?
- ¿por qué?
- ¿qué papel tenía la cookie?

---

### Tarea 4 — Relacionar cookie y sesión

Responder brevemente:

> ¿Dónde se encuentra normalmente la información de la sesión?

> ¿Qué función cumple la cookie?

La respuesta esperada es:

- la información de sesión se mantiene en el servidor;
- la cookie permite identificar qué sesión corresponde a cada cliente.

---

## Mini-reto opcional — ¿Está bien protegida esta cookie?

Mostrar una cookie de ejemplo:

```text
PHPSESSID=abc123
```

y después:

```text
PHPSESSID=abc123; HttpOnly; Secure; SameSite=Lax
```

Pedir al alumnado que explique qué mejora aporta cada atributo.

No es necesario entrar en configuraciones perfectas ni casos límite.

El objetivo es interpretar la intención de cada medida.

---

## Puesta en común

Preguntas para cerrar:

1. ¿Qué diferencia hay entre cookie y sesión?
2. ¿Qué ocurrió al eliminar la cookie?
3. ¿Qué protege `HttpOnly`?
4. ¿Qué protege `Secure`?
5. ¿Qué papel tiene `SameSite`?
6. ¿HTTPS protege la aplicación contra SQL Injection o XSS?

Conviene finalizar con:

> La sesión permite mantener identidad entre peticiones, pero ese mecanismo también debe protegerse.

---

## Ideas clave para cerrar la sesión

El alumnado debería quedarse con estas ideas:

1. HTTP no mantiene estado por sí mismo.
2. Las sesiones permiten asociar varias peticiones al mismo usuario.
3. Una cookie suele transportar el identificador de una sesión.
4. La cookie de sesión es información sensible.
5. `HttpOnly`, `Secure` y `SameSite` ayudan a proteger cookies.
6. HTTPS protege la comunicación entre cliente y servidor.
7. HTTPS no corrige vulnerabilidades de programación o autorización.

---

## Conexión con la siguiente semana

La siguiente sesión parte de una consecuencia directa de lo trabajado hasta ahora:

> El usuario controla los datos que envía y el servidor no puede confiar automáticamente en ellos.

A partir de ahí se trabajará:

- validación de entradas;
- validación en cliente y servidor;
- gestión segura de errores;
- manipulación de formularios.

La práctica permitirá comprobar que una validación implementada únicamente en JavaScript puede ser evitada.

---

## Si falta tiempo

Priorizar:

- diferencia cookie/sesión;
- flujo de sesión;
- `HttpOnly`;
- `Secure`;
- HTTPS;
- demostración de eliminación de cookie;
- práctica.

Reducir:

- detalles de `SameSite`;
- `Path`, `Domain`, `Expires` y `Max-Age`;
- mini-reto opcional;
- explicación de certificados.

No eliminar la demostración de la cookie de sesión.

---

## Si sobra tiempo

Se pueden realizar una o varias ampliaciones:

### Observar Set-Cookie

Buscar en Network una respuesta que contenga:

```text
Set-Cookie
```

Compararla con la cabecera `Cookie` enviada posteriormente.

### Comprobar document.cookie

Si existe alguna cookie que no tenga `HttpOnly`, ejecutar en la consola:

```javascript
document.cookie
```

Observar qué cookies son accesibles desde JavaScript.

No modificar cookies sensibles en una aplicación real.

### Comparar HTTP y HTTPS

Comprobar visualmente:

- esquema de la URL;
- presencia de HTTPS;
- atributo `Secure` de una cookie.

No es necesario capturar tráfico ni analizar TLS en profundidad.
