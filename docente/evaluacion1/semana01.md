# Semana 1 — Introducción al desarrollo web seguro

## Objetivos de la sesión

Al finalizar la sesión, el alumnado debería ser capaz de:

- explicar qué significa desarrollar una aplicación web de forma segura;
- entender que la seguridad forma parte de la calidad del software;
- identificar los principales componentes de una aplicación web;
- reconocer qué datos y operaciones pueden requerir protección;
- comprender que la seguridad debe considerarse durante todo el ciclo de desarrollo;
- detectar posibles riesgos sin necesidad de conocer todavía vulnerabilidades concretas.

---

## Material del alumnado

Trabajar principalmente con:

- `1.fundamentos/1.introduccion-desarrollo-web-seguro.md`
- `1.fundamentos/2.arquitectura-aplicacion-web.md`

No es necesario explicar todos los detalles de ambos apartados.

El objetivo de esta primera sesión no es presentar vulnerabilidades concretas, sino establecer las ideas básicas que se reutilizarán durante todo el módulo.

---

## Contenidos que se trabajan en clase

### Desarrollo web seguro

Trabajar especialmente:

- seguridad como parte de la calidad del software;
- seguridad durante todo el ciclo de vida;
- diferencia entre desarrollar de forma segura y realizar pentesting;
- importancia de no confiar automáticamente en los datos externos;
- necesidad de proteger datos, operaciones y usuarios.

Evitar por ahora entrar en detalle en:

- OWASP Top 10;
- clasificación de vulnerabilidades;
- técnicas concretas de ataque;
- herramientas de auditoría;
- detalles técnicos de XSS, SQL Injection, CSRF, etc.

### Arquitectura básica de una aplicación web

Repasar:

- cliente / navegador;
- servidor web;
- aplicación;
- base de datos;
- flujo básico de una petición.

El objetivo no es volver a explicar arquitectura web desde cero, sino utilizarla para responder a una pregunta:

> ¿En qué puntos puede aparecer un problema de seguridad?

---

## Guion orientativo para la explicación

### 1. Qué significa desarrollar una aplicación web de forma segura

Se puede comenzar con una idea sencilla:

> Una aplicación no es segura únicamente porque funcione correctamente.

Una aplicación puede funcionar desde el punto de vista funcional y, sin embargo:

- permitir acceder a información de otros usuarios;
- aceptar datos que no debería;
- mostrar información sensible en errores;
- almacenar contraseñas de forma insegura;
- confiar demasiado en lo que envía el navegador;
- permitir acciones a usuarios que no deberían poder realizarlas.

Conviene transmitir desde el principio que la seguridad forma parte de la calidad del software.

Se pueden plantear preguntas como:

- ¿Una aplicación que permite ver los datos de otro usuario funciona?
- ¿Una web que almacena contraseñas en texto plano puede funcionar?
- ¿Una aplicación que muestra errores internos de base de datos puede seguir funcionando?

En todos los casos, la respuesta puede ser sí.

Por tanto:

> Que una aplicación funcione no significa que sea segura.

---

### 2. La seguridad no se añade al final

Explicar que puede existir la idea de desarrollar primero y añadir seguridad después:

```text
Analizar
   ↓
Programar
   ↓
Probar
   ↓
Desplegar
   ↓
Añadir seguridad
```

Ese enfoque no es adecuado.

La seguridad debe estar presente durante todo el ciclo de vida:

```text
Diseño
   ↓
Implementación
   ↓
Pruebas
   ↓
Despliegue
   ↓
Mantenimiento
```

Ejemplos sencillos:

- durante el diseño se decide quién puede acceder a cada información;
- durante la programación se validan los datos y se controlan los permisos;
- durante las pruebas se intenta comprobar si esas medidas pueden saltarse;
- durante el despliegue se protegen secretos, permisos y comunicaciones;
- durante el mantenimiento se revisan dependencias y vulnerabilidades.

No es necesario profundizar todavía en cada medida.

La idea que debe quedar es:

