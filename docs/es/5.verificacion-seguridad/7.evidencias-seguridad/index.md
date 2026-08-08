# Evidencias de seguridad

Las decisiones de seguridad deben poder demostrarse.

En un proyecto no basta con afirmar que una medida está aplicada.

Debe existir alguna evidencia que permita comprobarla.

```text
Decisión

    ↓

Implementación

    ↓

Prueba

    ↓

Evidencia
```

La evidencia convierte una afirmación en algo verificable.

## Qué es una evidencia

Una evidencia es un elemento que permite comprobar que una medida funciona realmente.

Puede ser:

- una captura;
- una petición y su respuesta;
- un fragmento de configuración;
- un resultado de prueba;
- un fragmento de código;
- un checklist;
- un log anonimizado;
- una breve explicación técnica.

No todas las decisiones necesitan el mismo tipo de evidencia.

## Evidencia útil

Una evidencia debe ser:

- relevante;
- comprensible;
- suficiente;
- segura.

No debe incluir más información de la necesaria.

Ejemplo:

```text
Objetivo:
comprobar autorización

Evidencia:
petición de usuario A sobre recurso de B

Resultado:
HTTP 403
```

Esto demuestra el control de forma directa.

## Capturas de pantalla

Las capturas pueden ser útiles para mostrar:

- HTTPS;
- certificado;
- cabeceras;
- cookies;
- respuesta HTTP;
- configuración visual;
- error controlado.

Una buena captura debe mostrar únicamente lo necesario.

Evitar capturas de pantalla completas cuando solo interesa una pequeña parte.

## DevTools como fuente de evidencia

DevTools puede utilizarse para obtener evidencias de:

- método HTTP;
- código de estado;
- cabeceras;
- payload;
- respuesta;
- cookies;
- errores CSP.

Ejemplo:

```text
Network

GET /reservas/26

Status: 403
```

Esta evidencia permite justificar una comprobación de autorización.

## Burp Suite como fuente de evidencia

Burp Suite permite demostrar que una petición ha sido modificada.

Ejemplo:

```text
Petición original:

GET /reservas/25


Petición modificada:

GET /reservas/26
```

Resultado:

```text
HTTP 403
```

Esto demuestra que el control se ejecuta también cuando el usuario manipula la petición.

## Código como evidencia

Un fragmento de código puede mostrar cómo se ha implementado un control.

Por ejemplo:

```php
$stmt = $pdo->prepare(
    "SELECT * FROM reservas WHERE id = ?"
);

$stmt->execute([$id]);
```

Este fragmento puede apoyar la evidencia de uso de consultas preparadas.

Sin embargo, mostrar código no demuestra siempre que el comportamiento sea correcto.

Cuando sea posible, debe combinarse con una prueba.

## Configuración como evidencia

Una configuración puede demostrar decisiones de despliegue.

Ejemplo:

```text
APP_DEBUG=false
```

o:

```text
Content-Security-Policy: default-src 'self'
```

La evidencia debe evitar mostrar:

```text
APP_KEY

DB_PASSWORD

API_KEY

tokens
```

## Logs como evidencia

Los logs pueden demostrar cómo se ha gestionado un error.

Ejemplo:

```text
Fecha

Usuario

Operación

Error técnico
```

Antes de utilizar un log como evidencia debe eliminarse o anonimizarse cualquier información sensible.

## Diagramas como evidencia

Un diagrama puede ayudar a justificar decisiones de arquitectura.

Ejemplo:

```text
Internet

    ↓

Servidor web

    ↓

Aplicación

    ↓

Base de datos privada
```

El diagrama no demuestra por sí solo que la configuración esté aplicada.

Debe complementarse con otras comprobaciones cuando sea necesario.

## Checklists como evidencia

Una checklist permite demostrar que se ha realizado una revisión sistemática.

Ejemplo:

```text
[x] HTTPS

[x] DEBUG desactivado

[x] Secretos fuera del código

[x] Base de datos privada

[x] Logs protegidos
```

La checklist debe corresponder al estado real del proyecto.

No debe utilizarse como una simple declaración.

## Evidencia mínima suficiente

No es necesario generar grandes informes.

Para una decisión puede ser suficiente:

```text
Decisión:
solo el propietario puede editar una reserva

Prueba:
usuario A solicita editar recurso de B

Resultado:
403

Evidencia:
captura de petición y respuesta
```

Esto es más útil que varias páginas explicando la intención.

## Relación entre control y evidencia

Cada evidencia debe responder a una pregunta.

Ejemplos:

| Control | Evidencia posible |
|---|---|
| HTTPS | Navegador o `curl` |
| Cookie segura | DevTools Application |
| Autorización | Petición y respuesta 403 |
| Validación servidor | Petición modificada |
| Consulta preparada | Fragmento de código |
| Secretos | Configuración sin valores sensibles |
| Cabeceras | DevTools o `curl` |
| Errores | Respuesta + log anonimizado |

## Evidencias incorrectas

No son buenas evidencias:

- una captura sin contexto;
- grandes bloques de código sin señalar qué se comprueba;
- una checklist sin pruebas;
- una afirmación sin resultado;
- una configuración con secretos visibles.

La evidencia debe permitir entender rápidamente:

```text
Qué se quería comprobar

Qué se hizo

Qué ocurrió
```

## Proteger información sensible

Las evidencias forman parte del proyecto y pueden terminar en:

- repositorios;
- entregas;
- presentaciones;
- documentación.

Por tanto, no deben incluir:

```text
Contraseñas

Tokens completos

Cookies de sesión completas

Claves API

Claves privadas

Credenciales de base de datos

Datos personales innecesarios
```

## Anonimización

Cuando una evidencia contiene información que no es relevante, debe ocultarse.

Ejemplo:

```text
Usuario:

alumno23
```

puede sustituirse por:

```text
Usuario A
```

si la identidad concreta no aporta nada a la prueba.

## Evidencias en los retos ETHAZI

Las evidencias deben integrarse en el desarrollo del reto.

No es necesario esperar al final.

Ejemplo:

```text
Implementar autorización

        ↓

Probar

        ↓

Capturar evidencia

        ↓

Continuar desarrollando
```

Esto reduce el trabajo final y permite detectar problemas antes.

## Aplicación a TxurdiGest

Ejemplo de conjunto de evidencias:

```text
Validación

→ petición con dato inválido rechazada


Autorización

→ usuario A recibe 403 sobre recurso de B


HTTPS

→ certificado válido


Secretos

→ configuración mediante variables de entorno


Cabeceras

→ Response Headers


Errores

→ mensaje controlado + log interno
```

No es necesario que todas las evidencias tengan el mismo formato.

## Plantilla mínima

Para documentar una evidencia puede utilizarse:

```text
Control:
____________________________

Comprobación realizada:
____________________________

Resultado esperado:
____________________________

Resultado obtenido:
____________________________

Evidencia:
____________________________
```

Esta plantilla puede utilizarse únicamente para controles relevantes.

## Idea clave

> Una evidencia de seguridad debe demostrar de forma breve y objetiva que un control existe y funciona, sin exponer información sensible.
