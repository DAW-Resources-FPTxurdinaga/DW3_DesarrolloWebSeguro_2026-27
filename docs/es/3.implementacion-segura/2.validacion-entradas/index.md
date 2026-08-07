# Validación de entradas

## Presentación

Las aplicaciones web reciben información continuamente desde formularios, direcciones URL, cookies, peticiones JavaScript, APIs y archivos enviados por los usuarios.

Todos esos datos proceden del exterior de la aplicación y pueden contener errores o haber sido modificados antes de llegar al servidor.

Por este motivo, ningún dato recibido debe utilizarse directamente sin comprobar primero que cumple las condiciones esperadas.

En este apartado aprenderás a implementar la validación de entradas utilizando **JavaScript** y **PHP**.

---

## Objetivos

Al finalizar este apartado serás capaz de:

- Identificar los principales puntos de entrada de una aplicación web.
- Comprender por qué todos los datos deben validarse.
- Implementar validaciones en JavaScript y PHP.
- Aplicar buenas prácticas durante el desarrollo de formularios.
- Detectar y corregir implementaciones inseguras.

---

## Contenidos

Este apartado se organiza en las siguientes páginas:

### Conceptos

Comprenderás qué significa validar, por qué es necesario hacerlo y cuáles son los principios básicos que deben aplicarse antes de procesar cualquier dato recibido.

### JavaScript

Aprenderás a implementar validaciones en el navegador para mejorar la experiencia del usuario y detectar errores antes de enviar la información al servidor.

### PHP

Implementarás las comprobaciones definitivas que protegerán la aplicación frente a datos incorrectos o manipulados.

### Buenas prácticas

Revisarás una serie de recomendaciones que te ayudarán a desarrollar formularios más robustos, mantenibles y seguros.

### Laboratorio de análisis

Analizarás una implementación vulnerable, localizarás sus problemas y propondrás una solución más segura.

---

## Cliente y servidor

Durante este apartado comprobarás que la validación debe realizarse tanto en el navegador como en el servidor.

Cada uno cumple una función diferente.

| Entorno | Función |
|----------|---------|
| **JavaScript** | Mejorar la experiencia del usuario detectando errores antes de enviar el formulario. |
| **PHP** | Validar definitivamente todos los datos antes de utilizarlos. |

!!! warning "Importante"

    La validación realizada en JavaScript nunca sustituye a la realizada en PHP.

    Todo dato recibido por el servidor debe volver a validarse antes de procesarse.

---

## Integración en TxurdiGest

Los conocimientos de este apartado podrán aplicarse en prácticamente todos los formularios de la aplicación.

Por ejemplo:

- alta y edición de alumnado;
- gestión de profesores;
- autenticación de usuarios;
- formularios de búsqueda;
- formularios de contacto;
- gestión de incidencias.

Antes de comenzar a programar, recupera las decisiones de diseño tomadas durante el Bloque 2 y conviértelas en reglas concretas de validación.

---

## Cómo estudiar este apartado

Se recomienda seguir el siguiente orden:

1. Conceptos.
2. Validación en JavaScript.
3. Validación en PHP.
4. Buenas prácticas.
5. Laboratorio de análisis.

Cada página incorpora ejemplos que podrás adaptar directamente a tu proyecto.

---

## Antes de continuar...

Recuerda una idea fundamental:

> **JavaScript ayuda al usuario. PHP protege la aplicación.**

Una aplicación segura siempre valida los datos en el servidor antes de utilizarlos.