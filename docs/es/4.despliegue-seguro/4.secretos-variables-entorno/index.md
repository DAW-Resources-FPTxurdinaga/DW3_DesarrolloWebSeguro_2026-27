# Secretos y variables de entorno

Las aplicaciones necesitan información de configuración para conectarse con otros servicios.

Algunos ejemplos:

- credenciales de base de datos;
- claves API;
- tokens;
- claves de cifrado;
- contraseñas de servicios externos.

Estos datos son necesarios para que la aplicación funcione, pero no forman parte de la lógica de negocio.

Por este motivo deben gestionarse como configuración externa.

## Código frente a secretos

Una práctica insegura consiste en incluir secretos directamente en el código.

Ejemplo:

```php
$usuario = "admin";
$password = "clave123";
```

o:

```javascript
const apiKey = "abc123";
```

Este enfoque genera varios problemas:

- el secreto queda almacenado junto al código;
- puede aparecer en un repositorio;
- puede copiarse a otros entornos;
- dificulta cambiar credenciales.

La aplicación debe conocer cómo obtener el secreto, pero no debe contenerlo directamente.

## Separación entre código y configuración

El modelo recomendado:

```text
Código fuente

        +

Configuración del entorno

        ↓

Aplicación ejecutándose
```

El mismo código puede utilizar diferentes configuraciones:

```text
Desarrollo

Base de datos de pruebas


Producción

Base de datos real
```

Sin modificar la aplicación.

## Variables de entorno

Las variables de entorno permiten proporcionar información al proceso cuando se inicia.

Ejemplo:

```text
DB_HOST=servidor-interno
DB_DATABASE=txurdigest
DB_USERNAME=usuario_app
DB_PASSWORD=secreto
```

La aplicación consulta estos valores:

```php
$password = getenv('DB_PASSWORD');
```

El código no conoce el valor real.

## Tipos de información sensible

No todos los datos tienen la misma importancia.

Algunos ejemplos:

### Credenciales

```text
Usuario
Contraseña
Tokens de acceso
```

Permiten autenticarse frente a un servicio.

### Claves criptográficas

Ejemplo:

```text
APP_KEY
SECRET_KEY
```

Se utilizan para operaciones como:

- cifrado;
- firma de datos;
- generación de tokens.

### Claves de servicios externos

Por ejemplo:

```text
API_KEY
```

para comunicarse con servicios externos.

Todas ellas deben protegerse como secretos.

## El archivo `.env`

Muchos entornos utilizan un archivo:

```text
.env
```

para almacenar configuración local.

Ejemplo:

```text
APP_ENV=production
APP_DEBUG=false

DB_HOST=db-interno
DB_PASSWORD=secreto
```

Este archivo resulta cómodo durante el desarrollo, pero contiene información sensible.

Por tanto:

```text
.env

NO debe publicarse
```

## Repositorios Git

Uno de los errores más frecuentes es subir accidentalmente secretos al repositorio.

Ejemplo:

```bash
git add .
git commit
git push
```

Si `.env` está incluido, las credenciales pueden quedar almacenadas en el historial del proyecto.

La prevención habitual:

```text
.gitignore
```

Ejemplo:

```text
.env
```

## No basta con borrar un secreto publicado

Si una contraseña se sube accidentalmente a Git, eliminar el archivo en un commit posterior no siempre elimina el problema.

El secreto puede permanecer en:

- historial;
- copias;
- clones;
- sistemas externos.

La actuación correcta es:

```text
Detectar exposición

        ↓

Revocar o cambiar secreto

        ↓

Eliminar rastros si procede

        ↓

Actualizar configuración
```

La prioridad es invalidar el secreto comprometido.

## Principio de mínimo privilegio

Un secreto no debe proporcionar más permisos de los necesarios.

Ejemplo incorrecto:

```text
Aplicación web

        ↓

Usuario administrador de base de datos
```

Si la aplicación solo necesita consultar y modificar determinadas tablas, no debería utilizar una cuenta con permisos totales.

Modelo recomendado:

```text
Aplicación

        ↓

Usuario específico

        ↓

Permisos necesarios
```

## Rotación de secretos

Los secretos no deberían mantenerse indefinidamente.

Una gestión adecuada contempla:

- creación;
- almacenamiento seguro;
- uso;
- renovación;
- retirada.

Este proceso se conoce como rotación de secretos.

## Secretos en diferentes entornos

Cada entorno debe tener sus propios valores.

Ejemplo:

```text
Desarrollo

DB_PASSWORD=dev_password


Pruebas

DB_PASSWORD=test_password


Producción

DB_PASSWORD=prod_password
```

Nunca debería utilizarse la misma credencial para todos los entornos.

## Variables de entorno en despliegue

Durante el despliegue, el servidor debe proporcionar la configuración necesaria.

Conceptualmente:

```text
Servidor

        ↓

Variables de entorno

        ↓

Aplicación

        ↓

Servicios externos
```

La aplicación recibe los valores al ejecutarse.

## Relación con Bloque 3

En el Bloque 3 se trabajó:

```text
No guardar secretos en el código
```

En este bloque trabajamos:

```text
Cómo proporcionar esos secretos durante el despliegue
```

Son dos momentos diferentes del mismo principio.

## Ejemplo en TxurdiGest

Una configuración incorrecta:

```php
$conexion = new PDO(
    "mysql:host=db",
    "usuario",
    "password"
);
```

Una configuración adecuada:

```php
$conexion = new PDO(
    getenv('DB_DSN'),
    getenv('DB_USER'),
    getenv('DB_PASSWORD')
);
```

En producción:

```text
Servidor

DB_PASSWORD=valor_real

        ↓

TxurdiGest
```

El repositorio nunca contiene la contraseña.

## Checklist

Antes del despliegue:

```text
[ ] No existen secretos en el código

[ ] .env no está publicado

[ ] Git ignora archivos sensibles

[ ] Cada entorno utiliza sus propios secretos

[ ] Las cuentas tienen permisos mínimos

[ ] Existe un procedimiento de renovación

[ ] Los secretos están configurados en el servidor
```

## Idea clave

> Los secretos deben existir en el entorno donde se ejecuta la aplicación, no dentro del código fuente.
