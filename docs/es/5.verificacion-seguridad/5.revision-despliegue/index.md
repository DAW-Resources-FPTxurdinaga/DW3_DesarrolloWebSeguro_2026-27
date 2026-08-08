# Revisión del despliegue

La verificación de seguridad no termina en el código.

Una aplicación puede estar correctamente implementada y, sin embargo, quedar expuesta por una configuración de producción incorrecta.

Por eso, después del despliegue deben comprobarse también las decisiones tomadas en el entorno.

```text
Aplicación segura

        +

Configuración segura

        +

Infraestructura adecuada
```

La revisión del despliegue comprueba que la aplicación mantiene en producción las medidas trabajadas en los bloques anteriores.

## Qué debe revisarse

La revisión puede centrarse en:

- HTTPS;
- configuración de producción;
- secretos;
- superficie de exposición;
- permisos;
- base de datos;
- cabeceras de seguridad;
- errores y logs.

No se trata de repetir el Bloque 4.

Aquí el objetivo es verificar que la configuración definida está realmente aplicada.

## HTTPS

Comprobar:

```text
[ ] La aplicación funciona mediante HTTPS

[ ] El certificado es válido

[ ] HTTP redirige a HTTPS

[ ] No existen recursos cargados mediante HTTP

[ ] HSTS solo se utiliza si HTTPS está correctamente configurado
```

La comprobación puede realizarse mediante:

- navegador;
- DevTools;
- `curl`.

## Configuración de producción

Comprobar que el entorno de producción no utiliza configuraciones propias del desarrollo.

Ejemplos:

```text
APP_ENV=production

APP_DEBUG=false
```

También debe comprobarse:

```text
[ ] No se muestran errores detallados

[ ] Las dependencias de desarrollo no se instalan innecesariamente

[ ] La configuración corresponde al entorno real
```

## Secretos

Los secretos deben estar fuera del código y del repositorio.

Comprobar:

```text
[ ] No hay credenciales en el código

[ ] .env no está publicado

[ ] .env no está versionado

[ ] Los secretos de producción son diferentes de los de desarrollo

[ ] Los permisos del archivo de configuración son adecuados
```

Si un secreto ha sido publicado, eliminarlo del repositorio no es suficiente.

Debe revocarse o rotarse.

## Superficie de exposición

Revisar qué componentes son accesibles desde el exterior.

Ejemplo:

```text
Internet

    ↓

443

    ↓

Servidor web

    ↓

Aplicación

    ↓

Base de datos interna
```

Comprobar:

```text
[ ] Solo están abiertos los puertos necesarios

[ ] SSH está restringido

[ ] La base de datos no está expuesta directamente

[ ] No existen paneles de desarrollo accesibles

[ ] No pueden descargarse archivos internos
```

## Directorio público

El servidor web debe publicar únicamente los archivos necesarios.

Ejemplo:

```text
Aplicación

├── app/
├── config/
├── storage/
├── vendor/
└── public/
```

El `DocumentRoot` debe apuntar a:

```text
public/
```

Comprobar que no sean accesibles:

- `.env`;
- `.git`;
- logs;
- copias de seguridad;
- archivos de configuración;
- código interno.

## Permisos

La revisión debe comprobar que los permisos no son excesivos.

Ejemplos:

```text
[ ] El código no necesita escritura general

[ ] Solo las carpetas necesarias son escribibles

[ ] No se utiliza chmod 777 como solución

[ ] Los archivos sensibles están protegidos

[ ] Los directorios de subida no permiten ejecución
```

En Laravel deben revisarse especialmente:

```text
storage/

bootstrap/cache/
```

## Base de datos

La aplicación debe utilizar una cuenta específica.

Comprobar:

```text
[ ] La aplicación no utiliza root

[ ] El usuario tiene únicamente los permisos necesarios

[ ] Las credenciales están fuera del código

[ ] La base de datos no es pública

[ ] Existen copias de seguridad

[ ] Se ha considerado la restauración
```

En AWS, una arquitectura habitual puede ser:

```text
EC2

    ↓

Security Group

    ↓

RDS privada
```

La base de datos debe aceptar conexiones únicamente desde los componentes autorizados.

## Cabeceras de seguridad

Comprobar con DevTools o `curl` las cabeceras definidas para la aplicación.

Por ejemplo:

```text
Content-Security-Policy

X-Content-Type-Options

Strict-Transport-Security

Referrer-Policy

Permissions-Policy
```

No se trata de copiar una lista estándar.

Debe verificarse que las cabeceras elegidas:

- están presentes;
- tienen valores correctos;
- no rompen funcionalidades legítimas.

## Errores

Provocar una situación controlada.

Por ejemplo:

```text
Recurso inexistente

Dato inválido

Operación no permitida
```

Comprobar que el usuario no recibe:

- rutas internas;
- consultas SQL;
- trazas;
- secretos;
- información de depuración.

## Logs

Después de provocar un error, comprobar:

```text
[ ] Existe registro interno

[ ] El registro permite investigar

[ ] No contiene secretos

[ ] No es accesible desde la web

[ ] La rotación está contemplada
```

## Revisión desde el exterior

Una comprobación útil consiste en observar la aplicación como la vería un usuario externo.

Preguntas:

```text
¿Qué servicios son visibles?

¿Qué información devuelve el servidor?

¿Qué ocurre si accedo a una ruta interna?

¿Puedo descargar archivos que no deberían ser públicos?

¿Qué código de estado obtengo?
```

La revisión debe realizarse únicamente sobre sistemas propios o expresamente autorizados.

## Evidencias

Una revisión del despliegue puede justificarse mediante:

- captura de HTTPS;
- certificado;
- cabeceras;
- configuración sin secretos;
- diagrama de arquitectura;
- permisos;
- respuesta ante un error;
- fragmento de log anonimizado.

La evidencia debe demostrar el control sin revelar información sensible.

## Aplicación a TxurdiGest

Una revisión final podría comprobar:

```text
[ ] HTTPS activo

[ ] HTTP redirige a HTTPS

[ ] APP_DEBUG=false

[ ] Secretos fuera del código

[ ] .env no accesible

[ ] Solo puertos necesarios

[ ] Base de datos interna

[ ] Permisos adecuados

[ ] Cabeceras verificadas

[ ] Errores controlados

[ ] Logs protegidos
```

## Relación con el Bloque 4

En el Bloque 4 se decidió cómo desplegar de forma segura.

En este bloque se comprueba:

```text
Decisión

    ↓

Configuración aplicada

    ↓

Prueba

    ↓

Evidencia
```

La diferencia es importante.

Una configuración prevista no equivale a una configuración verificada.

## Idea clave

> El despliegue seguro no se da por supuesto: debe revisarse desde producción y demostrarse mediante comprobaciones observables.
