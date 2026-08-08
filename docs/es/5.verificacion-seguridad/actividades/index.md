# Actividad final: revisión de seguridad del reto

## Contexto

La seguridad del proyecto debe poder comprobarse sobre la aplicación real desarrollada durante el reto.

Esta actividad reúne los contenidos trabajados durante el módulo:

- revisión de código;
- pruebas de seguridad;
- herramientas de verificación;
- revisión del despliegue;
- checklist;
- evidencias.

No se trata de generar un informe extenso.

El objetivo es realizar una revisión final ordenada y justificar los controles más importantes.

## Objetivo

Comprobar el estado de seguridad del proyecto mediante:

```text
Revisión

    ↓

Pruebas

    ↓

Correcciones

    ↓

Evidencias
```

Al finalizar, el equipo debe poder responder:

> ¿Qué controles de seguridad hemos aplicado y cómo podemos demostrar que funcionan?

## Organización

La actividad puede realizarse en dos fases:

### Fase 1. Revisión del propio equipo

Cada equipo revisa su aplicación utilizando la checklist del bloque.

### Fase 2. Revisión cruzada

Otro equipo revisa algunos puntos concretos.

La revisión cruzada no pretende calificar al otro equipo.

Su función es detectar aspectos que pueden haber pasado desapercibidos.

## 1. Seleccionar controles críticos

No es necesario revisar todos los puntos con la misma profundidad.

Cada equipo debe seleccionar los controles más relevantes para su proyecto.

Como mínimo, revisar:

```text
[ ] Validación

[ ] Autenticación

[ ] Autorización

[ ] Acceso a datos

[ ] Secretos

[ ] Configuración de producción

[ ] HTTPS

[ ] Errores y logs
```

Añadir otros controles cuando la aplicación los utilice:

```text
[ ] Subida de archivos

[ ] APIs

[ ] CORS

[ ] Cabeceras de seguridad

[ ] Roles

[ ] Cookies
```

## 2. Revisar una funcionalidad completa

Seleccionar una funcionalidad importante.

Ejemplo:

```text
Editar una reserva
```

Seguir su flujo:

```text
Entrada

    ↓

Validación

    ↓

Autenticación

    ↓

Autorización

    ↓

Acceso a datos

    ↓

Respuesta
```

Comprobar que cada control se encuentra en el lugar adecuado.

## 3. Ejecutar pruebas

Realizar al menos:

```text
[ ] Un caso válido

[ ] Una entrada inválida

[ ] Una prueba sin autenticación

[ ] Una prueba de autorización

[ ] Una manipulación de identificador cuando proceda

[ ] Un error controlado
```

Cada prueba debe indicar previamente el resultado esperado.

## 4. Utilizar herramientas

Elegir la herramienta según la comprobación.

Ejemplos:

| Comprobación | Herramienta |
|---|---|
| Peticiones HTTP | DevTools |
| Cookies | DevTools Application |
| Modificar parámetros | Burp Suite |
| Repetir peticiones | Burp Repeater |
| Cabeceras | DevTools / `curl` |
| Errores internos | Logs |

No es necesario utilizar todas las herramientas si no aportan información útil.

## 5. Revisar el despliegue

Comprobar:

```text
[ ] HTTPS activo

[ ] DEBUG desactivado

[ ] Secretos fuera del código

[ ] .env protegido

[ ] Base de datos no expuesta

[ ] Permisos adecuados

[ ] Cabeceras revisadas

[ ] Logs protegidos
```

## 6. Revisión cruzada

El equipo revisor recibe:

- acceso a la aplicación;
- una descripción breve de la funcionalidad;
- la checklist utilizada.

Debe seleccionar entre tres y cinco comprobaciones.

Por ejemplo:

```text
¿Puede acceder sin autenticar?

¿Puede modificar un ID?

¿Se valida una entrada manipulada?

¿Los errores muestran información?

¿La respuesta utiliza HTTPS?
```

El equipo revisor registra únicamente:

```text
Correcto

o

Revisar
```

y una breve explicación cuando detecte un problema.

## 7. Corregir

Los problemas encontrados deben clasificarse.

```text
Crítico

Importante

Mejora
```

No es necesario utilizar una metodología formal de gestión de riesgos.

La clasificación sirve únicamente para decidir qué corregir primero.

Priorizar problemas relacionados con:

- autorización;
- acceso a datos;
- secretos;
- autenticación;
- exposición en producción.

## 8. Repetir las pruebas

Después de una corrección:

```text
Problema

    ↓

Corrección

    ↓

Repetir prueba

    ↓

Resultado correcto
```

No debe darse por corregido un problema únicamente porque el código haya cambiado.

Debe verificarse nuevamente.

## 9. Preparar evidencias

Seleccionar únicamente las evidencias necesarias.

Como referencia:

```text
4–6 evidencias
```

pueden ser suficientes para un proyecto habitual.

Ejemplos:

- respuesta 403 ante recurso ajeno;
- validación del servidor;
- HTTPS activo;
- cookie segura;
- secreto fuera del código;
- error controlado;
- cabeceras HTTP;
- configuración de producción.

## 10. Proteger las evidencias

Antes de entregar, comprobar:

```text
[ ] No aparecen contraseñas

[ ] No aparecen tokens completos

[ ] No aparecen cookies de sesión completas

[ ] No aparecen claves API

[ ] No aparecen credenciales

[ ] No aparecen datos personales innecesarios
```

## Entregable

La entrega debe ser breve.

Incluir:

### 1. Checklist final

Con los controles relevantes marcados como:

```text
Comprobado

Corregido

Pendiente justificado

N/A
```

### 2. Pruebas realizadas

Tabla recomendada:

| Prueba | Esperado | Obtenido | Estado |
|---|---|---|---|
| Caso válido | Correcto | | |
| Entrada inválida | Rechazada | | |
| Sin autenticar | Denegado | | |
| Recurso ajeno | Denegado | | |
| Error controlado | Seguro | | |

### 3. Evidencias

Entre cuatro y seis evidencias relevantes.

### 4. Correcciones

Indicar únicamente los problemas significativos encontrados y la corrección aplicada.

Ejemplo:

```text
Problema:
un usuario podía consultar una reserva ajena

Corrección:
comprobación del propietario antes de devolver el recurso

Verificación:
HTTP 403 después de repetir la prueba
```

## Aplicación a TxurdiGest

Ejemplo de revisión final:

```text
1. Usuario A inicia sesión

2. Consulta su reserva

3. Modifica el ID

4. Intenta consultar la reserva de B

5. Servidor devuelve 403

6. Se guarda evidencia
```

Otra comprobación:

```text
1. Formulario impide personas = -2

2. Burp modifica la petición

3. Servidor recibe personas = -2

4. Servidor rechaza la petición

5. Se guarda evidencia
```

## Cierre de la actividad

Antes de finalizar, responder brevemente:

```text
¿Qué control ha sido más importante?

¿Qué problema se ha detectado?

¿Qué corrección se ha realizado?

¿Qué queda pendiente?
```

No se busca una reflexión extensa.

El objetivo es que el equipo conozca el estado real de seguridad de su aplicación.

## Idea clave

> La revisión final no consiste en afirmar que el proyecto es seguro, sino en seleccionar los controles importantes, probarlos y aportar evidencias de su comportamiento real.
