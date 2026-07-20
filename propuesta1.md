# Propuesta de estructura para el módulo "Desarrollo Web Seguro"

## 1. Objetivo del proyecto

Diseñar la estructura completa de unos apuntes bilingües para el módulo optativo "Desarrollo Web Seguro" del CFGS de Desarrollo de Aplicaciones Web.

El proyecto está pensado para publicarse con MkDocs Material y GitHub Pages, y debe mantenerse durante varios cursos sin depender de un proyecto aislado de seguridad.

## 2. Principios de diseño

- El contenido no se organiza por vulnerabilidades, sino por el trabajo real de un desarrollador web.
- La seguridad se integra en el flujo natural de desarrollo: comprender, analizar, corregir, aplicar y verificar.
- DVWA se usa como laboratorio principal para analizar y corregir código vulnerable.
- Burp Suite actúa como herramienta transversal desde el inicio del curso.
- Las herramientas adicionales aparecen solo cuando aportan valor al desarrollo seguro.
- Cada capítulo debe responder siempre a la pregunta: "¿Cómo puedo desarrollar una aplicación más segura?"
- No se trata de pentesting ni de auditoría ofensiva.

## 3. Contexto didáctico

El módulo debe encajar con el trabajo simultáneo del alumnado en:

- Desarrollo Web en Entorno Servidor.
- Desarrollo Web en Entorno Cliente.
- Diseño de Interfaces Web.
- Sistemas Informáticos.
- Despliegue de Aplicaciones Web.

Tecnologías habituales del ciclo:

- PHP.
- MySQL / MariaDB.
- Apache.
- JavaScript.
- Laravel.
- Vue 3.
- Tailwind CSS.
- Git y GitHub.
- Docker.
- AWS Academy.

## 4. Metodología propuesta

La secuencia de trabajo del módulo debe seguir este flujo:

1. Comprender una aplicación web.
2. Analizar cómo funciona.
3. Detectar una vulnerabilidad.
4. Comprender el código vulnerable.
5. Corregir el código.
6. Aplicar la mejora al proyecto ETHAZI.
7. Desplegar correctamente.
8. Auditar la aplicación.

La metodología ETHAZI se integra en dos retos principales:

- Primer reto: PHP, JavaScript Vanilla, CSS y despliegue en AWS.
- Segundo reto: Laravel, Vue 3, Tailwind y despliegue en AWS.

## 5. Papel de las herramientas

### Herramientas transversales

- Burp Suite.
- DevTools del navegador.
- Git.
- GitHub.

### Herramientas de verificación

- OWASP ZAP.
- Security Headers.
- SSL Labs.

### Auditoría de dependencias

- Composer Audit.
- npm Audit.

### Despliegue

- Docker.
- Apache.
- AWS.

## 6. Criterio pedagógico

Cada capítulo, práctica o ejemplo debe superar este filtro:

> ¿Ayuda realmente a un desarrollador de DAW a crear aplicaciones web más seguras?

Si la respuesta es no, no debe incluirse.

## 7. Estructura común obligatoria de todos los capítulos

Todos los capítulos deben seguir exactamente la misma estructura:

1. Introducción.
2. Objetivos.
3. Conceptos previos.
4. Situación real.
5. Explicación.
6. Código vulnerable.
7. Laboratorio guiado.
8. Análisis del código.
9. Corrección.
10. Aplicación al reto ETHAZI.
11. Resumen.
12. Ejercicios.
13. Para saber más.

## 8. Organización didáctica general

La propuesta de organización del curso es la siguiente:

- Bloque 0. Presentación y guía del módulo.
- Bloque 1. Fundamentos de seguridad web.
- Bloque 2. Comprensión y análisis de una aplicación.
- Bloque 3. Entrada y salida de datos seguras.
- Bloque 4. Formularios, validación y protección frente a CSRF.
- Bloque 5. Base de datos y persistencia segura.
- Bloque 6. Autenticación, sesiones y autorización.
- Bloque 7. Despliegue seguro.
- Bloque 8. Auditoría y verificación.
- Bloque 9. Integración con Laravel.
- Bloque 10. Anexos y recursos reutilizables.

## 9. Propuesta de estructura de contenidos

### 9.1. Presentación

- Qué es el módulo.
- Cómo usar los apuntes.
- Relación con los dos retos ETHAZI.
- Dinámica de trabajo.
- Criterios generales de seguridad.

### 9.2. Fundamentos

- Qué protege una aplicación web.
- Superficie de ataque.
- Flujo HTTP.
- Cookies y sesiones.
- Formularios y peticiones.
- OWASP Top 10 como referencia, no como índice del curso.

### 9.3. Análisis de una aplicación

