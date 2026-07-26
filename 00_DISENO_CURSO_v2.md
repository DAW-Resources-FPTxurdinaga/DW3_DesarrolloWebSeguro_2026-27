# Documento de diseño del módulo

# Desarrollo Web Seguro

**Versión:** 2.0  
**Ciclo formativo:** CFGS Desarrollo de Aplicaciones Web (DAW)  
**Curso:** 2.º curso  
**Duración:** 42 horas  

---

# 1. Identificación del módulo

| Elemento | Información |
|---|---|
| Nombre del módulo | Desarrollo Web Seguro |
| Ciclo formativo | CFGS Desarrollo de Aplicaciones Web |
| Curso | Segundo curso |
| Duración | 42 horas |
| Temporalización | 2 horas semanales |
| Metodología | ETHAZI, aprendizaje basado en retos y trabajo cooperativo |

---

# 2. Finalidad del documento

Este documento define el diseño pedagógico y organizativo del módulo **Desarrollo Web Seguro**.

Su objetivo es establecer:

- la finalidad del módulo;
- el enfoque metodológico;
- la organización general del aprendizaje;
- la relación entre contenidos y retos del ciclo;
- la estructura de los materiales didácticos;
- el estado actual de desarrollo del proyecto.

Este documento sirve como referencia para:

- planificación docente;
- creación de materiales;
- coordinación entre docentes;
- evolución del módulo durante el curso.

No es un documento de apuntes para el alumnado, sino un documento de diseño y alineamiento docente.

---

# 3. Finalidad y propósito del módulo

El módulo **Desarrollo Web Seguro** tiene como objetivo que el alumnado incorpore la seguridad como una parte natural del proceso de desarrollo de aplicaciones web.

La seguridad no se plantea como una fase independiente al final del desarrollo, sino como un conjunto de decisiones que deben estar presentes durante todo el ciclo de vida del software.

La visión global del módulo se basa en las diferentes fases del desarrollo de una aplicación:

**Análisis → Diseño → Desarrollo → Despliegue → Verificación**

El alumnado debe comprender que una aplicación segura requiere:

- analizar correctamente el contexto;
- identificar la información que debe protegerse;
- diseñar teniendo en cuenta los riesgos;
- implementar mecanismos de protección;
- configurar adecuadamente el entorno;
- verificar continuamente las medidas aplicadas.

---

# 4. Enfoque del módulo

## 4.1 Desarrollo web seguro frente a pentesting

El módulo está orientado al **desarrollo web seguro**, no al pentesting.

El objetivo no es formar especialistas en explotación de vulnerabilidades, sino desarrolladores capaces de crear aplicaciones teniendo en cuenta criterios básicos de seguridad.

El alumnado aprenderá a:

- identificar riesgos habituales;
- tomar decisiones de diseño seguras;
- aplicar mecanismos de protección;
- revisar sus propios desarrollos.

Las herramientas relacionadas con seguridad se utilizarán como instrumentos de aprendizaje, análisis y verificación.

No se busca aprender a atacar sistemas, sino comprender cómo evitar problemas durante el desarrollo.

---

## 4.2 Seguridad integrada durante todo el desarrollo

La seguridad se trabaja de forma progresiva.

No se presenta como un conjunto de vulnerabilidades o herramientas aisladas, sino como un aspecto transversal del desarrollo software.

La evolución del aprendizaje será:

| Fase | Pregunta guía |
|---|---|
| Comprender | ¿Cómo funciona una aplicación web? |
| Diseñar | ¿Qué decisiones debemos tomar antes de programar? |
| Implementar | ¿Cómo aplicamos seguridad en el código? |
| Desplegar | ¿Cómo publicamos una aplicación segura? |
| Verificar | ¿Cómo comprobamos que sigue siendo segura? |

---

# 5. Metodología

## 5.1 Aprendizaje basado en retos

El módulo se integra dentro de la metodología ETHAZI utilizada en el ciclo.

Los contenidos no se trabajan como unidades independientes, sino como conocimientos aplicables directamente a los retos desarrollados por el alumnado.

La seguridad se incorpora mediante microintervenciones durante el desarrollo:

- análisis inicial;
- decisiones de arquitectura;
- aplicación de mecanismos seguros;
- revisión final.

De esta forma, el alumnado relaciona los conceptos aprendidos con situaciones reales de desarrollo.

