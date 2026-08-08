# Guía de uso y temporalización del módulo Desarrollo Web Seguro

## 1. Finalidad del documento

Este documento define cómo utilizar los contenidos del módulo **Desarrollo Web Seguro** a lo largo del curso y cómo integrarlos en los dos retos de 2.º de DAW.

No sustituye a los apuntes del alumnado.

Su función es servir como guía docente para decidir:

- qué contenidos trabajar en cada momento;
- cuánto tiempo dedicar a cada bloque;
- qué contenidos deben impartirse antes de cada reto;
- qué aspectos de seguridad deben aplicarse durante los retos;
- qué herramientas utilizar;
- qué evidencias de seguridad puede aportar el alumnado.

La idea general del módulo es:

```text
Comprender

    ↓

Diseñar

    ↓

Implementar

    ↓

Desplegar

    ↓

Verificar
```

La seguridad no se plantea como una actividad independiente del desarrollo, sino como un criterio que acompaña a la aplicación durante todo su ciclo de vida.

---

## 2. Datos generales del módulo

| Elemento | Organización |
|---|---|
| Duración total | 42 horas |
| Carga semanal | 2 horas |
| Duración efectiva | 21 semanas |
| Organización del curso | 2 evaluaciones |
| 1.ª evaluación | 11 semanas |
| 2.ª evaluación | 10 sesiones efectivas dentro de unas 11 semanas de calendario |
| Metodología | Formación guiada + aplicación en retos ETHAZI |
| Proyecto de referencia | TxurdiGest |
| Laboratorio principal | DVWA |
| Herramientas | Chrome DevTools, Burp Suite, DVWA y herramientas del navegador/servidor |

!!! note "42 horas y calendario"
    Con una carga de 2 horas semanales, 42 horas corresponden a **21 semanas lectivas efectivas**. Si el calendario de las dos evaluaciones ocupa aproximadamente 11 semanas cada una, debe contemplarse una semana sin sesión efectiva del módulo o utilizada como margen de calendario, evaluación, festivos o contingencias.

---

## 3. Modelo de trabajo

El módulo combina dos formas de trabajo.

### Formación guiada

Durante las primeras semanas de cada evaluación se introducen los conceptos que el alumnado necesitará posteriormente en el reto.

Estas sesiones pueden combinar:

- explicación conceptual;
- ejemplos de código;
- análisis de TxurdiGest;
- DevTools;
- Burp Suite;
- pequeños laboratorios con DVWA;
- comprobaciones breves.

No es necesario convertir cada capítulo del manual en una actividad independiente.

### Integración en el reto

Cuando comienza el reto, las 2 horas semanales del módulo continúan impartiéndose.

La diferencia es que dejan de utilizarse principalmente para introducir contenido nuevo y pasan a emplearse para:

- revisar decisiones de diseño;
- revisar código;
- comprobar controles de seguridad;
- realizar pruebas negativas;
- revisar el despliegue;
- corregir problemas;
- recoger evidencias.

Por tanto:

```text
Antes del reto

2 h/semana
→ formación y preparación


Durante el reto

2 h/semana
→ aplicación, revisión y verificación
```

---

# 4. Primera evaluación

## 4.1. Características

Duración:

```text
11 semanas × 2 horas = 22 horas
```

Distribución recomendada:

```text
8 semanas de formación guiada → 16 h

3 semanas integradas en el reto → 6 h
```

Esta distribución puede ajustarse a:

```text
7 semanas de formación + 4 semanas de reto
```

si el calendario del reto requiere comenzar una semana antes.

El objetivo es mantener aproximadamente la proporción:

```text
70 % formación previa

30 % aplicación en el reto
```

---

## 4.2. Tecnologías del Reto 1

El primer reto se desarrolla principalmente con:

- PHP;
- JavaScript;
- CSS3;
- base de datos;
- servidor web;
- despliegue del proyecto.

La seguridad debe diferenciar claramente el papel del cliente y del servidor:

```text
JavaScript

→ mejora la experiencia del usuario


PHP

→ aplica los controles efectivos de seguridad
```

---

## 4.3. Temporalización propuesta — Primera evaluación

| Semana | Horas | Trabajo principal | Manual |
|---|---:|---|---|
| 1 | 2 h | Introducción al desarrollo web seguro y ciclo de vida | Bloque 1 |
| 2 | 2 h | Arquitectura web y protocolo HTTP | Bloque 1 |
| 3 | 2 h | Cookies, sesiones, HTTPS y observación con DevTools | Bloque 1 |
| 4 | 2 h | Diseño seguro: datos, activos, riesgos y decisiones de seguridad | Bloque 2 |
| 5 | 2 h | Validación de entradas y gestión segura de errores | Bloque 2 |
| 6 | 2 h | Autenticación, autorización y gestión de secretos | Bloque 2 |
| 7 | 2 h | Implementación: validación cliente/servidor y salida segura | Bloque 3 |
| 8 | 2 h | Acceso seguro a datos. SQL Injection. Burp/DVWA | Bloque 3 |
| 9 | 2 h | Reto 1: revisión de entradas, salida y acceso a datos | Bloques 2–3 |
| 10 | 2 h | Reto 1: autenticación, sesiones, autorización y secretos | Bloques 2–3 |
| 11 | 2 h | Reto 1: revisión de seguridad y evidencias | Bloque 5 |

