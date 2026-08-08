# Checklist de seguridad

Una checklist permite convertir los principios de seguridad trabajados durante el módulo en una revisión práctica y repetible.

No sustituye el criterio técnico.

Sirve para recordar qué aspectos deben comprobarse antes de considerar una aplicación preparada para producción.

```text
Revisar

    ↓

Comprobar

    ↓

Corregir

    ↓

Evidenciar
```

La lista debe adaptarse al proyecto, pero puede utilizarse como base común para los retos DAW.

## Cómo utilizar la checklist

Cada elemento puede marcarse como:

```text
[ ] Pendiente

[x] Comprobado

[N/A] No aplica
```

Cuando un punto no se cumpla, debe registrarse qué corrección es necesaria.

No es suficiente marcar casillas sin realizar una comprobación real.

## 1. Validación de entradas

```text
[ ] Los datos recibidos se validan en el servidor

[ ] La validación JavaScript no es el único control

[ ] Se comprueban tipos de datos

[ ] Se comprueban rangos y formatos

[ ] Los valores inesperados se rechazan

[ ] Los mensajes de error son adecuados
```

## 2. Salida segura

```text
[ ] Los datos procedentes del usuario se muestran de forma segura

[ ] Se evita interpretar contenido no confiable como HTML o JavaScript

[ ] Se utiliza escape o mecanismos equivalentes cuando corresponde

[ ] No se muestran datos sensibles innecesarios
```

## 3. Acceso a datos

```text
[ ] Las consultas utilizan parámetros o mecanismos equivalentes

[ ] No se concatenan directamente datos del usuario en consultas SQL

[ ] La aplicación utiliza un usuario de base de datos específico

[ ] El usuario de base de datos tiene únicamente los permisos necesarios
```

## 4. Autenticación

```text
[ ] Las contraseñas se almacenan mediante hash seguro

[ ] Las credenciales incorrectas se rechazan

[ ] Los recursos protegidos requieren autenticación

[ ] El cierre de sesión invalida correctamente el acceso

[ ] La sesión se gestiona de forma adecuada
```

## 5. Autorización

```text
[ ] Cada recurso protegido comprueba permisos

[ ] Estar autenticado no implica acceso automático

[ ] Se comprueba el propietario del recurso cuando corresponde

[ ] Los roles tienen límites definidos

[ ] Modificar un identificador no permite acceder a recursos ajenos
```

## 6. Sesiones y cookies

```text
[ ] Las cookies sensibles utilizan Secure cuando procede

[ ] Las cookies de sesión utilizan HttpOnly cuando procede

[ ] SameSite está configurado de forma adecuada

[ ] No se exponen identificadores de sesión innecesariamente

[ ] El cierre de sesión invalida la sesión
```

## 7. Subida de archivos

```text
[ ] El tamaño de los archivos está limitado

[ ] El tipo de archivo se valida

[ ] El nombre del archivo se controla

[ ] Los archivos se almacenan en una ubicación adecuada

[ ] Los archivos subidos no pueden ejecutarse

[ ] Un usuario no puede sobrescribir archivos arbitrarios
```

## 8. APIs

```text
[ ] Los datos JSON recibidos se validan

[ ] Los endpoints protegidos requieren autenticación

[ ] La autorización se comprueba por recurso

[ ] Los códigos HTTP son coherentes

[ ] La API no devuelve información interna innecesaria

[ ] CORS está configurado de acuerdo con las necesidades reales
```

## 9. Secretos y configuración

```text
[ ] No existen contraseñas o claves API dentro del código

[ ] Los secretos están fuera del repositorio

[ ] .env no está publicado

[ ] .env no está versionado

[ ] Desarrollo y producción utilizan configuraciones diferentes

[ ] Los secretos de producción están protegidos
```

## 10. Configuración de producción

```text
[ ] El entorno está configurado como producción

[ ] DEBUG está desactivado

[ ] No se muestran errores técnicos detallados

[ ] Las dependencias de desarrollo no se incluyen innecesariamente

[ ] La configuración corresponde al entorno desplegado
```

## 11. HTTPS