---

## 5.2 Trabajo cooperativo y Scrum

El alumnado trabaja en equipos de desarrollo siguiendo una organización similar a un entorno profesional:

- planificación de tareas;
- reparto de responsabilidades;
- seguimiento del trabajo;
- revisión de avances;
- documentación de decisiones.

La seguridad se integra dentro del propio proceso Scrum.

Ejemplo:

**Historia de usuario**

Como profesor quiero modificar una calificación.

**Criterios de aceptación**

- Solo usuarios autorizados pueden modificarla.
- Los datos introducidos deben validarse.
- La operación debe quedar registrada.

---

## 5.3 Autonomía y trabajo asíncrono

Los materiales están diseñados para permitir diferentes ritmos de aprendizaje.

Cada bloque incluye:

- contenidos teóricos;
- ejemplos aplicados;
- actividades prácticas;
- propuestas de ampliación.

Esto permite:

- trabajo presencial;
- trabajo autónomo;
- seguimiento asíncrono;
- aprendizaje personalizado.

---

# 6. Caso de estudio: TxurdiGest

## 6.1 Aplicación de referencia

Durante todo el módulo se utiliza **TxurdiGest** como caso de estudio transversal.

La aplicación permite trabajar los conceptos de seguridad sobre un mismo proyecto, evitando ejemplos aislados para cada contenido.

El objetivo es que el alumnado observe cómo una aplicación evoluciona progresivamente desde el análisis inicial hasta una versión más segura.

---

## 6.2 Evolución de TxurdiGest durante el módulo

| Bloque | Evolución de TxurdiGest |
|---|---|
| Bloque 1. Comprender | Analizar cómo funciona la aplicación y cómo se comunican sus componentes |
| Bloque 2. Diseñar | Definir decisiones de seguridad antes de implementar |
| Bloque 3. Implementar | Aplicar mecanismos de protección en el desarrollo |
| Bloque 4. Desplegar | Configurar un entorno seguro de ejecución |
| Bloque 5. Verificar | Revisar la seguridad de la aplicación y proponer mejoras |

---

## 6.3 Objetivo del caso de estudio

A través de TxurdiGest el alumnado trabajará:

- arquitectura web;
- comunicación cliente-servidor;
- validación de datos;
- autenticación;
- autorización;
- gestión de errores;
- configuración segura;
- despliegue;
- auditoría.

La aplicación se convierte en el elemento común que conecta todos los aprendizajes del módulo.

---

# 7. Organización general del aprendizaje

El módulo se estructura en cinco bloques relacionados con las diferentes fases del desarrollo de una aplicación web segura.

Cada bloque responde a una pregunta guía y tiene un objetivo concreto dentro del proceso de aprendizaje.

---

# Bloque 1. Comprender una aplicación web segura

## Pregunta guía

¿Cómo funciona una aplicación web y dónde aparecen los elementos relacionados con la seguridad?

## Objetivo

Comprender la arquitectura y funcionamiento de una aplicación web antes de aplicar medidas de seguridad.

El alumnado aprende a observar una aplicación, analizar sus componentes y comprender la comunicación entre cliente y servidor.

## Contenidos

- Introducción al desarrollo web seguro.
- Arquitectura de aplicaciones web.
- Cliente y servidor.
- Protocolo HTTP.
- Peticiones y respuestas.
- Cookies y sesiones.
- HTTPS.
- Certificados digitales.
- Herramientas de análisis:

  - DevTools.
  - curl.
  - Burp Suite.
  - Wireshark.

## Resultado esperado

Al finalizar el bloque, el alumnado será capaz de:

- comprender el funcionamiento básico de una aplicación web;
- interpretar comunicaciones HTTP;
- identificar mecanismos relacionados con seguridad;
- utilizar herramientas profesionales de observación.

---

# Bloque 2. Diseñar aplicaciones web seguras

## Pregunta guía

¿Qué decisiones debemos tomar antes de escribir código?

## Objetivo

Aprender a incorporar criterios de seguridad durante las primeras fases del desarrollo.

El alumnado analiza qué elementos deben protegerse, quién utiliza la aplicación y qué controles son necesarios antes de implementar funcionalidades.

## Contenidos

- Principios del desarrollo seguro.
- Validación de entradas.
- Gestión de errores.
- Autenticación.
- Autorización.
- Gestión de secretos.
- Configuración segura.

