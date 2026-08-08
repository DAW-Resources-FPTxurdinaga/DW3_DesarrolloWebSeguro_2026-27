# Implementación de servidor y superficie de exposición

La seguridad del servidor depende de aplicar correctamente la arquitectura definida durante el diseño.

El objetivo no es hacer que todos los componentes sean accesibles, sino permitir únicamente las comunicaciones necesarias.

## Estructura recomendada de una aplicación web

Una aplicación no debería situar todos sus archivos dentro del directorio público.

Ejemplo:

```text
Aplicacion

├── app/
├── config/
├── storage/
├── vendor/
└── public/
    ├── index.php
    ├── css/
    └── js/
```

El servidor web debería apuntar únicamente a:

```text
public/
```

El resto de carpetas deben permanecer fuera del acceso directo mediante navegador.

## Riesgo de publicar toda la aplicación

Una configuración incorrecta:

```text
Servidor web

    ↓

/var/www/txurdigest/
```

puede hacer accesibles archivos internos:

```text
.env

config/

logs/

vendor/

copias de seguridad
```

Una configuración adecuada:

```text
Servidor web

    ↓

/var/www/txurdigest/public/
```

limita la exposición.

## Configuración del servidor web

El servidor debe conocer:

- dominio;
- directorio raíz público;
- certificados HTTPS;
- permisos necesarios;
- reglas de acceso.

Conceptualmente:

```text
Petición HTTP

        ↓

Servidor web

        ↓

Directorio público

        ↓

Aplicación
```

El servidor no debería permitir acceder directamente a archivos internos.

## Archivos sensibles

Algunos archivos deben permanecer fuera del alcance del navegador:

```text
.env

.git/

configuración interna

logs

copias de seguridad

archivos temporales
```

Una comprobación sencilla es intentar acceder mediante URL:

```text
https://dominio/.env
```

La respuesta correcta no debe mostrar el contenido.

## Configuración de Apache

En Apache, una aplicación puede configurarse mediante un Virtual Host.

Ejemplo conceptual:

```apache
<VirtualHost *:443>

    ServerName txurdigest.ejemplo

    DocumentRoot /var/www/txurdigest/public

</VirtualHost>
```

La decisión importante es:

```text
DocumentRoot

        ↓

public/

```

y no la carpeta completa del proyecto.

## Configuración de Nginx

El concepto es equivalente:

```nginx
server {

    server_name txurdigest.ejemplo;

    root /var/www/txurdigest/public;

}
```

El servidor publica únicamente el punto de entrada definido.

## Permisos básicos

Los permisos deben seguir el principio:

```text
mínimos permisos necesarios
```

La aplicación debe poder:

- leer archivos necesarios;
- escribir únicamente donde sea necesario.

Ejemplo:

```text
Código fuente

lectura

↓

Servidor web


Carpeta uploads

lectura/escritura

↓

Servidor web
```

No debería utilizarse:

```bash
chmod 777
```

como solución general.

Permisos excesivos aumentan el impacto de un posible problema.

## Carpetas que necesitan escritura

Algunas aplicaciones necesitan escribir datos:

- archivos subidos;
- cachés;
- logs.

Estas carpetas deben identificarse claramente.

Ejemplo:

```text
storage/

    escritura necesaria

app/

    solo lectura
```

No todo el proyecto necesita permisos de escritura.

## AWS Security Groups

En AWS, los Security Groups permiten controlar qué tráfico llega a cada recurso.

Ejemplo:

Servidor web:

```text
Entrada permitida:

443 HTTPS
```

Administración:

```text
22 SSH

solo desde IP autorizada
```

Base de datos:

```text
3306 MySQL

solo desde servidor web
```

La base de datos no necesita aceptar conexiones desde Internet.

## Arquitectura pública y privada

Una arquitectura habitual:

```text
Internet

    ↓

Servidor web
(subred pública)

    ↓

Aplicación

    ↓

Base de datos
(subred privada)
```

La separación reduce la exposición.

## Comprobaciones desde el exterior

Después del despliegue conviene comprobar qué ve un usuario externo.

Ejemplos:

```text
HTTPS funciona

↓

Archivos internos no accesibles

↓

Paneles no publicados

↓

Errores controlados
```

La pregunta importante:

> ¿Estoy publicando únicamente lo que necesito?

## Herramientas de desarrollo

Antes de producción deben revisarse elementos temporales:

- páginas de prueba;
- datos de ejemplo;
- herramientas de depuración;
- configuraciones locales.

Ejemplo:

```text
development-tools/

        ↓

eliminar o proteger
```

Lo que facilita el desarrollo puede convertirse en un riesgo publicado.

## Ejemplo en TxurdiGest

Estructura recomendada:

```text
Servidor

/var/www/txurdigest

    app/

    storage/

    vendor/

    public/

        index.php
```

Configuración:

```text
Apache/Nginx

        ↓

public/

        ↓

Laravel/PHP

        ↓

Base de datos privada
```

Accesos:

```text
Usuario externo

HTTPS

Servidor web

Aplicación

Base de datos interna
```

## Checklist de despliegue

```text
[ ] DocumentRoot apunta a public/

[ ] Archivos sensibles fuera de acceso público

[ ] Permisos revisados

[ ] No existen permisos 777 innecesarios

[ ] Carpetas de escritura identificadas

[ ] Security Groups revisados

[ ] Base de datos no accesible desde Internet

[ ] Herramientas de desarrollo eliminadas

[ ] Solo están abiertos los puertos necesarios
```

## Idea clave

> Un servidor seguro no es el que permite más accesos, sino el que permite únicamente los accesos necesarios para que la aplicación funcione.
