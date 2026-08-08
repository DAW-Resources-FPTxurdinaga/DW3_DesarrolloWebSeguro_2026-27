# Despliegue seguro

Una aplicación web no deja de ser segura cuando termina su desarrollo.

El paso a producción introduce nuevas decisiones que pueden afectar directamente a la seguridad:

- configuración del entorno;
- gestión de secretos;
- exposición de servicios;
- certificados y comunicaciones;
- permisos del sistema;
- acceso a bases de datos;
- registro de actividad;
- configuración del servidor.

Una aplicación correctamente programada puede quedar expuesta si el entorno donde se ejecuta no está configurado adecuadamente.

## Seguridad durante todo el ciclo de vida

La seguridad no termina en la implementación.

El despliegue forma parte del ciclo de vida de una aplicación:

```text
Análisis
   ↓
Diseño seguro
   ↓
Implementación segura
   ↓
Pruebas
   ↓
Despliegue seguro
   ↓
Mantenimiento
```

Cada fase introduce decisiones que pueden reducir o aumentar el riesgo.

## Desarrollo frente a producción

Durante el desarrollo es habitual utilizar configuraciones pensadas para facilitar el trabajo:

- mensajes de error detallados;
- herramientas de depuración;
- credenciales locales;
- servicios auxiliares;
- configuraciones temporales.

Estas opciones no deben trasladarse directamente al entorno de producción.

El entorno real debe priorizar:

- disponibilidad;
- confidencialidad;
- integridad;
- control de acceso;
- trazabilidad.

## El papel del desarrollador web

El despliegue seguro no corresponde únicamente al administrador de sistemas.

El desarrollador debe conocer cómo sus decisiones afectan al entorno:

- dónde se almacenan los secretos;
- qué servicios necesita la aplicación;
- qué permisos requiere;
- qué información se muestra al usuario;
- cómo se registran los errores;
- cómo se comunica la aplicación con otros servicios.

El objetivo no es administrar toda la infraestructura, sino desarrollar aplicaciones que puedan desplegarse de forma segura.

## Relación con los retos DAW

Los proyectos desarrollados durante el curso deben aplicar estas decisiones en un entorno real.

Por ejemplo:

```text
Aplicación desarrollada
        ↓
Configuración de producción
        ↓
Servidor web
        ↓
Base de datos
        ↓
Usuarios finales
```

Durante el despliegue se revisará que:

- la aplicación utilice HTTPS;
- los secretos no estén incluidos en el código;
- la base de datos no esté expuesta innecesariamente;
- los permisos sean adecuados;
- los errores no revelen información interna;
- el servidor exponga únicamente lo necesario.

## Relación con SINF

El despliegue seguro requiere colaboración entre desarrollo e infraestructura.

En este módulo se trabajará desde la perspectiva del desarrollo web:

- qué necesita una aplicación;
- qué configuración espera;
- qué riesgos aparecen si se despliega incorrectamente.

Los aspectos relacionados con administración avanzada del sistema operativo, redes o servicios se trabajan en otros módulos.

## Enfoque del bloque

Durante este bloque se trabajarán:

- configuración diferenciada entre entornos;
- HTTPS y certificados;
- gestión segura de secretos;
- superficie de exposición del servidor;
- permisos de archivos;
- protección de la base de datos;
- cabeceras de seguridad;
- gestión de errores y registros.

El objetivo es comprender que una aplicación segura necesita también un entorno seguro.

## Idea clave

> Una aplicación segura no depende únicamente de su código. También depende de cómo se configura, se publica y se mantiene.
