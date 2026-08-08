# Actividad: Auditoría de despliegue seguro

## Contexto

La aplicación desarrollada durante el reto debe pasar de un entorno de desarrollo a un entorno preparado para usuarios reales.

El objetivo de esta actividad es revisar que el despliegue mantiene las decisiones de seguridad trabajadas durante el módulo.

No se trata únicamente de comprobar que la aplicación funciona, sino de verificar que está configurada de forma segura.

## Objetivo

Realizar una revisión del despliegue de la aplicación aplicando una lista de comprobación de seguridad.

El equipo debe identificar:

- configuraciones correctas;
- posibles riesgos;
- decisiones tomadas;
- evidencias que demuestren la revisión realizada.

## Fases de la actividad

```text
Revisar configuración

        ↓

Comprobar despliegue

        ↓

Identificar riesgos

        ↓

Aplicar correcciones

        ↓

Documentar evidencias
```

# Checklist de revisión

## 1. Configuración del entorno

Comprobar:

```text
[ ] Existe separación entre desarrollo y producción

[ ] La configuración no está mezclada con el código

[ ] Los secretos están fuera del repositorio

[ ] DEBUG está desactivado en producción

[ ] Las variables de entorno están configuradas correctamente
```

Evidencias posibles:

- captura de configuración sin mostrar secretos;
- explicación de variables utilizadas;
- estructura del proyecto.

---

## 2. HTTPS y comunicaciones

Comprobar:

```text
[ ] La aplicación funciona mediante HTTPS

[ ] El certificado es válido

[ ] HTTP redirige a HTTPS

[ ] No existen recursos cargados mediante HTTP

[ ] Las cookies sensibles utilizan configuración adecuada
```

Evidencias posibles:

- captura del navegador mostrando HTTPS;
- revisión de certificado;
- comprobación mediante DevTools.

---

## 3. Servidor y exposición

Comprobar:

```text
[ ] Solo están accesibles los servicios necesarios

[ ] La aplicación no expone archivos internos

[ ] El directorio público es correcto

[ ] No existen herramientas de desarrollo publicadas

[ ] La arquitectura separa componentes públicos e internos
```

Evidencias posibles:

- diagrama de arquitectura;
- configuración del servidor;
- revisión de accesos.

---

## 4. Base de datos

Comprobar:

```text
[ ] La base de datos no está expuesta directamente a Internet

[ ] La aplicación utiliza un usuario específico

[ ] Los permisos del usuario son mínimos

[ ] Las credenciales no están en el código

[ ] Existen copias de seguridad o procedimiento definido
```

Evidencias posibles:

- configuración de conexión sin secretos;
- diagrama de acceso;
- explicación de permisos.

---

## 5. Permisos de archivos

Comprobar:

```text
[ ] No existen permisos excesivos

[ ] No se utiliza chmod 777 como solución

[ ] Las carpetas escribibles están identificadas

[ ] Los archivos sensibles están protegidos

[ ] Los archivos subidos no pueden ejecutarse
```

Evidencias posibles:

- estructura de directorios;
- permisos relevantes;
- explicación de decisiones.

---

## 6. Errores y logs

Comprobar:

```text
[ ] Los errores técnicos no aparecen al usuario

[ ] Los logs están configurados

[ ] Los logs no contienen secretos

[ ] Los archivos de log no son accesibles públicamente

[ ] Existe información suficiente para investigar problemas
```

Evidencias posibles:

- captura de gestión de errores;
- ejemplo de log anonimizado.

---

## 7. Cabeceras de seguridad

Comprobar:

```text
[ ] Las cabeceras están configuradas

[ ] La configuración se ha revisado

[ ] CSP no rompe funcionalidades

[ ] El navegador recibe las políticas esperadas
```

Evidencias posibles:

- captura de DevTools Network;
- listado de cabeceras HTTP.

---

# Entregable

El equipo debe entregar:

## 1. Checklist completado

Indicando:

- elementos revisados;
- estado;
- posibles mejoras.

## 2. Diagrama de despliegue

Debe mostrar:

```text
Usuario

    ↓ HTTPS

Servidor web

    ↓

Aplicación

    ↓

Base de datos
```

Incluyendo los elementos de seguridad aplicados.

## 3. Evidencias

Capturas o explicaciones de:

- HTTPS;
- configuración;
- arquitectura;
- controles aplicados.

## 4. Reflexión final

Responder:

- ¿Qué decisiones de seguridad se han aplicado?
- ¿Qué riesgos se han reducido?
- ¿Qué mejoras quedarían pendientes?

# Relación con el módulo

Esta actividad integra los contenidos trabajados:

```text
Diseño seguro

        ↓

Implementación segura

        ↓

Despliegue seguro

        ↓

Aplicación en el reto
```

El objetivo es que la seguridad forme parte del desarrollo completo de la aplicación.

# Idea clave

> Una aplicación profesional no solo debe funcionar: debe poder desplegarse y mantenerse de forma segura.
