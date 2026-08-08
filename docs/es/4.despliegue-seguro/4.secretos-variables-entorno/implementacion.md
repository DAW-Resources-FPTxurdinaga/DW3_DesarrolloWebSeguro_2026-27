# Implementación de secretos y variables de entorno

La gestión de secretos durante el despliegue consiste en proporcionar a la aplicación la configuración necesaria sin incluir información sensible en el código fuente.

El flujo recomendado:

```text
Repositorio

(sin secretos)

        ↓

Servidor de producción

(variables de entorno)

        ↓

Aplicación

(configuración cargada)
```

## Definir variables de entorno

Una aplicación puede recibir configuración mediante variables de entorno del sistema.

Ejemplo:

```text
APP_ENV=production

APP_DEBUG=false

DB_HOST=db-interno

DB_DATABASE=txurdigest

DB_USERNAME=usuario_app

DB_PASSWORD=secreto
```

Estas variables son proporcionadas por el entorno donde se ejecuta la aplicación.

## Cargar variables en PHP

PHP permite consultar variables de entorno mediante:

```php
getenv()
```

Ejemplo:

```php
$host = getenv('DB_HOST');

$usuario = getenv('DB_USERNAME');

$password = getenv('DB_PASSWORD');
```

La aplicación utiliza los valores, pero no contiene las credenciales.

## Configuración mediante `.env`

Durante el desarrollo puede utilizarse un archivo:

```text
.env
```

Ejemplo:

```text
DB_HOST=localhost

DB_DATABASE=txurdigest_dev

DB_USERNAME=root

DB_PASSWORD=
```

Este archivo facilita trabajar con configuraciones diferentes.

Sin embargo:

```text
.env contiene secretos

        ↓

debe protegerse
```

## Protección del archivo `.env`

El archivo `.env` no debe:

- subirse al repositorio;
- copiarse a servidores innecesarios;
- estar disponible mediante una URL pública;
- compartirse sin control.

Debe incluirse en:

```text
.gitignore
```

Ejemplo:

```text
.env
```

## Archivo `.env.example`

Para documentar la configuración necesaria puede utilizarse:

```text
.env.example
```

Ejemplo:

```text
APP_ENV=

APP_DEBUG=

DB_HOST=

DB_DATABASE=

DB_USERNAME=

DB_PASSWORD=
```

Este archivo puede formar parte del proyecto porque no contiene valores reales.

El proceso habitual:

```text
.env.example

        ↓

copiar

        ↓

.env

        ↓

introducir valores del entorno
```

## Laravel y variables de entorno

Laravel utiliza habitualmente:

```text
.env
```

para cargar configuración.

Ejemplo:

```text
APP_ENV=production

APP_DEBUG=false

APP_KEY=valor-secreto
```

En producción es especialmente importante:

```text
APP_DEBUG=false
```

porque evita mostrar información interna.

Después de modificar configuración puede ser necesario actualizar la caché:

```bash
php artisan config:cache
```

## Variables de entorno en un servidor Linux

En un servidor Linux pueden definirse variables para el proceso que ejecuta la aplicación.

Conceptualmente:

```text
Sistema operativo

        ↓

Proceso PHP/Laravel

        ↓

Aplicación
```

La aplicación no necesita almacenar los valores dentro de sus archivos.

## Permisos del archivo `.env`

Aunque exista un archivo `.env`, debe protegerse mediante permisos adecuados.

La aplicación debe poder leerlo, pero no debe estar disponible para usuarios no autorizados.

Ejemplo conceptual:

```text
Propietario aplicación
        ↓
lectura permitida

Usuarios externos
        ↓
sin acceso
```

No se debe solucionar un problema de permisos utilizando configuraciones excesivamente abiertas.

## Secretos en AWS

En un despliegue en AWS existen diferentes formas de proporcionar configuración.

Por ejemplo:

```text
Servidor EC2

        ↓

Variables de entorno

        ↓

Aplicación Laravel/PHP
```

También pueden utilizarse servicios específicos de gestión de secretos en entornos profesionales.

El principio es siempre el mismo:

```text
El servidor conoce el secreto.

El código no.
```

## Cambio de secretos

Cuando un secreto debe modificarse:

```text
Crear nuevo valor

        ↓

Actualizar entorno

        ↓

Reiniciar aplicación si es necesario

        ↓

Invalidar valor antiguo
```

No debería ser necesario modificar el código fuente.

## Comprobar secretos expuestos

Antes de publicar una aplicación conviene revisar:

```text
[ ] No existen contraseñas en archivos PHP

[ ] No existen claves API en JavaScript

[ ] .env no está en Git

[ ] .env no es accesible desde navegador

[ ] Variables de producción configuradas

[ ] Credenciales diferentes para cada entorno

[ ] Permisos revisados
```

## Ejemplo en TxurdiGest

Repositorio:

```text
TxurdiGest

Código fuente
.env.example
.gitignore
```

Servidor:

```text
Variables de entorno

DB_HOST=db-interno

DB_PASSWORD=valor-real
```

Ejecución:

```text
Laravel

        ↓

lee configuración

        ↓

conecta con servicios
```

La contraseña real nunca forma parte del proyecto.

## Error frecuente

Una práctica incorrecta:

```php
define(
    'DB_PASSWORD',
    'miPassword123'
);
```

Aunque funcione, crea un problema de seguridad.

El secreto queda unido al código.

Una práctica correcta:

```php
$password = getenv('DB_PASSWORD');
```

El entorno proporciona el valor.

## Idea clave

> La configuración sensible debe gestionarse durante el despliegue, no almacenarse dentro de la aplicación.