## Resultado esperado

Al finalizar el bloque, el alumnado será capaz de:

- identificar activos que deben protegerse;
- analizar puntos de entrada;
- definir requisitos básicos de seguridad;
- diseñar mecanismos de identidad y control de acceso.

---

# Bloque 3. Implementar mecanismos de seguridad

## Pregunta guía

¿Cómo aplicamos las decisiones de diseño cuando programamos?

## Objetivo

Aplicar mecanismos de seguridad durante el desarrollo de una aplicación web utilizando las tecnologías habituales del ciclo.

La seguridad se trabaja integrada en el código y no como una capa independiente.

## Contenidos

### Validación y tratamiento de datos

- Validación cliente-servidor.
- Validación de formularios.
- Tipos de datos.
- Longitudes.
- Rangos permitidos.
- Listas blancas.
- Sanitización.
- Salida segura.

### Protección frente a vulnerabilidades habituales

- Cross-Site Scripting (XSS).
- SQL Injection.
- Cross-Site Request Forgery (CSRF).
- Manipulación de parámetros.

### Autenticación y sesiones

- Gestión de contraseñas.
- Hash seguro.
- Inicio de sesión.
- Sesiones.
- Cookies seguras.
- Tokens.

### Autorización

- Roles.
- Permisos.
- Middleware.
- Policies.
- Principio de mínimo privilegio.

### Seguridad en aplicaciones modernas

- APIs.
- CORS.
- Gestión de respuestas.
- Subida segura de archivos.
- Gestión de secretos.

## Tecnologías relacionadas

Los contenidos se aplican sobre las tecnologías utilizadas en los retos del ciclo.

### Reto 1

- PHP.
- JavaScript Vanilla.
- CSS.
- AWS.

### Reto 2

- Laravel.
- Vue.
- Tailwind.

## Resultado esperado

Al finalizar el bloque, el alumnado será capaz de implementar mecanismos básicos de seguridad en una aplicación web real.

---

# Bloque 4. Desplegar aplicaciones de forma segura

## Pregunta guía

¿Cómo ponemos una aplicación en producción manteniendo la seguridad?

## Objetivo

Aplicar configuraciones y buenas prácticas durante el despliegue de una aplicación web.

El alumnado comprende que una aplicación correctamente programada puede seguir siendo insegura si el entorno donde se ejecuta no está configurado correctamente.

## Contenidos

- Configuración segura del servidor.
- HTTPS.
- Certificados digitales.
- Variables de entorno.
- Gestión de secretos.
- Permisos del sistema.
- Configuración segura de bases de datos.
- Cabeceras HTTP de seguridad.
- Despliegue seguro.
- Docker.
- AWS Academy.

## Resultado esperado

Al finalizar el bloque, el alumnado será capaz de:

- preparar un entorno de ejecución seguro;
- configurar correctamente una aplicación web;
- identificar riesgos asociados al despliegue;
- aplicar medidas básicas de protección en producción.

---

# Bloque 5. Verificar y mejorar continuamente

## Pregunta guía

¿Cómo comprobamos que una aplicación sigue siendo segura?

## Objetivo

Aprender a revisar una aplicación desarrollada, detectar posibles problemas y documentar mejoras.

La seguridad se entiende como un proceso continuo de revisión y mejora.

## Contenidos

### Revisiones de seguridad

- Revisión manual de aplicaciones.
- Checklist de seguridad.
- Revisión de requisitos.
- Análisis de decisiones tomadas durante el desarrollo.

### Pruebas de seguridad

- Pruebas funcionales.
- Pruebas negativas.
- Validación de entradas incorrectas.
- Comprobación de permisos.

### Herramientas de análisis

- Burp Suite.
- OWASP ZAP.
- DevTools.
- Herramientas de revisión de cabeceras.

### Análisis de dependencias

- Composer Audit.
- npm Audit.

### Documentación

- Informes técnicos.
- Evidencias de seguridad.
- Propuestas de mejora.

## Resultado esperado

Al finalizar el bloque, el alumnado será capaz de:

- revisar una aplicación desde el punto de vista de seguridad;
- identificar posibles problemas;
- documentar las comprobaciones realizadas;
- proponer mejoras.

---

# 8. Integración con los retos del ciclo

El módulo se integra directamente con los retos desarrollados durante segundo curso de DAW.