- Leer peticiones y respuestas.
- Analizar parámetros.
- Inspeccionar cookies.
- Revisar autenticación.
- Usar Burp Suite y DevTools.

### 9.4. Entrada y salida de datos

- Validación.
- Codificación de salida.
- XSS.
- Manejo de errores.
- Puntos vulnerables en frontend y backend.

### 9.5. Formularios y protección de estado

- CSRF.
- Tokens.
- Flujo de formularios.
- Errores frecuentes en aplicaciones reales.

### 9.6. Base de datos y persistencia

- SQL Injection.
- Prepared Statements.
- ORM y consultas seguras.
- Acceso a datos.
- Gestión de credenciales.

### 9.7. Autenticación, sesiones y autorización

- Contraseñas.
- Sesiones.
- Cookies.
- Roles.
- Permisos.
- IDOR.

### 9.8. Despliegue seguro

- HTTPS.
- Certificados.
- Let's Encrypt.
- Variables de entorno.
- Archivo .env.
- Gestión de secretos.
- Apache.
- Permisos.
- Firewall.
- Base de datos no expuesta.
- Cabeceras HTTP.
- Dependencias.
- Auditoría de paquetes.
- AWS.

### 9.9. Auditoría y verificación

- OWASP ZAP.
- Composer Audit.
- npm Audit.
- Security Headers.
- SSL Labs.
- Comprobación de la corrección.

### 9.10. Integración con Laravel

- Validación.
- Middleware.
- CSRF.
- Eloquent.
- Policies.
- Variables de entorno.
- Gestión de secretos.
- Cómo Laravel reduce vulnerabilidades comunes.

## 10. Papel de DVWA

DVWA se propone como laboratorio principal porque permite:

- analizar código vulnerable;
- comprender el error;
- modificar el código PHP;
- eliminar la vulnerabilidad;
- verificar que deja de existir.

El laboratorio no debe quedarse en ejecutar ataques. La prioridad es entender y corregir el código.

## 11. Estilo de los apuntes

La documentación debe ser técnica, clara y breve.

Debe priorizar:

- diagramas Mermaid;
- tablas;
- esquemas;
- fragmentos pequeños de código;
- diffs;
- checklists;
- ejemplos reales.

Debe evitar:

- bloques largos de texto;
- tono académico;
- enfoque de pentesting;
- capítulos demasiado extensos.

El objetivo es que cada página pueda estudiarse en unos 15 a 20 minutos.

## 12. Estructura del repositorio

La documentación debe estar preparada para mantenimiento a largo plazo y debe incluir:

- documentación;
- laboratorios;
- diagramas;
- checklists;
- snippets reutilizables;
- scripts;
- recursos;
- anexos.

## 13. Propuesta de árbol de carpetas y archivos

### Español

