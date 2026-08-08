# Configuración de producción

La configuración de una aplicación debe adaptarse al entorno donde se ejecuta.

El mismo código puede utilizarse en desarrollo, pruebas y producción, pero algunos valores deben cambiar:

- modo de ejecución;
- credenciales;
- rutas;
- servicios utilizados;
- nivel de información mostrada;
- opciones de depuración.

La configuración no debe mezclarse con el código fuente.

## Código y configuración separados

Una aplicación debería mantener una separación clara:

```text
Código fuente
      +
Configuración del entorno
      ↓
Aplicación ejecutándose
```

El código define el comportamiento de la aplicación.

La configuración define cómo se ejecuta en un entorno concreto.

Ejemplo:

```text
Desarrollo

Base de datos:
localhost

Producción

Base de datos:
servidor interno
```

La aplicación es la misma, pero la configuración cambia.

## Configuración de desarrollo frente a producción

Durante el desarrollo pueden activarse opciones que facilitan la programación:

```text
DEBUG = true
```

Esto puede mostrar:

- errores completos;
- trazas de ejecución;
- información del framework;
- detalles internos.

En producción estas opciones deben desactivarse.

Ejemplo conceptual:

```text
Desarrollo

Errores detallados
Depuración activa
Información técnica visible


Producción

Errores controlados
Registro interno
Información mínima al usuario
```

## Modo depuración

Los mensajes de error son útiles durante el desarrollo.

Por ejemplo:

```text
Error SQL:
tabla usuarios no encontrada
archivo:
/var/www/app/modelo.php
línea 35
```

Esta información ayuda al programador.

Pero en producción puede revelar:

- estructura interna;
- rutas del servidor;
- nombres de tablas;
- componentes utilizados.

La aplicación debe mostrar un mensaje genérico:

```text
No se ha podido completar la operación.
```

y registrar internamente el detalle técnico.

## Configuración mediante variables de entorno

Una práctica habitual es utilizar variables de entorno.

Ejemplo:

```text
DB_HOST=servidor-bd
DB_NAME=txurdigest
DB_USER=usuario_app
DB_PASSWORD=secreto
```

El código consulta esos valores:

```php
$dbHost = getenv('DB_HOST');
```

La aplicación no necesita conocer los valores concretos de cada instalación.

## Ventajas de separar configuración

Esta separación permite:

### Utilizar varios entornos

La misma aplicación puede ejecutarse como:

```text
Desarrollo
    ↓
Base de datos local

Pruebas
    ↓
Base de datos de pruebas

Producción
    ↓
Base de datos real
```

sin modificar el código.

### Proteger información sensible

Los datos como:

- contraseñas;
- claves API;
- tokens;
- credenciales de servicios;

no deben almacenarse en archivos del proyecto que puedan acabar publicados.

### Facilitar el despliegue

Un nuevo servidor puede configurarse proporcionando sus variables necesarias sin modificar la aplicación.

## Archivos de configuración

Algunos frameworks utilizan archivos como:

```text
.env
```

para almacenar configuración local.

Por ejemplo:

```text
APP_ENV=production
APP_DEBUG=false

DB_HOST=localhost
DB_DATABASE=txurdigest
```

Estos archivos deben gestionarse correctamente.

No deben incluirse en repositorios públicos.

## El archivo `.env` y Git

Un error habitual es subir:

```text
.env
```

al repositorio.

Esto puede exponer:

- contraseñas;
- claves privadas;
- tokens;
- datos de conexión.

La práctica habitual es incluirlo en:

```text
.gitignore
```

y proporcionar un archivo de ejemplo:

```text
.env.example
```

con la estructura necesaria pero sin secretos reales.

Ejemplo:

```text
DB_HOST=
DB_DATABASE=
DB_USERNAME=
DB_PASSWORD=
```

## Dependencias y modo producción

Las aplicaciones suelen utilizar librerías externas.

Durante el desarrollo pueden instalarse herramientas adicionales:

- depuración;
- pruebas;
- análisis;
- generación de documentación.

En producción deben instalarse únicamente las dependencias necesarias.

Reducir componentes innecesarios disminuye la superficie de exposición.

## Laravel y configuración de producción

En aplicaciones Laravel es habitual revisar:

```text
APP_ENV
APP_DEBUG
APP_KEY
```

Un entorno de producción debería utilizar:

```text
APP_ENV=production

APP_DEBUG=false
```

La clave:

```text
APP_KEY
```

debe existir y mantenerse como secreto.

Después de cambiar configuración puede ser necesario limpiar o regenerar cachés de configuración.

## PHP y configuración de producción

En PHP también existen opciones relevantes.

Por ejemplo:

```text
display_errors
```

En desarrollo:

```text
display_errors = On
```

puede facilitar la programación.

En producción:

```text
display_errors = Off
```

evita mostrar detalles técnicos al usuario.

Los errores deben registrarse mediante mecanismos internos.

## No modificar código para cada entorno

Una mala práctica sería:

```php
if ($entorno === 'produccion') {
    $conexion = "...";
}
```

con valores escritos directamente en el código.

Esto mezcla lógica de aplicación y configuración.

Es preferible:

```php
$conexion = getenv('DB_CONNECTION');
```

La aplicación utiliza la configuración proporcionada por el entorno.

## Ejemplo en TxurdiGest

Durante desarrollo:

```text
Servidor:
localhost

Base de datos:
txurdigest_dev

Debug:
activo
```

Durante producción:

```text
Servidor:
servidor interno

Base de datos:
txurdigest_prod

Debug:
desactivado
```

El código de TxurdiGest no cambia.

Cambia únicamente la configuración del entorno.

## Checklist antes de publicar

Antes del despliegue debería comprobarse:

```text
[ ] DEBUG desactivado

[ ] Errores técnicos ocultos

[ ] Secretos fuera del código

[ ] Variables de entorno configuradas

[ ] Archivo .env protegido

[ ] Dependencias necesarias instaladas

[ ] Configuración revisada para producción

[ ] Datos de prueba eliminados
```

## Idea clave

> La configuración forma parte de la seguridad. El mismo código puede ser seguro o inseguro dependiendo de cómo se configure el entorno donde se ejecuta.