> La seguridad es un proceso, no una tarea final.

---

### 3. Desarrollo seguro frente a pentesting

Conviene aclarar esta diferencia desde el principio porque durante el módulo se utilizarán herramientas y técnicas que permiten reproducir ataques.

**Desarrollo seguro**

El objetivo es construir una aplicación evitando vulnerabilidades.

**Pentesting**

El objetivo es buscar vulnerabilidades existentes intentando explotarlas.

En este módulo se realizarán pequeñas pruebas ofensivas, pero siempre con esta secuencia:

```text
Comprender el problema
        ↓
Reproducirlo
        ↓
Corregirlo
        ↓
Comprobar la corrección
```

La finalidad no es aprender a atacar sistemas ajenos, sino aprender a construir software más seguro.

---

### 4. No confiar en los datos que llegan desde el cliente

Introducir una idea que aparecerá continuamente durante el curso:

> Todo dato que llega al servidor puede haber sido manipulado.

Aunque el formulario tenga:

- campos obligatorios;
- listas desplegables;
- campos ocultos;
- validación JavaScript;
- botones deshabilitados;

el usuario controla su navegador.

Por tanto, puede modificar lo que se envía.

Todavía no es necesario demostrarlo en esta sesión. Se trabajará más adelante con DevTools.

La idea que debe quedar es:

```text
Navegador ≠ entorno de confianza
```

---

### 5. Arquitectura y superficie de exposición

Repasar brevemente la arquitectura:

```text
Usuario
   ↓
Navegador
   ↓
Servidor web
   ↓
Aplicación
   ↓
Base de datos
```

A partir de este esquema plantear:

> ¿En qué lugares puede aparecer un problema?

Algunos ejemplos:

**Navegador**

- entrada de datos;
- JavaScript;
- cookies.

**Servidor**

- configuración;
- permisos;
- errores.

**Aplicación**

- validación;
- autenticación;
- autorización;
- lógica de negocio.

**Base de datos**

- consultas;
- credenciales;
- información sensible.

No desarrollar todavía cada concepto.

La intención es preparar la actividad práctica posterior.

---

## Preguntas que puede lanzar el profesor

Durante la explicación se pueden utilizar preguntas cortas para mantener al grupo activo:

- ¿Quién controla realmente los datos de un formulario?
- ¿Ocultar un botón impide realizar una operación?
- ¿POST es necesariamente más seguro que GET?
- ¿Puede una aplicación funcionar perfectamente y ser insegura?
- ¿Dónde guardaríais una contraseña de base de datos?
- ¿Qué ocurre si un alumno cambia el identificador de otro alumno en una URL?
- ¿Qué datos de una aplicación consideraríais sensibles?
- ¿Qué parte de una aplicación web creéis que es más crítica?

No es necesario resolver todas las preguntas en esta primera sesión.

Algunas se recuperarán posteriormente durante el módulo.

---

## Temporalización orientativa

| Tiempo | Actividad |
|---|---|
| 00:00–00:10 | Presentación del módulo y objetivos |
| 00:10–00:35 | Qué significa desarrollar de forma segura |
| 00:35–00:50 | Seguridad durante el ciclo de vida |
| 00:50–01:05 | Desarrollo seguro frente a pentesting |
| 01:05–01:20 | Arquitectura de una aplicación web |
| 01:20–01:45 | Actividad práctica por equipos |
| 01:45–01:55 | Puesta en común |
| 01:55–02:00 | Ideas clave y conexión con la siguiente sesión |

La temporalización es orientativa.

Si durante la explicación surgen ejemplos o preguntas interesantes, se puede reducir ligeramente la parte teórica, pero conviene mantener siempre la actividad práctica final.

---

## Demostración del profesor

Mostrar de forma breve el esquema de TxurdiGest:

```text
Navegador
    ↓
Servidor web
    ↓
Aplicación
    ↓
Base de datos
```

Plantear preguntas como:

