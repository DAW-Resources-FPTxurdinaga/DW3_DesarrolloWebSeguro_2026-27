# Implementación de permisos de archivos y directorios

La configuración de permisos debe realizarse como parte del proceso de despliegue.

El objetivo es que la aplicación tenga exactamente los permisos que necesita para funcionar, pero no más.

## Revisar la estructura antes de asignar permisos

Antes de modificar permisos conviene identificar:

- código de la aplicación;
- archivos de configuración;
- carpetas con datos generados;
- archivos subidos por usuarios;
- registros.

Ejemplo:

```text
/var/www/txurdigest

├── app/
├── config/
├── public/
├── storage/
└── vendor/
```

Cada zona tiene necesidades diferentes.

## Propietario de los archivos

Una práctica habitual es que el código pertenezca a un usuario de despliegue y que el servidor web tenga acceso de lectura.

Ejemplo conceptual:

```text
Código

propietario:
usuario despliegue

acceso servidor web:
lectura
```

El servidor web no necesita modificar todos los archivos.

## Asignar propietario y grupo

Linux permite modificar propietario y grupo mediante:

```bash
chown
```

Ejemplo:

```bash
sudo chown -R usuario:grupo /var/www/txurdigest
```

La elección concreta depende de la arquitectura del servidor.

Lo importante es que los propietarios sean coherentes con el funcionamiento de la aplicación.

## Permisos de lectura y escritura

Los permisos deben responder a una necesidad funcional.

Ejemplo:

```text
Código PHP

lectura


Logs

lectura/escritura


Uploads

lectura/escritura
```

No debe aplicarse escritura globalmente a toda la aplicación.

## Evitar permisos excesivos

Una práctica incorrecta:

```bash
chmod -R 777 /var/www/txurdigest
```

Aunque puede solucionar rápidamente problemas de permisos, crea un riesgo:

- cualquier usuario puede modificar archivos;
- un proceso comprometido podría alterar la aplicación;
- aumenta el impacto de una vulnerabilidad.

Debe buscarse la configuración mínima necesaria.

## Ejemplo de permisos

Una posible configuración:

```text
Archivos de aplicación:

644


Directorios:

755
```

Carpetas que necesitan escritura:

```text
storage/

775
```

Estos valores son ejemplos habituales, pero deben adaptarse al servidor real.

## Permisos en Laravel

Laravel utiliza determinadas carpetas que necesitan escritura.

Normalmente:

```text
storage/

bootstrap/cache/
```

Ejemplo:

```bash
chmod -R 775 storage bootstrap/cache
```

El proceso web debe poder escribir en ellas.

El resto del proyecto no necesita permisos de escritura.

## Archivos subidos por usuarios

Las carpetas de subida requieren una atención especial.

Ejemplo:

```text
storage/uploads/
```

Debe permitir:

```text
guardar archivos

leer archivos autorizados
```

pero no debe permitir:

```text
ejecutar código
```

La protección debe combinar:

- permisos;
- ubicación correcta;
- configuración del servidor;
- validación de aplicación.

## Proteger archivos sensibles

Archivos como:

```text
.env

claves privadas

logs

configuración interna
```

deben tener permisos restrictivos.

Ejemplo conceptual:

```text
Aplicación

puede leer


Usuarios externos

sin acceso
```

Además, nunca deben estar publicados mediante el servidor web.

## Comprobar permisos

Para revisar permisos:

```bash
ls -la
```

Ejemplo:

```text
-rw-r----- 1 usuario grupo archivo.env
```

Permite comprobar:

- propietario;
- grupo;
- permisos actuales.

## Buscar permisos demasiado abiertos

Puede revisarse si existen archivos con permisos excesivos:

```bash
find /var/www/txurdigest -perm -o+w
```

La revisión permite localizar elementos modificables por cualquier usuario.

## Despliegue automático

En entornos profesionales, los procesos de despliegue deberían establecer permisos correctamente.

Un despliegue no debería depender de:

```text
"ejecutar chmod hasta que funcione"
```

Debe existir una configuración conocida y repetible.

Ejemplo:

```text
Descargar aplicación

        ↓

Asignar propietario

        ↓

Configurar permisos

        ↓

Reiniciar servicios

        ↓

Comprobar funcionamiento
```

## Permisos y copias de seguridad

Las copias de seguridad también requieren protección.

Una copia como:

```text
backup.sql
```

puede contener:

- datos personales;
- información interna;
- credenciales.

Debe tratarse con la misma seguridad que la aplicación principal.

## Ejemplo en TxurdiGest

Configuración:

```text
/var/www/txurdigest

app/

lectura


config/

lectura restringida


public/

lectura


storage/

lectura/escritura
```

El servidor web puede ejecutar la aplicación y almacenar datos necesarios.

No puede modificar arbitrariamente todo el proyecto.

## Checklist

```text
[ ] Propietarios revisados

[ ] Grupo correcto asignado

[ ] No existen permisos 777

[ ] Código sin escritura innecesaria

[ ] Carpetas escribibles identificadas

[ ] .env protegido

[ ] Uploads protegidos

[ ] Backups protegidos

[ ] Permisos revisados después del despliegue
```

## Idea clave

> Los permisos correctos permiten que la aplicación funcione sin conceder capacidades innecesarias al servidor o a otros usuarios.
