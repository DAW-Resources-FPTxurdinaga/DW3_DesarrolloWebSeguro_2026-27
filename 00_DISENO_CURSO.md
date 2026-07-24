# DOCUMENTO DE DISEÑO DEL MÓDULO

## Desarrollo Web Seguro

**Versión:** 1.0  
**Estado:** Versión base 
**Ciclo:** CFGS Desarrollo de Aplicaciones Web (DAW)  
**Curso:** 2.º  
**Duración:** 42 horas (2 horas semanales)

---

# Finalidad del documento

Este documento constituye el diseño estructural del módulo **Desarrollo Web Seguro**.

Su finalidad es definir la organización definitiva de los contenidos antes de comenzar la redacción de los apuntes en MkDocs.

Este documento es la referencia para:

- generar la estructura de carpetas del proyecto;
- generar el archivo `mkdocs.yml`;
- planificar la secuencia temporal del curso;
- desarrollar posteriormente cada capítulo.

No contiene los apuntes, únicamente la organización del módulo.

---

# Decisiones de diseño

Durante el diseño del módulo se han adoptado las siguientes decisiones:

- El módulo está orientado al desarrollo web seguro, no al pentesting.
- La seguridad se integra en todo el ciclo de vida de una aplicación.
- Los contenidos siguen el flujo natural de desarrollo de una aplicación web.
- OWASP Top 10 se utiliza únicamente como marco de referencia.
- DVWA será el laboratorio principal.
- Burp Suite será la herramienta principal para comprender HTTP.
- OWASP ZAP se utilizará para auditoría.
- Docker será el entorno de laboratorio.
- AWS Academy será el entorno de despliegue.
- El módulo se integra completamente con los retos ETHAZI del segundo curso.
- Los contenidos se organizan por conceptos de desarrollo web seguro. Las tecnologías empleadas en el ciclo (PHP, JavaScript, Laravel, Vue u otras futuras) se presentan como implementaciones de dichos conceptos.

---

# Distribución temporal

| Bloque | Horas |
|---------|-------|
| 1. Fundamentos | 5 |
| 2. Preparación del laboratorio | 5 |
| 3. Desarrollo seguro | 13 |
| 4. Despliegue seguro | 7 |
| 5. Auditoría y mejora continua | 12 (integradas en hitos de ambos retos) |

Total: **42 horas**

---

# BLOQUE 1. Fundamentos del desarrollo web seguro

**Duración:** 5 horas

## Objetivo

Comprender cómo funciona una aplicación web e identificar dónde aparecen los principales riesgos de seguridad.

## Contenidos

- Introducción al desarrollo web seguro
- Arquitectura de una aplicación web
- Funcionamiento del protocolo HTTP
- Cookies, sesiones y gestión del estado
- HTTPS y certificados digitales
- DevTools
- Burp Suite como herramienta para comprender HTTP

## Relación con los retos

Base común para todo el curso.

---

# BLOQUE 2. Preparación del laboratorio

**Duración:** 5 horas

## Objetivo

Preparar el entorno de trabajo que se utilizará durante todo el módulo.

## Contenidos

- Docker como entorno de laboratorio
- Instalación y configuración de DVWA
- Configuración de Burp Suite
- Análisis completo de una petición HTTP
- OWASP Top 10 como referencia de contexto
- Evidencias técnicas para los retos ETHAZI

## Relación con los retos

Preparación previa al desarrollo del primer reto.

---

# BLOQUE 3. Desarrollo seguro de aplicaciones web

**Duración:** 13 horas

## Objetivo

Aprender a desarrollar funcionalidades habituales incorporando medidas de seguridad desde el inicio y adaptando esas decisiones tanto al stack del primer reto como al del segundo.

## 3.1 Formularios

- Implementación segura en PHP y JavaScript
- Validación en cliente
- Validación en servidor
- Salida segura de datos
- Cross-Site Scripting (XSS)
- Cross-Site Request Forgery (CSRF)
- Adaptación de validaciones y protección en Laravel y Vue

## 3.2 Acceso a datos

- Consultas SQL
- SQL Injection
- Prepared Statements
- PDO
- Introducción a los ORM
- Eloquent como capa de acceso a datos en Laravel

## 3.3 Autenticación y sesiones

- Gestión segura de contraseñas
- Hash de contraseñas
- Login
- Cookies
- Sesiones
- Implementación de autenticación en Laravel

## 3.4 Autorización

- Roles
- Permisos
- IDOR
- Principio de mínimo privilegio
- Policies y Gates en Laravel

## 3.5 Subida de archivos

- Validación de archivos
- Tipos MIME
- Extensiones
- Almacenamiento seguro
- Prevención de ejecución remota de código

## 3.6 APIs

- JSON
- CORS
- Tokens
- Validación
- Consumo seguro desde JavaScript
- Implementación en frameworks frontend

## Relación con los retos

Los contenidos se impartirán mediante microintervenciones durante el desarrollo de los retos.

En el primer reto se trabajarán sobre PHP y JavaScript Vanilla con despliegue en AWS.

En el segundo reto se trabajarán sobre Laravel y Vue, comparando cómo el framework incorpora y organiza muchas de estas medidas de seguridad.

---

# BLOQUE 4. Despliegue seguro

**Duración:** 7 horas

## Objetivo

Aplicar criterios de seguridad durante el despliegue y la operación de aplicaciones web.

## Contenidos

- Configuración segura del servidor web
- HTTPS en producción
- Variables de entorno
- Gestión de secretos
- Permisos de archivos
- Bases de datos no expuestas
- Cabeceras HTTP de seguridad
- Docker en producción
- Despliegue en AWS Academy

## Relación con los retos

Aplicación directa durante el despliegue de ambos retos.

En el primer reto se aplicará sobre un despliegue PHP y JavaScript Vanilla en AWS.

En el segundo reto se aplicará sobre un despliegue Laravel y Vue en AWS.

---

# BLOQUE 5. Auditoría y mejora continua

**Duración:** 12 horas distribuidas durante todo el curso

## Objetivo

Verificar la seguridad de la aplicación, documentar las incidencias encontradas y corregirlas antes de la entrega.

## Contenidos

- Burp Suite
- OWASP ZAP
- Security Headers
- SSL Labs
- Composer Audit
- npm Audit
- Trazabilidad de hallazgos
- Plan de remediación
- Informe técnico de auditoría
- Checklist previo al despliegue
- Hitos de revisión técnica del Reto 1
- Hitos de revisión técnica del Reto 2

## Relación con los retos

Este bloque no constituye una unidad independiente.

Las actividades de auditoría se realizarán de forma continua durante el desarrollo de ambos retos, con revisiones intermedias y una auditoría completa antes de cada entrega.

---

# Próximos pasos

Una vez aprobado este documento se procederá a:

1. Generar la estructura definitiva del proyecto MkDocs.
2. Generar el archivo `mkdocs.yml`.
3. Crear la estructura de carpetas y capítulos.
4. Comenzar la redacción de los apuntes.