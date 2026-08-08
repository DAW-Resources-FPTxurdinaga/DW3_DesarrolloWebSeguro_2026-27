# Logs y errores en producción

Una aplicación segura no solo debe evitar errores, sino gestionarlos correctamente cuando ocurren.

Durante el desarrollo, los errores ayudan a encontrar problemas.

En producción, la gestión debe cambiar:

```text
Desarrollo

mostrar información para depurar


Producción

proteger información + registrar lo necesario
```

El objetivo es que la aplicación falle de forma controlada.

## Errores visibles frente a errores internos

Cuando ocurre un problema, existen dos necesidades diferentes:

### Usuario

Necesita recibir información clara:

```text
No se ha podido completar la operación.
```

### Equipo técnico

Necesita información suficiente para investigar:

```text
Fecha

Usuario afectado

Operación realizada

Error técnico
```

Estas dos necesidades no deben mezclarse.

## No mostrar información interna

Una respuesta insegura puede mostrar:

```text
Error SQL completo

Ruta del servidor

Versión del framework

Archivo interno

Línea de código
```

Ejemplo:

```text
Fatal error:
PDOException in /var/www/app/database.php line 45
```

Esta información puede ayudar a un atacante a conocer detalles de la aplicación.

En producción debe sustituirse por un mensaje controlado.

## Registrar errores internamente

Aunque el usuario no vea el error completo, la aplicación debe registrarlo.

Ejemplo:

```text
Usuario:

No se ha podido guardar el registro.


Log interno:

2026-08-08
Error conexión BD
usuario afectado
identificador operación
```

El registro permite:

- diagnosticar problemas;
- investigar incidentes;
- detectar fallos repetidos.

## Información que no debe aparecer en logs

Los logs también pueden convertirse en un riesgo si almacenan demasiada información.

No deberían guardar:

```text
Contraseñas

Tokens completos

Claves API

Datos personales innecesarios

Información sensible
```

Ejemplo incorrecto:

```text
Login usuario:
ana

Password:
secreto123
```

El registro debe contener únicamente la información necesaria.

## Nivel de detalle según el entorno

Una aplicación puede utilizar diferentes niveles de registro.

Desarrollo:

```text
Más información

Más detalle técnico
```

Producción:

```text
Información útil

Sin datos sensibles
```

La configuración debe adaptarse al entorno.

## Excepciones en PHP

PHP permite gestionar errores mediante mecanismos de excepciones.

Ejemplo:

```php
try {

    guardarDatos();

} catch (Exception $e) {

    error_log(
        $e->getMessage()
    );

    mostrarErrorUsuario();

}
```

La aplicación registra el problema, pero no muestra detalles internos.

## Errores en Laravel

Laravel dispone de mecanismos propios para:

- gestión de excepciones;
- generación de logs;
- configuración del entorno.

Un elemento importante:

```text
APP_DEBUG=false
```

en producción.

Con esta configuración se evita mostrar información detallada de errores al usuario.

## Logs del servidor

Además de los logs de la aplicación pueden existir registros del servidor:

- accesos HTTP;
- errores del servidor web;
- eventos del sistema.

Estos registros ayudan a analizar:

- peticiones recibidas;
- errores repetidos;
- problemas de configuración.

## Protección de archivos de log

Los logs pueden contener información sensible.

Por tanto:

```text
Logs

        ↓

deben estar protegidos
```

No deberían estar dentro de una carpeta accesible públicamente.

Ejemplo incorrecto:

```text
https://ejemplo.com/logs/error.log
```

Un usuario externo no debería poder descargar registros internos.

## Monitorización básica

Un despliegue profesional revisa:

- errores frecuentes;
- caídas del servicio;
- consumo de recursos;
- intentos anómalos;
- problemas repetidos.

El objetivo es detectar problemas antes de que afecten a los usuarios.

## No ocultar todos los errores

Gestionar errores correctamente no significa ignorarlos.

Una mala práctica:

```text
capturar excepción

        ↓

no hacer nada
```

La aplicación debe:

- informar correctamente;
- registrar cuando sea necesario;
- permitir investigar.

## Relación con seguridad

Los errores forman parte de la superficie de información de una aplicación.

Una aplicación puede estar bien programada, pero si revela:

```text
estructura interna

versiones

rutas

consultas

credenciales
```

a través de errores, pierde parte de su seguridad.

## Ejemplo en TxurdiGest

Situación:

```text
Error al guardar una reserva
```

Usuario:

```text
No se ha podido completar la operación.
```

Equipo técnico:

```text
Log:

fecha
usuario
operación
error técnico
```

El usuario no recibe información interna.

El equipo puede investigar el problema.

## Checklist

```text
[ ] DEBUG desactivado en producción

[ ] Errores técnicos ocultos al usuario

[ ] Logs configurados

[ ] Logs protegidos

[ ] No se registran secretos

[ ] Existe información suficiente para investigar

[ ] Errores probados en entorno de producción
```

## Idea clave

> Una aplicación segura no evita todos los errores; consigue que los errores no expongan información y puedan ser analizados de forma controlada.
