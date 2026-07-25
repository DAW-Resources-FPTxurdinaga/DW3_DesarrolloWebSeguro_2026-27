# TxurdiGest: el caso de estudio del manual

## Introducción

A lo largo de este manual utilizaremos una misma aplicación como hilo conductor para ilustrar los conceptos, ejemplos y buenas prácticas relacionados con el desarrollo web seguro.

Esta aplicación recibe el nombre de **TxurdiGest** y representa un sistema de gestión integral para un centro educativo de Formación Profesional.

El objetivo no es desarrollar una aplicación completa desde cero, sino disponer de un escenario común que permita contextualizar todos los ejemplos del libro. De esta forma, el lector podrá centrarse en comprender los aspectos relacionados con la seguridad sin tener que adaptarse continuamente a aplicaciones diferentes.

---

## ¿Qué es TxurdiGest?

**TxurdiGest** es una aplicación web destinada a facilitar la gestión diaria de un centro educativo.

Desde una única plataforma es posible administrar la información académica, gestionar usuarios, consultar horarios, registrar calificaciones y realizar numerosas tareas administrativas.

Como cualquier aplicación web moderna, TxurdiGest almacena información sensible y es utilizada por diferentes tipos de usuarios, por lo que la seguridad constituye uno de sus requisitos fundamentales.

---

## Objetivos de la aplicación

TxurdiGest permite gestionar, entre otros, los siguientes procesos:

- Gestión del alumnado.
- Gestión del profesorado.
- Gestión del personal administrativo.
- Gestión de ciclos formativos y módulos.
- Matrículas.
- Horarios.
- Calificaciones.
- Entrega de tareas.
- Comunicación entre profesorado y alumnado.
- Consulta de documentación académica.

Aunque el sistema dispone de muchas funcionalidades, en este manual únicamente utilizaremos aquellas que resulten necesarias para explicar los distintos conceptos de seguridad.

---

## Usuarios del sistema

TxurdiGest dispone de diferentes perfiles de usuario, cada uno con permisos específicos.

| Perfil | Funciones principales |
|---------|----------------------|
| Administrador | Configura el sistema y administra todos los recursos. |
| Profesor | Gestiona grupos, actividades y calificaciones. |
| Alumno | Consulta información académica y entrega tareas. |
| Personal administrativo | Gestiona matrículas, expedientes y documentación. |

Esta separación de responsabilidades permitirá estudiar conceptos como la autenticación, la autorización y el control de acceso.

---

## Información gestionada

La aplicación almacena información muy diversa.

Entre otros datos, podemos encontrar:

- Datos personales.
- Direcciones de correo electrónico.
- Contraseñas.
- Matrículas.
- Expedientes académicos.
- Calificaciones.
- Horarios.
- Documentación administrativa.
- Archivos enviados por el alumnado.

Toda esta información debe protegerse adecuadamente para garantizar la confidencialidad, la integridad y la disponibilidad de los datos.

---

## ¿Por qué utilizar un único caso de estudio?

Muchos libros técnicos utilizan un mismo proyecto durante toda la obra.

Esta metodología presenta numerosas ventajas:

- Facilita la comprensión de los ejemplos.
- Evita repetir el contexto en cada capítulo.
- Permite observar cómo evolucionan los distintos componentes de una misma aplicación.
- Ayuda a relacionar conceptos aparentemente independientes.
- Aproxima el aprendizaje a un entorno profesional.

En este manual, todos los ejemplos estarán relacionados con TxurdiGest.

---

## TxurdiGest y la seguridad

Desde el punto de vista de la seguridad, TxurdiGest servirá para mostrar cómo debe desarrollarse una aplicación web siguiendo las buenas prácticas actuales.

A medida que avancemos en el manual veremos cómo proteger aspectos como:

- Validación de entradas.
- Gestión de errores.
- Autenticación.
- Autorización.
- Gestión de sesiones.
- Protección frente a ataques habituales.
- Desarrollo seguro de APIs.
- Configuración segura del servidor.

El objetivo será comprender no solo **qué mecanismos existen**, sino también **por qué son necesarios** y **cómo deben implementarse**.

---

## Relación con DVWA

En los primeros bloques del manual utilizaremos exclusivamente **TxurdiGest**.

Más adelante aparecerá **DVWA (Damn Vulnerable Web Application)**, una aplicación diseñada específicamente para estudiar vulnerabilidades.

Ambas aplicaciones cumplen funciones diferentes y complementarias:

| Aplicación | Finalidad |
|------------|-----------|
| **TxurdiGest** | Aprender a desarrollar aplicaciones seguras siguiendo las buenas prácticas. |
| **DVWA** | Analizar vulnerabilidades reales y comprender cómo pueden explotarse cuando una aplicación no se desarrolla correctamente. |

Esta combinación permitirá comparar continuamente un desarrollo seguro con otro deliberadamente vulnerable.

---

## Tecnologías utilizadas

Cuando sea necesario mostrar ejemplos prácticos, TxurdiGest utilizará un conjunto de tecnologías ampliamente empleadas en el desarrollo web moderno.

A lo largo del manual aparecerán ejemplos basados principalmente en:

- HTML5.
- CSS.
- JavaScript.
- PHP.
- Laravel.
- MySQL.
- HTTP y HTTPS.
- APIs REST.

No obstante, los conceptos de seguridad estudiados son independientes de estas tecnologías y pueden aplicarse a cualquier entorno de desarrollo.

---

## Ideas clave

- TxurdiGest será el caso de estudio utilizado durante todo el manual.
- Representa una aplicación web de gestión de un centro educativo.
- Todos los ejemplos compartirán el mismo contexto funcional.
- La aplicación permitirá estudiar el desarrollo seguro desde una perspectiva realista.
- Más adelante se complementará con DVWA para analizar vulnerabilidades y ataques.

---