- ¿por dónde entra información?
- ¿dónde se almacenan datos?
- ¿qué operaciones modifican información?
- ¿qué ocurriría si un usuario intenta actuar como otro?
- ¿qué datos consideraríamos sensibles?
- ¿qué componentes dependen de otros componentes?

No dar todavía respuestas utilizando términos como XSS, SQL Injection, IDOR o CSRF.

El objetivo es que el alumnado razone desde el funcionamiento de la aplicación.

---

## Actividad práctica — ¿Qué puede salir mal?

### Organización

Trabajo en grupos de 3–4 personas.

Duración aproximada: 25 minutos.

### Situación

TxurdiGest permite, entre otras cosas:

- iniciar sesión;
- consultar información personal;
- modificar determinados datos;
- gestionar usuarios;
- introducir información mediante formularios;
- almacenar información en una base de datos.

Cada equipo debe identificar posibles situaciones problemáticas.

No es necesario utilizar vocabulario técnico de seguridad.

### Tarea

Completar una tabla similar a esta:

| Elemento | ¿Qué podría salir mal? |
|---|---|
| Inicio de sesión | |
| Datos personales | |
| Formularios | |
| Roles de usuario | |
| Base de datos | |
| Servidor | |

Se pueden añadir otros elementos si el equipo identifica más puntos de riesgo.

### Preguntas de apoyo

Si algún grupo no sabe por dónde empezar, se pueden utilizar preguntas como:

- ¿Qué ocurriría si alguien intenta acceder con el usuario de otra persona?
- ¿Y si modifica los datos enviados por un formulario?
- ¿Qué pasaría si un usuario intenta consultar información que no le corresponde?
- ¿Qué información no debería aparecer nunca en pantalla?
- ¿Qué podría ocurrir si una contraseña se almacena sin protección?
- ¿Qué podría pasar si el servidor acepta cualquier archivo?
- ¿Qué ocurriría si la aplicación confía completamente en lo que recibe del navegador?

---

## Puesta en común

Cada equipo explica uno o dos riesgos.

El profesor puede agrupar las respuestas en categorías generales:

- acceso indebido;
- datos manipulados;
- información expuesta;
- acciones no autorizadas;
- errores de configuración;
- datos no confiables;
- credenciales o secretos expuestos.

No es necesario asociar todavía cada problema a una vulnerabilidad concreta.

El objetivo es mostrar que muchos problemas de seguridad aparecen en lugares distintos de la aplicación.

---

## Ideas clave para cerrar la sesión

El alumnado debería quedarse con estas ideas:

1. La seguridad no se añade al final.
2. Una aplicación puede funcionar correctamente y ser insegura.
3. Los datos externos no deben considerarse fiables.
4. Una aplicación segura debe proteger datos, operaciones y usuarios.
5. Para proteger una aplicación primero hay que entender cómo funciona.
6. Durante el curso se aprenderá a identificar, reproducir, corregir y verificar problemas de seguridad.

---

## Conexión con la siguiente semana

La siguiente sesión analizará cómo se comunican realmente navegador y servidor mediante HTTP.

La pregunta de partida será:

> ¿Qué envía exactamente el navegador al servidor y cuánto control tiene el usuario sobre esos datos?

Esta pregunta permitirá conectar posteriormente HTTP con validación, sesiones, autenticación y vulnerabilidades web.

---

## Si falta tiempo

Priorizar:

- concepto de desarrollo seguro;
- seguridad durante todo el ciclo de vida;
- arquitectura básica;
- actividad práctica.

Reducir:

- explicación de pentesting;
- número de ejemplos;
- puesta en común a unos 10 minutos.

No eliminar la actividad práctica.

---

## Si sobra tiempo

Se puede pedir a cada equipo que clasifique los riesgos identificados según dónde aparecen:

- cliente;
- servidor;
- aplicación;
- base de datos.

También se puede pedir que distingan entre:

- datos que hay que proteger;
- operaciones que hay que proteger;
- usuarios o roles que intervienen.

Esto servirá como transición hacia conceptos posteriores de autenticación y autorización.
