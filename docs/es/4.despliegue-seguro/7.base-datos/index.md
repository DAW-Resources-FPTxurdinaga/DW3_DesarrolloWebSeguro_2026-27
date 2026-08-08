# Base de datos en un despliegue seguro

La base de datos es uno de los componentes más importantes de una aplicación web.

Contiene información que puede ser crítica:

- usuarios;
- contraseñas cifradas;
- datos personales;
- información de negocio;
- registros de actividad.

Por este motivo, su configuración durante el despliegue debe aplicar medidas de protección específicas.

## La base de datos no debe estar expuesta directamente

Una arquitectura segura separa los componentes:

```text
Usuario

    ↓ HTTPS

Servidor web

    ↓

Aplicación

    ↓

Base de datos
```

El usuario nunca debería conectarse directamente a la base de datos.

Arquitectura incorrecta:

```text
Internet

    ↓

Base de datos
```

La aplicación debe controlar qué operaciones pueden realizarse.

## Separación entre aplicación y base de datos

La base de datos debe considerarse un servicio interno.

Ejemplo:

```text
Servidor web

IP pública


Base de datos

IP privada
```

La aplicación puede comunicarse con la base de datos, pero los usuarios externos no deberían tener acceso directo.

## Usuario específico para la aplicación

Un error frecuente es utilizar cuentas con privilegios excesivos.

Ejemplo incorrecto:

```text
Aplicación

    ↓

Usuario administrador de BD
```

Si la aplicación utiliza una cuenta con todos los permisos, un problema en la aplicación puede tener consecuencias mayores.

Modelo recomendado:

```text
Aplicación

    ↓

Usuario específico

    ↓

Permisos necesarios
```

## Principio de mínimo privilegio en la base de datos

La cuenta utilizada por la aplicación debería tener únicamente los permisos necesarios.

Por ejemplo:

```text
Puede:

SELECT
INSERT
UPDATE

No puede:

crear usuarios
eliminar bases de datos
modificar configuración del servidor
```

La aplicación no debería utilizar una cuenta administrativa.

## Credenciales de base de datos

Las credenciales de conexión forman parte de los secretos de la aplicación.

Nunca deberían aparecer:

```php
$usuario = "root";
$password = "123456";
```

Deben proporcionarse mediante configuración externa:

```text
DB_HOST=db-interno

DB_DATABASE=txurdigest

DB_USERNAME=usuario_app

DB_PASSWORD=secreto
```

La aplicación utiliza los valores del entorno.

## Conexión desde la aplicación

La conexión debe utilizar los datos proporcionados por configuración.

Ejemplo:

```php
$pdo = new PDO(
    getenv('DB_DSN'),
    getenv('DB_USERNAME'),
    getenv('DB_PASSWORD')
);
```

La aplicación no necesita conocer cómo se almacenan esos valores.

## Cifrado de comunicaciones

Cuando la aplicación y la base de datos se encuentran separadas, la comunicación entre ambas puede requerir protección.

Ejemplos:

```text
Servidor web

       ↓ conexión segura

Base de datos
```

La necesidad concreta depende de:

- arquitectura;
- red utilizada;
- sensibilidad de los datos;
- requisitos del entorno.

## Copias de seguridad

Una base de datos segura necesita una estrategia de copias de seguridad.

Debe definirse:

- frecuencia;
- ubicación;
- protección;
- tiempo de conservación;
- procedimiento de recuperación.

Una copia contiene información sensible.

Por tanto:

```text
Backup

también es un dato que debe protegerse
```

## No almacenar contraseñas en texto plano

La base de datos nunca debe almacenar contraseñas directamente.

Incorrecto:

```text
usuario

password123
```

Correcto:

```text
usuario

hash de contraseña
```

La generación del hash debe realizarse utilizando mecanismos adecuados de la aplicación.

Ejemplo PHP:

```php
password_hash()
```

## Migraciones y datos iniciales

Durante el despliegue pueden ejecutarse procesos como:

- creación de tablas;
- actualización de estructura;
- carga de datos iniciales.

Estos procesos deben realizarse de forma controlada.

No deberían ejecutarse automáticamente operaciones destructivas sin revisión.

## Exposición de herramientas de administración

Herramientas como:

- phpMyAdmin;
- paneles de administración;
- interfaces gráficas de BD;

deben revisarse antes de producción.

Preguntas necesarias:

```text
¿Es necesaria?

¿Quién puede acceder?

¿Está protegida?

¿Puede eliminarse?
```

Una herramienta auxiliar publicada sin protección aumenta la superficie de exposición.

## Base de datos y AWS

Una arquitectura habitual:

```text
Internet

    ↓

EC2 servidor aplicación

    ↓

RDS / servidor BD privado
```

El acceso a la base de datos puede limitarse:

```text
Permitir:

servidor aplicación

Bloquear:

Internet
```

El objetivo es que solo los componentes necesarios puedan comunicarse.

## Ejemplo en TxurdiGest

Arquitectura:

```text
Usuario

    ↓ HTTPS

Servidor Laravel/PHP

    ↓

Base de datos interna
```

Configuración:

```text
DB_HOST=db-interno

DB_DATABASE=txurdigest

DB_USERNAME=txurdigest_app
```

La aplicación no utiliza:

```text
root
```

ni expone la base de datos públicamente.

## Checklist

```text
[ ] La BD no está accesible desde Internet

[ ] Existe un usuario específico para la aplicación

[ ] Los permisos son mínimos

[ ] Las credenciales están fuera del código

[ ] Las contraseñas están almacenadas mediante hash

[ ] Las copias de seguridad están protegidas

[ ] Herramientas administrativas revisadas

[ ] Comunicación revisada según arquitectura
```

## Idea clave

> Una base de datos segura no depende únicamente del código que la utiliza: también depende de dónde está situada, quién puede acceder y con qué permisos.