Total:

```text
22 horas
```

---

## 4.4. Qué debería estar aprendido antes de comenzar el Reto 1

Antes del reto, el alumnado debería comprender:

- arquitectura básica de una aplicación web;
- funcionamiento de HTTP;
- cookies y sesiones;
- HTTPS;
- diferencia entre autenticación y autorización;
- validación de entradas;
- gestión de errores;
- gestión de secretos;
- diferencia entre validación cliente y servidor;
- salida segura;
- acceso seguro a la base de datos;
- principios básicos de SQL Injection y XSS.

No se espera todavía dominar todos los contenidos del módulo.

---

## 4.5. Seguridad durante el Reto 1

Las sesiones del módulo durante el reto deben utilizar la aplicación real de cada equipo.

### Semana de revisión 1

Centrarse en:

- entradas;
- formularios;
- validación JavaScript;
- validación PHP;
- salida segura;
- consultas preparadas.

Posibles comprobaciones:

```text
¿El servidor acepta un dato que JavaScript rechaza?

¿Se puede modificar la petición?

¿Los datos se muestran de forma segura?

¿Las consultas utilizan parámetros?
```

Herramientas:

- DevTools;
- Burp Suite;
- revisión de código.

### Semana de revisión 2

Centrarse en:

- autenticación;
- sesiones;
- autorización;
- secretos.

Posibles comprobaciones:

```text
¿Se puede acceder sin iniciar sesión?

¿Un usuario puede acceder a recursos de otro?

¿Qué ocurre si se modifica un ID?

¿Existen secretos dentro del código?
```

### Semana de revisión 3

Centrarse en:

- revisión global;
- pruebas negativas;
- errores;
- configuración;
- evidencias.

No debe convertirse en una memoria extensa.

El objetivo es:

```text
Control

    ↓

Prueba

    ↓

Resultado

    ↓

Corrección

    ↓

Evidencia
```

---

# 5. Segunda evaluación

## 5.1. Características

La segunda evaluación dispone de aproximadamente 11 semanas de calendario, pero para mantener la duración oficial del módulo se consideran **10 sesiones efectivas de 2 horas**:

```text
10 semanas efectivas × 2 horas = 20 horas
```

Distribución recomendada:

```text
7 semanas de formación guiada → 14 h

3 semanas integradas en el reto → 6 h
```

Esta distribución mantiene una lógica similar a la primera evaluación: primero se trabajan los contenidos necesarios y, posteriormente, las sesiones del módulo se integran directamente en el reto.

Según el calendario real, también puede ajustarse a:

```text
8 semanas de formación guiada → 16 h

2 semanas integradas en el reto → 4 h
```

En ambos casos se mantienen las **20 horas efectivas** correspondientes a la segunda evaluación.

---

## 5.2. Tecnologías del Reto 2

El segundo reto se desarrolla principalmente con:

- Laravel;
- Vue 3;
- Tailwind;
- APIs;
- base de datos;
- servidor Linux/Apache;
- despliegue de producción.

La separación de responsabilidades debe seguir siendo explícita:

```text
Vue

→ interfaz y experiencia de usuario


Laravel

→ validación, autenticación,
  autorización y controles del servidor
```

---

## 5.3. Temporalización propuesta — Segunda evaluación

| Semana efectiva | Horas | Trabajo principal | Manual |
|---|---:|---|---|
| 1 | 2 h | Implementación segura: autenticación y sesiones | Bloque 3 |
| 2 | 2 h | Autorización, roles y protección de recursos | Bloque 3 |
| 3 | 2 h | APIs, JSON y CORS | Bloque 3 |
| 4 | 2 h | Subida segura de archivos y revisión de controles de implementación | Bloque 3 |
| 5 | 2 h | Configuración de producción, secretos y variables de entorno | Bloque 4 |
| 6 | 2 h | HTTPS, servidor, superficie de exposición, permisos y base de datos | Bloque 4 |
| 7 | 2 h | Verificación: revisión de código, pruebas, herramientas y evidencias | Bloque 5 |
| 8 | 2 h | Reto 2: validación, API, autenticación y autorización | Bloques 3 y 5 |
| 9 | 2 h | Reto 2: despliegue, secretos, permisos, HTTPS y logs | Bloques 4–5 |
| 10 | 2 h | Reto 2: pruebas finales, checklist, correcciones y evidencias | Bloque 5 |

Total:

```text
20 horas
```

La semana adicional de calendario puede funcionar como margen para:

- festivos;
- evaluación;
- actividades generales del ciclo;
- recuperación de sesiones;
- reajuste del reto.

---

# 6. Distribución total de horas

