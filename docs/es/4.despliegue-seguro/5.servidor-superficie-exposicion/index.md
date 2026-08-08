# Servidor y superficie de exposición

Cuando una aplicación se publica en Internet deja de estar únicamente bajo el control del equipo de desarrollo.

El servidor, los servicios activos, los puertos abiertos y la configuración de red determinan qué partes de la aplicación están disponibles para usuarios externos.

El objetivo del despliegue seguro es reducir la superficie de exposición:

> Solo debe estar accesible aquello que la aplicación necesita.

## Qué es la superficie de exposición

La superficie de exposición representa todos los elementos que pueden recibir interacciones externas.

Puede incluir:

- páginas web;
- APIs;
- puertos abiertos;
- servicios del sistema;
- bases de datos;
- paneles de administración;
- archivos accesibles;
- herramientas auxiliares.

Cuantos más elementos estén expuestos, mayor es la posibilidad de errores o configuraciones incorrectas.

Conceptualmente:

```text
Más servicios expuestos

        ↓

Mayor superficie de exposición

        ↓

Mayor necesidad de protección
```

## Arquitectura básica de una aplicación web

Una arquitectura habitual:

```text
Usuario

   ↓ HTTPS

Servidor web

   ↓

Aplicación

   ↓

Base de datos
```

Cada componente tiene una responsabilidad diferente.

El usuario no debería acceder directamente a todos los elementos internos.

## Exposición correcta de servicios

Una configuración segura intenta limitar los accesos:

```text
Internet

    ↓

Puerto HTTPS

    ↓

Servidor web

    ↓

Aplicación

    ↓

Base de datos privada
```

La base de datos no debería estar publicada directamente en Internet.

Modelo incorrecto:

```text
Internet

    ↓

Base de datos
```

La aplicación debe actuar como intermediaria.

## Puertos y servicios

Cada servicio disponible utiliza normalmente un puerto de comunicación.

Ejemplos:

```text
HTTP
80

HTTPS
443

SSH
22

MySQL
3306
```

No significa que todos deban estar accesibles desde Internet.

Una regla básica:

```text
Servicio necesario

        ↓

Permitir acceso


Servicio innecesario

        ↓

No exponer
```

## Principio de mínimo acceso

La configuración del servidor debe aplicar el principio de mínimo privilegio.

Ejemplos:

Un servidor web necesita:

```text
Aceptar peticiones HTTPS
```

pero no necesita necesariamente:

```text
Aceptar conexiones directas a la base de datos desde Internet
```

La configuración debe limitar quién puede comunicarse con cada servicio.

## Relación con AWS

En AWS este control puede aplicarse mediante elementos como:

- Security Groups;
- subredes;
- separación entre servicios públicos y privados.

Una arquitectura habitual:

```text
Internet

    ↓

Servidor web público

    ↓

Red interna

    ↓

Base de datos privada
```

La base de datos puede comunicarse con la aplicación, pero no estar accesible directamente desde Internet.

## Security Groups

Un Security Group funciona como un control de acceso de red.

Permite definir:

- qué puertos están abiertos;
- desde qué orígenes;
- hacia qué recursos.

Ejemplo:

Servidor web:

```text
Permitir:

443 HTTPS
```

Base de datos:

```text
Permitir:

3306

solo desde servidor web
```

La decisión importante es que el acceso debe ser específico.

## Directorio público del servidor web

El servidor web debe publicar únicamente los archivos necesarios.

Ejemplo:

```text
Aplicación

/app

    config/

    storage/

    vendor/

    public/

        index.php
```

El servidor web debería apuntar a:

```text
public/
```

y no a toda la aplicación.

Así se evita exponer:

- archivos de configuración;
- dependencias;
- información interna.

## Archivos que no deberían ser públicos

Algunos archivos nunca deberían estar accesibles mediante URL:

```text
.env

.git/

composer.json

logs/

copias de seguridad
```

Una petición como:

```text
https://ejemplo.com/.env
```

no debería devolver información.

## Paneles y herramientas auxiliares

Durante el desarrollo pueden existir herramientas como:

- paneles de administración;
- páginas de prueba;
- herramientas de depuración.

Antes de producción deben revisarse.

Preguntas necesarias:

```text
¿Es necesario?

¿Quién debe acceder?

¿Está protegido?

¿Puede eliminarse?
```

## Reducir información expuesta

El servidor no debería revelar información innecesaria.

Ejemplos:

Cabeceras:

```text
Servidor: Apache/2.x
PHP: 8.x
```

Mensajes:

```text
rutas internas

versiones exactas

errores técnicos
```

La información del entorno debe limitarse.

## Relación con el desarrollo seguro

La configuración del servidor complementa al código.

Por ejemplo:

La aplicación evita:

```text
SQL Injection
```

El servidor evita:

```text
exposición directa de la base de datos
```

Son capas diferentes de protección.

## Ejemplo en TxurdiGest

Una arquitectura adecuada:

```text
Usuario

   ↓ HTTPS

Servidor web público

   ↓

Aplicación Laravel/PHP

   ↓

Base de datos privada
```

No sería recomendable:

```text
Usuario

   ↓

Base de datos
```

ni:

```text
Usuario

   ↓

Carpeta interna de la aplicación
```

## Checklist

Antes de publicar:

```text
[ ] Solo están abiertos los puertos necesarios

[ ] La base de datos no es pública

[ ] El servidor web apunta al directorio correcto

[ ] Archivos sensibles no son accesibles

[ ] Herramientas de desarrollo eliminadas o protegidas

[ ] Servicios innecesarios desactivados

[ ] Security Groups revisados

[ ] Arquitectura de red revisada
```

## Idea clave

> Un despliegue seguro no consiste en abrir todos los servicios para que funcionen, sino en exponer únicamente los servicios necesarios para que la aplicación pueda funcionar.