La seguridad no aparece como una fase independiente del proyecto, sino como un criterio transversal que debe aplicarse durante todo el desarrollo.

Cada equipo debe incorporar las decisiones de seguridad aprendidas en su propia aplicación.

---

# 8.1 Aplicación en el Reto 1

## Tecnologías

- PHP.
- JavaScript Vanilla.
- CSS.
- AWS.

## Aplicación de contenidos de seguridad

Durante el desarrollo del reto se aplicarán conceptos relacionados con:

- validación de entradas;
- gestión de formularios;
- sesiones;
- autenticación;
- autorización;
- protección de información;
- configuración segura del despliegue.

---

# 8.2 Aplicación en el Reto 2

## Tecnologías

- Laravel.
- Vue.
- Tailwind.

## Aplicación de contenidos de seguridad

Durante el desarrollo del reto se aplicarán conceptos relacionados con:

- autenticación mediante framework;
- middleware;
- autorización;
- APIs;
- gestión de secretos;
- configuración del entorno;
- despliegue seguro.

---

# 8.3 Seguridad dentro de Scrum

La seguridad debe formar parte de la planificación del proyecto.

Los equipos deberán considerar aspectos de seguridad durante:

- definición de historias de usuario;
- planificación de tareas;
- desarrollo de funcionalidades;
- revisiones de sprint;
- entrega final.

Ejemplo:

Historia de usuario:

> Como alumno quiero consultar mis datos personales.

Aspectos de seguridad asociados:

- solo el usuario propietario puede acceder;
- los datos deben validarse;
- la información sensible no debe exponerse innecesariamente.

---

# 9. Organización de materiales didácticos

El material del módulo se organiza mediante documentación estructurada utilizando MkDocs.

La documentación se desarrolla en dos idiomas:

- Español.
- Euskera.

El objetivo es disponer de un material completo que pueda utilizarse tanto en el aula como en situaciones de aprendizaje autónomo.

---

# 9.1 Estructura general de los bloques

Todos los bloques siguen una estructura común para facilitar la navegación y el aprendizaje progresivo.

Cada bloque incluye:

- Introducción.
- Objetivos de aprendizaje.
- Contenidos teóricos.
- Ejemplos aplicados.
- Recursos visuales.
- Actividades prácticas.
- Propuestas de ampliación.
- Aplicación al reto.

Esta estructura permite que el alumnado avance desde la comprensión de conceptos hasta su aplicación en un proyecto real.

---

# 9.2 Documentación bilingüe

Todo el material se mantiene en dos versiones:

- Castellano.
- Euskera.

La organización del repositorio mantiene ambas versiones sincronizadas.

La estructura general es:

- `docs/es/`
- `docs/eu/`

Cada bloque dispone de su correspondiente versión en ambos idiomas.

---

# 9.3 Recursos visuales

Los recursos gráficos se incorporan únicamente cuando aportan un valor didáctico añadido.

No se utilizan imágenes como elemento decorativo.

Se crean especialmente para:

- representar arquitecturas;
- explicar procesos;
- visualizar relaciones entre conceptos;
- facilitar la comprensión de ideas abstractas.

Cuando un diagrama técnico sencillo es suficiente, se utiliza Mermaid.

El criterio general es:

> Utilizar una imagen cuando ayude a comprender mejor una idea que sería más difícil de asimilar únicamente mediante texto.

---

# 9.4 Actividades prácticas

Las actividades están diseñadas para que el alumnado pueda trabajar de forma autónoma.

Cada actividad incluye:

- objetivos;
- contexto;
- material necesario;
- explicación paso a paso;
- comprobación de conocimientos;
- aplicación práctica;
- relación con el reto;
- propuestas de ampliación.

---

## Criterios de diseño de actividades

Las actividades deben:

- estar suficientemente explicadas para permitir trabajo autónomo;
- evitar dependencias de explicaciones adicionales del profesor;
- permitir trabajo presencial y asíncrono;
- relacionar teoría y práctica;
- conectar con el desarrollo de aplicaciones reales.

---

# 10. Evaluación y evidencias de aprendizaje

La evaluación del módulo se centra en la capacidad del alumnado para aplicar criterios de seguridad durante el desarrollo de aplicaciones web.

No se evalúa únicamente la adquisición de conceptos teóricos.

Se valoran especialmente:

