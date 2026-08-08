# Implementación segura de la base de datos

La implementación de una base de datos en producción debe garantizar que únicamente la aplicación autorizada pueda acceder a ella.

La configuración segura combina:

```text
Ubicación adecuada

        +

Credenciales protegidas

        +

Permisos mínimos

        +

Copias de seguridad
```

## Crear un usuario específico para la aplicación

La aplicación no debería conectarse utilizando usuarios administrativos.

Ejemplo incorrecto:

```text
Usuario:

root

Permisos:

todos
```

Si la aplicación tiene un problema de seguridad, un usuario con privilegios elevados aumenta el impacto.

Modelo recomendado:

```text
Base de datos

        ↓

Usuario aplicación

        ↓

Permisos necesarios
```

## Ejemplo de permisos

Una aplicación típica puede necesitar:

```text
SELECT

INSERT

UPDATE

DELETE
```

Pero normalmente no necesita:

```text
CREATE USER

DROP DATABASE

Modificar configuración del servidor
```

Los permisos deben ajustarse a las operaciones reales.

## Crear la conexión desde configuración

La aplicación debe obtener los datos de conexión desde variables de entorno.

Ejemplo:

```text
DB_HOST=db-interno

DB_DATABASE=txurdigest

DB_USERNAME=txurdigest_app

DB_PASSWORD=secreto
```

La aplicación utiliza estos valores:

```php
$conexion = new PDO(
    getenv('DB_DSN'),
    getenv('DB_USERNAME'),
    getenv('DB_PASSWORD')
);
```

El código fuente no contiene credenciales.

## No utilizar conexiones administrativas

Una práctica frecuente durante el desarrollo es utilizar:

```text
root
```

porque simplifica las pruebas.

Antes de producción debe sustituirse por un usuario específico.

Ejemplo:

Desarrollo:

```text
root
```

Producción:

```text
txurdigest_app
```

con permisos limitados.

## Restringir el acceso de red

La base de datos debería aceptar conexiones únicamente desde los servicios necesarios.

Arquitectura:

```text
Servidor web

IP autorizada

        ↓

Base de datos
```

No:

```text
Internet

        ↓

Base de datos
```

En AWS este control puede realizarse mediante reglas de red y Security Groups.

## Ejemplo con Security Groups

Servidor web:

```text
Entrada:

443 HTTPS
22 SSH restringido
```

Base de datos:

```text
Entrada:

3306

origen:
servidor aplicación
```

La base de datos no acepta conexiones desde cualquier origen.

## Variables de entorno en producción

En el servidor:

```text
DB_HOST=db-privada

DB_DATABASE=txurdigest

DB_USERNAME=txurdigest_app

DB_PASSWORD=valor-real
```

En el repositorio:

```text
No existen credenciales
```

El despliegue proporciona la configuración necesaria.

## Migraciones de base de datos

Las aplicaciones suelen necesitar actualizar la estructura:

```text
Nueva versión

        ↓

Migración

        ↓

Base de datos actualizada
```

Ejemplos:

- crear tablas;
- añadir columnas;
- modificar índices.

Estas operaciones deben realizarse de forma controlada.

## Riesgos de migraciones incorrectas

Una migración mal diseñada puede:

- perder datos;
- bloquear tablas;
- modificar información incorrecta.

Buenas prácticas:

- probar antes en un entorno de pruebas;
- realizar copias previas;
- revisar cambios destructivos;
- mantener un procedimiento de recuperación.

## Copias de seguridad

Una copia de seguridad básica:

```bash
mysqldump
```

puede generar un archivo con todos los datos.

Ese archivo debe protegerse.

Ejemplo:

```text
backup.sql
```

puede contener:

- usuarios;
- información personal;
- datos de negocio.

No debe quedar accesible públicamente.

## Restauración de copias

Una copia solo es útil si puede recuperarse.

Debe comprobarse:

```text
Crear copia

        ↓

Restaurar copia

        ↓

Verificar aplicación
```

Un backup no probado no garantiza recuperación.

## Contraseñas almacenadas

Las contraseñas de usuarios nunca deben guardarse directamente.

Incorrecto:

```text
usuario

contraseña123
```

Correcto:

```text
usuario

hash
```

En PHP:

```php
password_hash()
```

y:

```php
password_verify()
```

permiten gestionar contraseñas correctamente.

## Logs y datos sensibles

Los registros de la aplicación no deberían almacenar:

- contraseñas;
- tokens;
- datos completos innecesarios.

Ejemplo incorrecto:

```text
Usuario login:

ana

Password:

secreto123
```

Los logs también deben considerarse información sensible.

## Herramientas administrativas

Durante desarrollo pueden utilizarse:

- phpMyAdmin;
- clientes gráficos;
- paneles web.

En producción deben revisarse.

Opciones:

- eliminar;
- restringir acceso;
- proteger mediante autenticación adicional;
- limitar por red.

## Ejemplo en TxurdiGest

Configuración:

```text
Servidor aplicación

        ↓

Usuario:

txurdigest_app

        ↓

Base de datos:

txurdigest
```

Permisos:

```text
Puede trabajar con tablas necesarias

No puede administrar el servidor completo
```

Red:

```text
Internet

    ↓

Servidor web

    ↓

Base de datos privada
```

## Checklist

```text
[ ] La aplicación no utiliza usuario administrador

[ ] Las credenciales están fuera del código

[ ] La BD no acepta conexiones desde Internet

[ ] El usuario tiene permisos mínimos

[ ] Las migraciones están controladas

[ ] Los backups están protegidos

[ ] La restauración ha sido probada

[ ] Las herramientas administrativas están protegidas

[ ] Los logs no contienen secretos
```

## Idea clave

> La seguridad de la base de datos depende tanto de cómo se programa el acceso como de cómo se configura el entorno donde se ejecuta.