```text
docs/es/
├─ index.md
├─ 0.presentacion/
│  ├─ index.md
│  ├─ 0.1.que-es-el-modulo.md
│  ├─ 0.2.como-usar-los-apuntes.md
│  ├─ 0.3.relacion-con-ethazi.md
│  └─ 0.4.metodologia-del-modulo.md
├─ 1.fundamentos/
│  ├─ index.md
│  ├─ 1.1.que-protege-una-aplicacion-web.md
│  ├─ 1.2.superficie-de-ataque.md
│  ├─ 1.3.http-cookies-y-sesiones.md
│  ├─ 1.4.formularios-y-peticiones.md
│  └─ 1.5.owasp-top-10-como-referencia.md
├─ 2.analisis-aplicacion/
│  ├─ index.md
│  ├─ 2.1.leer-peticiones-y-respuestas.md
│  ├─ 2.2.parametros-cookies-y-estado.md
│  ├─ 2.3.devtools.md
│  └─ 2.4.burp-suite.md
├─ 3.entrada-salida-datos/
│  ├─ index.md
│  ├─ 3.1.validacion.md
│  ├─ 3.2.codificacion-de-salida.md
│  ├─ 3.3.xss.md
│  └─ 3.4.manejo-de-errores.md
├─ 4.formularios-csrf/
│  ├─ index.md
│  ├─ 4.1.formularios-seguros.md
│  ├─ 4.2.tokens-y-estado.md
│  ├─ 4.3.csrf.md
│  └─ 4.4.flujos-de-validacion.md
├─ 5.base-datos/
│  ├─ index.md
│  ├─ 5.1.consultas-seguras.md
│  ├─ 5.2.sql-injection.md
│  ├─ 5.3.prepared-statements.md
│  ├─ 5.4.orm-y-acceso-a-datos.md
│  └─ 5.5.credenciales-y-conexion.md
├─ 6.autenticacion-autorizacion/
│  ├─ index.md
│  ├─ 6.1.contraseñas.md
│  ├─ 6.2.sesiones.md
│  ├─ 6.3.cookies.md
│  ├─ 6.4.roles-y-permisos.md
│  └─ 6.5.idor.md
├─ 7.despliegue-seguro/
│  ├─ index.md
│  ├─ 7.1.https-y-certificados.md
│  ├─ 7.2.letsencrypt.md
│  ├─ 7.3.variables-de-entorno-y-env.md
│  ├─ 7.4.gestion-de-secretos.md
│  ├─ 7.5.apache-permisos-y-firewall.md
│  ├─ 7.6.base-de-datos-no-expuesta.md
│  ├─ 7.7.cabeceras-http.md
│  └─ 7.8.aws.md
├─ 8.auditoria-verificacion/
│  ├─ index.md
│  ├─ 8.1.owasp-zap.md
│  ├─ 8.2.composer-audit.md
│  ├─ 8.3.npm-audit.md
│  ├─ 8.4.security-headers.md
│  ├─ 8.5.ssl-labs.md
│  └─ 8.6.verificacion-de-correcciones.md
├─ 9.laravel/
│  ├─ index.md
│  ├─ 9.1.validacion.md
│  ├─ 9.2.middleware.md
│  ├─ 9.3.csrf.md
│  ├─ 9.4.eloquent.md
│  ├─ 9.5.policies.md
│  └─ 9.6.entornos-y-secretos.md
├─ 10.recursos/
│  ├─ index.md
│  ├─ 10.1.bibliografia.md
│  ├─ 10.2.enlaces.md
│  ├─ 10.3.snippets.md
│  ├─ 10.4.scripts.md
│  └─ 10.5.checklists.md
└─ 11.anexos/
   ├─ index.md
   ├─ 11.1.glosario.md
   ├─ 11.2.rubricas.md
   ├─ 11.3.solucionario.md
   └─ 11.4.plantillas.md
```

### Euskera

```text
docs/eu/
├─ index.md
├─ 0.sarrera/
│  ├─ index.md
│  ├─ 0.1.zer-da-modulua.md
│  ├─ 0.2.nola-erabili-oharrak.md
│  ├─ 0.3.ethazirekin-harremana.md
│  └─ 0.4.moduluaren-metodologia.md
├─ 1.oinarriak/
│  ├─ index.md
│  ├─ 1.1.web-aplikazio-batek-zer-babesten-du.md
│  ├─ 1.2.eraso-azalera.md
│  ├─ 1.3.http-cookieak-eta-saioak.md
│  ├─ 1.4.formularioak-eta-eskariak.md
│  └─ 1.5.owasp-top-10-erreferentzia-gisa.md
├─ 2.aplikazioaren-analisi/
│  ├─ index.md
│  ├─ 2.1.eskariak-eta-erantzunak-irakurtzea.md
│  ├─ 2.2.parametroak-cookieak-eta-egoera.md
│  ├─ 2.3.devtools.md
│  └─ 2.4.burp-suite.md
├─ 3.datuen-sarrera-irteera/
│  ├─ index.md
│  ├─ 3.1.balioztatzea.md
│  ├─ 3.2.irteeraren-kodifikazioa.md
│  ├─ 3.3.xss.md
│  └─ 3.4.akatsen-kudeaketa.md
├─ 4.formularioak-csrf/
│  ├─ index.md
│  ├─ 4.1.formulario-seguruak.md
│  ├─ 4.2.tokenoak-eta-egoera.md
│  ├─ 4.3.csrf.md
│  └─ 4.4.balioztatze-fluxuak.md
├─ 5.datu-basea/
│  ├─ index.md
│  ├─ 5.1.kontsulta-seguruak.md
│  ├─ 5.2.sql-injection.md
│  ├─ 5.3.prepared-statements.md
│  ├─ 5.4.orma-eta-datuetarako-sarbidea.md
│  └─ 5.5.kredentzialak-eta-konexioa.md
├─ 6.autentifikazioa-baimena/
│  ├─ index.md
│  ├─ 6.1.pasahitzak.md
│  ├─ 6.2.saioak.md
│  ├─ 6.3.cookieak.md
│  ├─ 6.4.rolak-eta-baimenak.md
│  └─ 6.5.idor.md
├─ 7.despliegua-segurtasunez/
│  ├─ index.md
│  ├─ 7.1.https-eta-ziurtagiriak.md
│  ├─ 7.2.letsencrypt.md
│  ├─ 7.3.inguruneko-aldagaiak-eta-env.md
│  ├─ 7.4.sekretuen-kudeaketa.md
│  ├─ 7.5.apache-baimenak-eta-firewall.md
│  ├─ 7.6.datu-basea-esposatu-gabe.md
│  ├─ 7.7.http-goiburuak.md
│  └─ 7.8.aws.md
├─ 8.auditoretza-eta-egiaztapena/
│  ├─ index.md
│  ├─ 8.1.owasp-zap.md
│  ├─ 8.2.composer-audit.md
│  ├─ 8.3.npm-audit.md
│  ├─ 8.4.security-headers.md
│  ├─ 8.5.ssl-labs.md
│  └─ 8.6.konponketen-egiaztapena.md
├─ 9.laravel/
│  ├─ index.md
│  ├─ 9.1.balioztatzea.md
│  ├─ 9.2.middlewarea.md
│  ├─ 9.3.csrf.md
│  ├─ 9.4.eloquent.md
│  ├─ 9.5.policies.md
│  └─ 9.6.inguruneak-eta-sekretuak.md
├─ 10.baliabideak/
│  ├─ index.md
│  ├─ 10.1.bibliografia.md
│  ├─ 10.2.estekak.md
│  ├─ 10.3.snippets.md
│  ├─ 10.4.scriptak.md
│  └─ 10.5.checklistak.md
└─ 11.eranskinak/
   ├─ index.md
   ├─ 11.1.glosategia.md
   ├─ 11.2.errubrikak.md
   ├─ 11.3.soluzio-liburua.md
   └─ 11.4.txantiloiak.md
```