- la capacidad de análisis;
- la toma de decisiones;
- la aplicación práctica;
- la documentación realizada;
- la justificación de las medidas adoptadas.

---

# 10.1 Evidencias de aprendizaje

Las evidencias pueden incluir:

- análisis de aplicaciones;
- documentación técnica;
- decisiones de diseño;
- código desarrollado;
- configuraciones realizadas;
- revisiones de seguridad;
- informes técnicos;
- aplicación de medidas durante los retos.

---

# 10.2 Evaluación orientada al entorno profesional

El alumnado debe ser capaz de justificar decisiones como:

- qué información debe protegerse;
- quién puede acceder a cada recurso;
- qué validaciones son necesarias;
- cómo se gestionan los errores;
- cómo se configura un entorno seguro;
- cómo se comprueba que una aplicación cumple unos requisitos básicos de seguridad.

---

# 11. Estado actual del proyecto

## Diseño general del módulo

Estado:

✅ Finalizado

Incluye:

- estructura general del módulo;
- enfoque metodológico;
- organización por bloques;
- relación con los retos;
- caso de estudio TxurdiGest.

---

## Bloque 1. Comprender

Estado:

✅ Finalizado

Incluye:

- contenidos teóricos;
- recursos visuales;
- actividades;
- versión bilingüe.

Objetivo alcanzado:

El alumnado comprende el funcionamiento de una aplicación web y los elementos relacionados con seguridad.

---

## Bloque 2. Diseñar

Estado:

🟢 En desarrollo avanzado

Realizado:

- estructura del bloque;
- contenidos teóricos;
- recursos gráficos;
- organización conceptual.

Pendiente:

- actividades prácticas;
- integración definitiva en MkDocs;
- revisión final bilingüe.

Objetivo:

Que el alumnado aprenda a tomar decisiones de seguridad antes de programar.

---

## Bloques 3, 4 y 5

Estado:

⏳ Pendiente de desarrollo.

Planificados:

- implementación segura;
- despliegue seguro;
- verificación y mejora continua.

---

# 12. Próximos pasos

El desarrollo del módulo seguirá una evolución progresiva.

## Fase 1. Finalización del Bloque 2

Pendiente:

- completar las actividades prácticas;
- integrar las actividades en MkDocs;
- revisar la versión bilingüe;
- validar la conexión entre teoría, actividades y reto.

Objetivo:

Disponer de un bloque completo donde el alumnado aprenda a diseñar aplicaciones web incorporando criterios de seguridad antes de programar.

---

## Fase 2. Desarrollo del Bloque 3

Pendiente:

- creación de contenidos teóricos;
- diseño de ejemplos prácticos;
- preparación de actividades;
- aplicación sobre las tecnologías utilizadas en DAW.

Tecnologías principales:

- PHP.
- JavaScript.
- Laravel.
- Vue.

Objetivo:

Que el alumnado sea capaz de implementar mecanismos de seguridad dentro del código de una aplicación real.

---

## Fase 3. Desarrollo del Bloque 4

Pendiente:

- contenidos relacionados con despliegue seguro;
- configuración de servidores;
- HTTPS;
- gestión de secretos;
- entornos de producción;
- integración con AWS Academy.

Objetivo:

Que el alumnado comprenda que la seguridad también depende del entorno donde se ejecuta una aplicación.

---

## Fase 4. Desarrollo del Bloque 5

Pendiente:

- diseño de actividades de revisión;
- creación de checklists;
- preparación de evidencias;
- integración de herramientas de verificación.

Objetivo:

Que el alumnado sea capaz de revisar una aplicación desarrollada y justificar las medidas de seguridad aplicadas.

---

# 13. Visión final del módulo

El objetivo final del módulo es cambiar la visión tradicional de la seguridad en el desarrollo web.

La seguridad no debe entenderse como una tarea añadida después de programar.

Debe formar parte de todas las decisiones del desarrollo:

- comprender la aplicación;
- diseñar correctamente;
- implementar mecanismos seguros;
- desplegar adecuadamente;
- verificar y mejorar continuamente.

El aprendizaje completo del módulo se resume en:

**Una aplicación segura se comprende, se diseña, se implementa, se despliega y se verifica.**

Al finalizar el módulo, el alumnado debe ser capaz de aplicar criterios básicos de desarrollo web seguro en sus propios proyectos y trasladarlos a un entorno profesional de desarrollo de software.