```text
[ ] La aplicación funciona mediante HTTPS

[ ] El certificado es válido

[ ] HTTP redirige a HTTPS

[ ] No existe contenido mixto

[ ] HSTS se utiliza únicamente si la configuración HTTPS lo permite
```

## 12. Servidor y superficie de exposición

```text
[ ] Solo están abiertos los servicios necesarios

[ ] SSH está restringido cuando existe

[ ] El directorio público es correcto

[ ] No se exponen archivos internos

[ ] No existen herramientas o paneles de desarrollo accesibles

[ ] La información del servidor expuesta es la mínima necesaria
```

## 13. Permisos

```text
[ ] Los archivos tienen permisos adecuados

[ ] Solo las carpetas necesarias permiten escritura

[ ] No se utiliza chmod 777 como solución general

[ ] Los archivos sensibles están protegidos

[ ] Los directorios de subida no permiten ejecución
```

## 14. Base de datos

```text
[ ] La base de datos no está expuesta directamente a Internet

[ ] La aplicación no utiliza root o un administrador

[ ] Las credenciales están fuera del código

[ ] El usuario de aplicación tiene mínimo privilegio

[ ] Existen copias de seguridad

[ ] La restauración se ha considerado o probado
```

## 15. Cabeceras de seguridad

Comprobar únicamente las que correspondan al proyecto.

```text
[ ] Content-Security-Policy está configurada cuando procede

[ ] X-Content-Type-Options está configurada

[ ] Strict-Transport-Security se utiliza correctamente cuando procede

[ ] Referrer-Policy está definida

[ ] Permissions-Policy se ha revisado

[ ] Las cabeceras no rompen funcionalidades legítimas
```

## 16. Errores y logs

```text
[ ] Los errores técnicos no se muestran al usuario

[ ] Los errores relevantes quedan registrados

[ ] Los logs no contienen contraseñas

[ ] Los logs no contienen tokens completos

[ ] Los logs no contienen secretos

[ ] Los archivos de log no son accesibles públicamente

[ ] La rotación de logs está contemplada
```

## 17. Verificación

```text
[ ] Se ha probado al menos un caso válido

[ ] Se han probado entradas inválidas

[ ] Se ha probado el acceso sin autenticación

[ ] Se ha probado la autorización

[ ] Se ha manipulado algún identificador cuando procede

[ ] Se han revisado respuestas HTTP

[ ] Se ha probado un error controlado

[ ] Los fallos encontrados se han corregido o documentado
```

## 18. Evidencias

```text
[ ] Cada decisión importante dispone de alguna evidencia

[ ] Las evidencias son comprensibles

[ ] No contienen secretos

[ ] No contienen datos personales innecesarios

[ ] Las capturas muestran únicamente lo necesario
```

## Priorizar

No todos los elementos tienen la misma importancia en todos los proyectos.

Antes de entregar el reto conviene identificar:

```text
Controles críticos

        ↓

Comprobados primero
```

Por ejemplo:

- autorización;
- secretos;
- consultas a base de datos;
- subida de archivos;
- configuración de producción.

## Checklist y revisión entre iguales

La misma lista puede utilizarse para una revisión cruzada.

```text
Equipo A

        ↓

Revisa proyecto B


Equipo B

        ↓

Revisa proyecto A
```

El objetivo no es puntuar al otro equipo.

Es detectar aspectos que pueden haber pasado desapercibidos.

## Aplicación a TxurdiGest

Para TxurdiGest no sería necesario completar todos los puntos si una funcionalidad no existe.

Por ejemplo:

```text
Subida de archivos

N/A
```

si la aplicación no permite subir archivos.

En cambio, serían especialmente relevantes:

```text
Validación

Autenticación

Autorización

Base de datos

Secretos

HTTPS

Errores

Logs
```

## Resultado final

Al finalizar la revisión, cada punto debería quedar en uno de estos estados:

```text
Comprobado

Corregido

Pendiente justificado

No aplica
```

La checklist no debe convertirse en un documento estático.

Debe reflejar el estado real de la aplicación.

## Idea clave

> Una checklist de seguridad es útil cuando obliga a comprobar controles concretos y facilita detectar qué queda pendiente antes de publicar una aplicación.