| Parte | Horas |
|---|---:|
| 1.ª evaluación — formación guiada | 16 h |
| 1.ª evaluación — integración Reto 1 | 6 h |
| 2.ª evaluación — formación guiada | 14 h |
| 2.ª evaluación — integración Reto 2 | 6 h |
| **Total** | **42 h** |

Por tipo de trabajo:

```text
Formación guiada

30 h


Aplicación directa en retos

12 h
```

Esto supone aproximadamente:

```text
71 % formación guiada

29 % aplicación en retos
```

---

# 7. Papel de los bloques del manual

Los bloques no deben entenderse como unidades completamente independientes.

Su función a lo largo del curso es:

| Bloque | Función principal |
|---|---|
| Bloque 1 — Fundamentos | Comprender |
| Bloque 2 — Diseño seguro | Diseñar |
| Bloque 3 — Implementación segura | Implementar |
| Bloque 4 — Despliegue seguro | Desplegar |
| Bloque 5 — Verificación | Verificar |

Durante los retos pueden consultarse simultáneamente varios bloques.

Ejemplo:

```text
Problema:

usuario puede editar recurso ajeno

        ↓

Bloque 2
→ decisión de autorización

Bloque 3
→ implementación

Bloque 5
→ prueba y evidencia
```

---

# 8. Uso de TxurdiGest

TxurdiGest se utiliza durante las semanas de formación como ejemplo común.

Permite explicar los conceptos sin depender todavía del proyecto concreto de cada equipo.

Por ejemplo:

```text
TxurdiGest

→ ejemplo conceptual


Reto

→ aplicación real
```

No es necesario desarrollar TxurdiGest como una aplicación completa ni mantener un proyecto ejecutable paralelo.

---

# 9. Uso de DVWA

DVWA se utiliza únicamente como laboratorio controlado para determinados mecanismos.

Principalmente:

- XSS;
- SQL Injection;
- subida insegura de archivos.

Su función es:

```text
Observar vulnerabilidad

        ↓

Comprender causa

        ↓

Comprender corrección
```

DVWA no debe convertirse en el eje del módulo ni en un curso de pentesting.

---

# 10. Uso de Burp Suite

Burp Suite se utiliza para demostrar que el navegador no es una frontera de seguridad.

Ejemplos:

- modificar un dato validado por JavaScript;
- cambiar un identificador;
- repetir una petición;
- comprobar autorización;
- observar una respuesta HTTP.

La pregunta siempre debe preceder a la herramienta:

```text
¿Qué quiero comprobar?

        ↓

¿Qué petición interviene?

        ↓

¿Qué herramienta necesito?
```

---

# 11. Evidencias durante los retos

Las evidencias deben ser pocas y significativas.

No se pretende generar una memoria de seguridad separada.

Ejemplos:

- petición manipulada y respuesta;
- captura de DevTools;
- respuesta `403`;
- consulta parametrizada;
- fragmento de código relevante;
- comprobación de HTTPS;
- configuración sin secretos;
- error controlado;
- cabecera HTTP;
- checklist seleccionada.

Como criterio general:

```text
Decisión

    ↓

Control

    ↓

Prueba

    ↓

Evidencia
```

---

# 12. Checklist del módulo

La checklist del Bloque 5 funciona como **checklist maestra**.

No debe exigirse completa en todos los proyectos.

Cada reto seleccionará los controles que realmente correspondan.

## Selección orientativa — Reto 1

Priorizar:

- validación;
- salida segura;
- SQL;
- autenticación;
- sesiones;
- autorización;
- secretos;
- errores;
- HTTPS;
- base de datos.

## Selección orientativa — Reto 2

Priorizar:

- validación Laravel;
- autenticación;
- autorización;
- APIs;
- CORS;
- secretos;
- configuración de producción;
- HTTPS;
- permisos;
- cabeceras;
- logs;
- base de datos.

---

# 13. Papel del docente durante el reto

Durante las semanas integradas en el reto, las sesiones de Desarrollo Web Seguro no deberían convertirse en nuevas clases teóricas completas.

El papel principal pasa a ser:

- introducir una cuestión breve;
- revisar decisiones de los equipos;
- plantear pruebas;
- hacer preguntas sobre el código;
- detectar controles ausentes;
- ayudar a obtener evidencias;
- pedir correcciones cuando sea necesario.

Ejemplo de una sesión de 2 horas:

```text
20 min
Microintervención

        ↓

70 min
Aplicación en el proyecto

        ↓

20 min
Pruebas / revisión

        ↓

10 min
Puesta en común
```

Esta distribución es orientativa y puede variar según el momento del reto.

---

# 14. Principio metodológico final

El módulo no debe funcionar como:

```text
Teoría de seguridad

        ↓

Examen o actividad aislada

        ↓

Reto independiente
```

Debe funcionar como:

```text
Aprender una decisión de seguridad

        ↓

Comprender cómo se implementa

        ↓

Aplicarla en el reto

        ↓

Probarla

        ↓

Corregirla

        ↓

Aportar una evidencia
```

> La finalidad del módulo es que la seguridad se convierta en una forma habitual de desarrollar aplicaciones web, no en una fase añadida al final del proyecto.
