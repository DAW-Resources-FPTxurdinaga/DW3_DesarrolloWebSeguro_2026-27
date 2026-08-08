# Implementación de configuración de producción

La configuración de producción debe permitir que la aplicación funcione en un entorno real sin modificar su código fuente.

La idea principal es:

```text
Mismo código

        ↓

Configuraciones diferentes

        ↓

Entornos diferentes
```

La aplicación debe recibir del entorno los valores que necesita para ejecutarse.

## Variables de entorno en PHP

PHP permite acceder a variables de entorno mediante:

```php
getenv()
```

Por ejemplo:

```php
$dbHost = getenv('DB_HOST');

$dbName = getenv('DB_DATABASE');

$dbUser = getenv('DB_USERNAME');

$dbPassword = getenv('DB_PASSWORD');
```

La aplicación utiliza estos valores, pero no conoce dónde están definidos.

## Ejemplo de conexión a base de datos

Una conexión insegura podría contener:

```php
$pdo = new PDO(
    'mysql:host=localhost;dbname=txurdigest',
    'admin',
    'password123'
);
```

El problema es que:

- las credenciales están en el código;
- pueden acabar en Git;
- todos los entornos utilizarían los mismos valores;
- cambiar la configuración obliga a modificar la aplicación.

Una alternativa:

```php
$pdo = new PDO(
    getenv('DB_DSN'),
    getenv('DB_USERNAME'),
    getenv('DB_PASSWORD')
);
```

Ahora la configuración pertenece al entorno.

## Archivo `.env`

Muchos frameworks utilizan archivos de configuración basados en variables de entorno.

Ejemplo:

```text
APP_ENV=production
APP_DEBUG=false

DB_HOST=servidor-bd
DB_DATABASE=txurdigest
DB_USERNAME=usuario_app
DB_PASSWORD=secreto
```

El archivo `.env` es una forma cómoda de trabajar, pero debe protegerse.

No debe:

- publicarse;
- enviarse al repositorio;
- compartirse sin necesidad.

## `.env.example`

Una práctica habitual es mantener una plantilla:

```text
APP_ENV=
APP_DEBUG=

DB_HOST=
DB_DATABASE=
DB_USERNAME=
DB_PASSWORD=
```

Esta plantilla indica qué variables necesita la aplicación, pero no contiene información sensible.

El flujo sería:

```text
.env.example

        ↓

copiar

        ↓

.env con valores reales
```

## Configuración con Git

El archivo:

```text
.env
```

debería incluirse normalmente en:

```text
.gitignore
```

Ejemplo:

```text
.env
```

Así Git no lo incorporará al repositorio.

Después se puede comprobar:

```bash
git status
```

para verificar que no aparece como archivo pendiente.

## Configuración de Laravel en producción

Laravel utiliza variables de entorno mediante:

```text
.env
```

Algunos valores importantes:

```text
APP_ENV=production

APP_DEBUG=false

APP_KEY=clave-secreta
```

Especialmente importante:

```text
APP_DEBUG=false
```

En producción no deben mostrarse excepciones completas al usuario.

Una aplicación podría revelar:

- rutas internas;
- consultas;
- estructura del framework;
- información del servidor.

## Caché de configuración en Laravel

Laravel permite almacenar la configuración compilada para mejorar el rendimiento.

Después de modificar variables de entorno puede ser necesario actualizar la caché:

```bash
php artisan config:cache
```

La configuración utilizada por la aplicación debe corresponder al entorno real.

## Dependencias de producción

Las dependencias instaladas en producción deben ser únicamente las necesarias.

Por ejemplo, en PHP con Composer:

```bash
composer install --no-dev --optimize-autoloader
```

La opción:

```text
--no-dev
```

evita instalar dependencias utilizadas únicamente durante el desarrollo.

Reducir componentes innecesarios disminuye la superficie de exposición.

## Separación de entornos

Una misma aplicación puede tener:

```text
Desarrollo

DB_DATABASE=txurdigest_dev


Pruebas

DB_DATABASE=txurdigest_test


Producción

DB_DATABASE=txurdigest_prod
```

El código no cambia.

Cambian los valores de configuración.

## Gestión de claves y secretos

Algunos valores requieren una protección especial:

- contraseñas;
- claves API;
- tokens;
- certificados privados;
- claves de cifrado.

No deben almacenarse:

```text
en código fuente

ni

en repositorios
```

En entornos profesionales pueden utilizarse sistemas específicos de gestión de secretos.

Para un proyecto DAW, el principio fundamental es:

> Un secreto debe existir en el entorno donde se ejecuta la aplicación, no dentro del código fuente.

## Configuración del servidor web

La configuración del servidor también forma parte del despliegue.

Ejemplos:

- directorio raíz correcto;
- archivos privados no accesibles;
- ejecución del código PHP;
- permisos adecuados;
- errores no visibles.

La aplicación y el servidor deben configurarse conjuntamente.

## Comprobaciones antes de publicar

Una revisión básica:

```text
[ ] APP_DEBUG desactivado

[ ] Variables de entorno configuradas

[ ] .env no publicado

[ ] Secretos fuera de Git

[ ] Dependencias de desarrollo eliminadas

[ ] Credenciales de producción correctas

[ ] Configuración revisada
```

## Ejemplo en TxurdiGest

Durante desarrollo:

```text
DB_HOST=localhost

DB_DATABASE=txurdigest_dev

APP_DEBUG=true
```

Durante producción:

```text
DB_HOST=db-interno

DB_DATABASE=txurdigest

APP_DEBUG=false
```

El proyecto mantiene el mismo código.

Solo cambia la configuración proporcionada por el entorno.

## Idea clave

> La configuración de producción debe adaptarse al entorno sin obligar a modificar el código de la aplicación.