## 14. Estructura fija recomendada para cada página

Cada página individual debería seguir este patrón:

- Introducción.
- Objetivos.
- Conceptos previos.
- Situación real.
- Explicación.
- Código vulnerable.
- Laboratorio guiado.
- Análisis del código.
- Corrección.
- Aplicación al reto ETHAZI.
- Resumen.
- Ejercicios.
- Para saber más.

## 15. Recomendación final

La propuesta más sólida para este proyecto es construir un itinerario docente por bloques funcionales del desarrollo web, no por vulnerabilidades aisladas.

Eso permite:

- integrar seguridad en el día a día del alumnado;
- reutilizar DVWA como laboratorio base;
- encajar la docencia con los dos retos ETHAZI;
- mantener la documentación muchos cursos;
- añadir recursos, checklists, scripts y anexos sin romper la estructura.

## 16. Ajuste a la carga real del módulo

Este módulo es optativo y tiene una carga aproximada de 42 horas repartidas en 21 semanas.

La temporización debe respetar dos ritmos distintos:

- Evaluación 1: 11 semanas.
- Evaluación 2: 10 u 11 semanas.

La distribución recomendada por evaluación es la siguiente:

- 5 o 6 semanas para clases teóricas y prácticas guiadas.
- El resto de semanas para el desarrollo del reto.

Durante el desarrollo del reto pueden hacerse microintervenciones teóricas, pero no deben ocupar toda la sesión.

### Implicación didáctica

La estructura de contenidos debe ser modular y compacta. Cada tema debe poder dividirse en:

- una base teórica corta;
- una práctica guiada;
- una aplicación directa al reto;
- una verificación final.

## 17. Transición entre reto 1 y reto 2

### Reto 1

DVWA encaja muy bien en el primer reto, porque el alumnado trabaja con:

- PHP;
- JavaScript Vanilla;
- CSS;
- despliegue en AWS.

### Reto 2

Para Laravel y Vue 3, DVWA se queda corto.

En ese bloque conviene preparar:

- repositorios propios pequeños;
- controladores vulnerables;
- componentes Vue vulnerables;
- snippets específicos para refactorizar.

### Criterio de uso

La transición debe ser natural:

- primero se aprende la vulnerabilidad en un entorno controlado;
- después se traslada a un proyecto más realista;
- finalmente se corrige dentro del flujo de desarrollo del alumnado.

## 18. Mantenimiento bilingüe y recursos compartidos

Mantener dos árboles profundos separados de forma manual puede ser difícil a largo plazo.

La estrategia recomendada es esta:

- usar al máximo el plugin `mkdocs-static-i18n`;
- evitar duplicar esquemas técnicos, diagramas y snippets;
- centralizar recursos reutilizables en carpetas neutras del repositorio;
- dejar en `docs/es` y `docs/eu` solo la navegación y el contenido lingüístico.

### Recursos neutros recomendados

- snippets reutilizables;
- diagramas Mermaid;
- checklists;
- scripts;
- plantillas;
- laboratorios base para reto 1 y reto 2.

### Consecuencia práctica

La documentación bilingüe debe diseñarse desde el principio para que el mantenimiento sea incremental y no manualmente duplicado.
