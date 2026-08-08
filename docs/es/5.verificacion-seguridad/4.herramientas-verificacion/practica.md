# Práctica: verificación con herramientas

## Contexto

Las herramientas de verificación permiten observar peticiones, modificar datos y comprobar cómo responde realmente una aplicación.

En esta práctica se utilizarán herramientas ya trabajadas durante el módulo.

El objetivo no es explorar la aplicación sin criterio.

Cada herramienta debe utilizarse para responder una pregunta concreta.

## Objetivo

Realizar varias comprobaciones sobre una funcionalidad de la aplicación utilizando:

- Chrome DevTools;
- Burp Suite;
- logs;
- `curl`, cuando resulte útil.

Cada comprobación debe seguir este esquema:

```text
Pregunta

    ↓

Herramienta

    ↓

Prueba

    ↓

Resultado

    ↓

Evidencia
```

## Paso 1. Seleccionar una funcionalidad

Elegir una funcionalidad que genere peticiones HTTP.

Ejemplos:

- iniciar sesión;
- consultar reservas;
- editar un recurso;
- enviar un formulario;
- consumir una API.

Ejemplo:

```text
Editar una reserva
```

## Paso 2. Observar la petición con DevTools

Abrir:

```text
DevTools

    ↓

Network
```

Ejecutar la funcionalidad.

Seleccionar la petición correspondiente.

Registrar:

- URL;
- método HTTP;
- código de estado;
- parámetros;
- cuerpo de la petición;
- respuesta.

Ejemplo:

```text
PUT /api/reservas/25

Status: 200
```

## Paso 3. Revisar Headers

Dentro de la petición revisar:

```text
Request Headers

Response Headers
```

Comprobar:

```text
[ ] La petición utiliza HTTPS

[ ] El tipo de contenido es correcto

[ ] Las cabeceras de seguridad esperadas están presentes

[ ] No se expone información innecesaria
```

Si la funcionalidad utiliza cookies, revisar también sus atributos.

## Paso 4. Revisar cookies

Abrir:

```text
DevTools

    ↓

Application

    ↓

Cookies
```

Seleccionar la cookie de sesión.

Comprobar, cuando corresponda:

```text
[ ] Secure

[ ] HttpOnly

[ ] SameSite
```

No incluir el valor completo de la cookie en las evidencias.

## Paso 5. Modificar una petición con Burp Suite

Interceptar una petición relacionada con la funcionalidad.

Ejemplo:

```text
POST /reservas

fecha=2026-08-10
personas=2
```

Modificar un valor.

Ejemplo:

```text
personas=-5
```

Enviar la petición.

Resultado esperado:

```text
El servidor rechaza el dato
```

Registrar:

```text
Código de estado:
________________

Respuesta:
________________

Resultado:
________________
```

## Paso 6. Utilizar Repeater

Enviar una petición a Burp Repeater.

Seleccionar un parámetro o identificador.

Ejemplo:

```text
GET /reservas/25
```

Modificar:

```text
25 → 26
```

Enviar de nuevo.

Comprobar:

```text
[ ] La autorización se vuelve a evaluar

[ ] No se accede a recursos ajenos

[ ] El código de estado es coherente
```

## Paso 7. Revisar una respuesta de error

Provocar un error controlado.

Por ejemplo:

- recurso inexistente;
- identificador inválido;
- dato incorrecto.

Observar la respuesta mediante DevTools o Burp.

Comprobar:

```text
[ ] No aparecen rutas internas

[ ] No aparecen consultas SQL

[ ] No aparecen excepciones completas

[ ] No aparecen secretos

[ ] El mensaje es adecuado para el usuario
```

## Paso 8. Revisar logs

Después de provocar el error, comprobar el registro interno de la aplicación.

El log debería permitir comprender el problema sin almacenar información innecesaria.

Ejemplo:

```text
Fecha

Usuario

Operación

Error técnico
```

Comprobar:

```text
[ ] El error queda registrado

[ ] No aparecen contraseñas

[ ] No aparecen tokens completos

[ ] No aparecen secretos
```

## Paso 9. Comprobar cabeceras con curl

Cuando el entorno lo permita:

```bash
curl -I https://txurdigest.ejemplo
```

Observar las cabeceras devueltas.

Comprobar aquellas que se hayan definido en el despliegue.

Por ejemplo:

```text
Content-Security-Policy

X-Content-Type-Options

Strict-Transport-Security

Referrer-Policy
```

No es necesario que todas las aplicaciones tengan exactamente la misma configuración.

La prueba debe comprobar la configuración definida para el proyecto.

## Paso 10. Registrar evidencias

Para cada comprobación indicar:

```text
Pregunta

Herramienta utilizada

Resultado esperado

Resultado obtenido

Evidencia
```

Ejemplo:

```text
Pregunta:
¿puede un usuario acceder a una reserva ajena?

Herramienta:
Burp Repeater

Resultado esperado:
403

Resultado obtenido:
403

Evidencia:
captura de petición y respuesta
```

## Evidencias válidas

Pueden utilizarse:

- captura de DevTools Network;
- captura de Application > Cookies sin mostrar el valor;
- petición modificada en Burp;
- respuesta HTTP;
- cabeceras obtenidas con `curl`;
- fragmento de log anonimizado.

## Información que no debe entregarse

No incluir en las capturas:

```text
Contraseñas

Tokens completos

Cookies de sesión completas

Claves API

Credenciales

Secretos
```

Si aparece información sensible, debe ocultarse antes de entregar la evidencia.

## Aplicación a TxurdiGest

Ejemplo de recorrido:

```text
1. DevTools

Observar PUT /api/reservas/25


2. Burp

Cambiar 25 → 26


3. Servidor

Comprobar autorización


4. Respuesta

Esperar 403


5. Logs

Comprobar que no se genera un error interno
```

Este recorrido demuestra un control concreto.

## Checklist final

```text
[ ] Se ha observado una petición con DevTools

[ ] Se han revisado cabeceras

[ ] Se han revisado cookies cuando procede

[ ] Se ha modificado una petición con Burp

[ ] Se ha utilizado Repeater

[ ] Se ha comprobado un error controlado

[ ] Se han revisado logs

[ ] Se ha utilizado curl cuando resulta aplicable

[ ] Las evidencias no contienen secretos

[ ] Cada herramienta responde a una pregunta concreta
```

## Idea clave

> Las herramientas no sustituyen la prueba: permiten observar, modificar y demostrar de forma objetiva el comportamiento de la aplicación.
