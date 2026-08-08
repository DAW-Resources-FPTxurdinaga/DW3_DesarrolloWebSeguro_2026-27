# Permisos de archivos y directorios

Los permisos del sistema de archivos determinan quién puede leer, modificar o ejecutar los archivos de una aplicación.

Una configuración incorrecta puede permitir modificaciones no deseadas o exponer información sensible.

El objetivo del despliegue seguro es aplicar el principio de mínimo privilegio:

> Cada elemento debe tener únicamente los permisos necesarios para funcionar.

## Usuarios y procesos

En un servidor Linux, una aplicación no se ejecuta directamente como una persona.

Normalmente existe un proceso asociado al servidor web:

```text
Usuario externo

        ↓

Servidor web

        ↓

Proceso de aplicación
```

Ese proceso utiliza un usuario del sistema con determinados permisos.

La seguridad depende de qué puede hacer ese usuario.

## Propietario, grupo y permisos

Linux asigna permisos mediante:

```text
Propietario

Grupo

Otros usuarios
```

Cada uno puede tener permisos de:

```text
r  lectura

w  escritura

x  ejecución
```

Ejemplo:

```text
-rw-r----- 
```

Significa conceptualmente:

```text
Propietario:
lectura + escritura

Grupo:
lectura

Otros:
sin acceso
```

## Riesgo de permisos excesivos

Una práctica habitual pero insegura es:

```bash
chmod -R 777 aplicacion/
```

Esto permite:

```text
todos pueden leer

todos pueden escribir

todos pueden ejecutar
```

El problema es que cualquier usuario o proceso con acceso podría modificar archivos de la aplicación.

Los permisos deben ser específicos.

## Código frente a carpetas escribibles

No todos los archivos necesitan los mismos permisos.

Una aplicación suele tener:

```text
Código fuente

        ↓

solo lectura


Almacenamiento temporal

        ↓

lectura/escritura
```

Ejemplo:

```text
app/

solo lectura


storage/

escritura necesaria
```

Dar escritura a todo el proyecto aumenta el riesgo.

## Carpetas que necesitan escritura

Algunas aplicaciones necesitan modificar archivos:

- logs;
- cachés;
- archivos subidos;
- sesiones almacenadas.

Estas carpetas deben identificarse.

Ejemplo Laravel:

```text
storage/

bootstrap/cache/
```

pueden necesitar escritura por parte del proceso web.

El resto de la aplicación no debería tener permisos de escritura innecesarios.

## Archivos sensibles

Algunos archivos requieren protección adicional:

```text
.env

configuración

claves privadas

copias de seguridad

logs
```

No deben ser accesibles por usuarios externos ni por procesos que no los necesiten.

## Separación entre aplicación y datos generados

Una buena práctica:

```text
Aplicación

        ↓

Código protegido


Datos generados

        ↓

Ubicación controlada
```

Ejemplo:

```text
/var/www/txurdigest/

    app/

    public/

    storage/
```

El código permanece estable.

Los datos generados se almacenan en ubicaciones específicas.

## Archivos subidos por usuarios

Las carpetas donde se almacenan archivos subidos requieren especial atención.

Deben:

- permitir escritura cuando sea necesario;
- impedir ejecución;
- controlar quién puede acceder.

Ejemplo:

```text
storage/uploads/

lectura/escritura controlada

NO

ejecución de código
```

## Usuario del servidor web

El servidor web suele ejecutarse con un usuario específico.

Ejemplos habituales:

```text
www-data

apache

nginx
```

Ese usuario necesita los permisos mínimos para ejecutar la aplicación.

Una configuración incorrecta sería:

```text
Aplicación

propietario:
root

permisos:
todos escribibles
```

La aplicación no debería depender de permisos excesivos.

## Aplicar mínimo privilegio

La pregunta correcta no es:

```text
¿Qué permisos hacen que funcione?
```

sino:

```text
¿Qué permisos necesita realmente?
```

Ejemplo:

La aplicación necesita:

```text
leer código PHP

escribir logs

guardar archivos subidos
```

No necesita:

```text
modificar todos los archivos del proyecto
```

## Permisos y despliegue

Durante un despliegue deben revisarse:

```text
Archivos copiados

        ↓

Propietario correcto

        ↓

Grupo correcto

        ↓

Permisos adecuados
```

Un despliegue automático debe evitar crear archivos con permisos inseguros.

## Ejemplo conceptual

Configuración adecuada:

```text
Código aplicación

usuario:
root/desarrollador

permisos:
lectura para servidor


Storage

usuario:
servidor web

permisos:
lectura/escritura
```

La aplicación puede funcionar sin tener control completo sobre todo el proyecto.

## Relación con otros controles

Los permisos son una capa más de seguridad.

Por ejemplo:

```text
Validación aplicación

        +

Autorización

        +

Permisos sistema

        +

Configuración servidor
```

Cada capa limita un tipo diferente de problema.

## Ejemplo en TxurdiGest

Estructura:

```text
/var/www/txurdigest

    app/

    config/

    public/

    storage/
```

Permisos:

```text
app/

lectura


config/

lectura protegida


public/

lectura


storage/

lectura/escritura
```

El servidor web puede trabajar, pero no modificar todo el proyecto.

## Checklist

Antes de publicar:

```text
[ ] No existen permisos 777

[ ] El servidor web tiene solo los permisos necesarios

[ ] El código no necesita escritura

[ ] Las carpetas escribibles están identificadas

[ ] Los archivos sensibles están protegidos

[ ] Los archivos subidos no se ejecutan

[ ] Propietarios y grupos son correctos
```

## Idea clave

> Los permisos del sistema forman parte de la seguridad de la aplicación: una aplicación bien programada también necesita ejecutarse con los privilegios adecuados.
