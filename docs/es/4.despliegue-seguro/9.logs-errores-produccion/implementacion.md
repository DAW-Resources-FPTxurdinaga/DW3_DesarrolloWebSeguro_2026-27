# Implementación de logs y errores en producción

La gestión de errores debe formar parte de la configuración de despliegue.

Una aplicación en producción debe conseguir dos objetivos:

```text
Informar al usuario sin revelar información sensible

        +

Registrar información suficiente para el equipo técnico
```

## Configurar el entorno de producción

El primer paso es revisar la configuración del entorno.

En aplicaciones PHP y Laravel debe evitarse mostrar errores directamente.

Ejemplo conceptual:

```text
Desarrollo

APP_DEBUG=true


Producción

APP_DEBUG=false
```

La aplicación sigue registrando errores, pero deja de mostrarlos al usuario.

## Configuración de PHP

PHP dispone de opciones relacionadas con la visualización de errores.

En desarrollo:

```ini
display_errors = On
```

puede facilitar la programación.

En producción:

```ini
display_errors = Off
```

evita revelar información interna.

Los errores deben enviarse a registros controlados.

## Registro de errores

Un registro debe permitir responder preguntas como:

```text
¿Qué ocurrió?

¿Cuándo ocurrió?

¿A qué operación afectó?

¿Qué usuario estaba implicado?

¿Dónde ocurrió?
```

Ejemplo conceptual:

```text
Fecha:
08/08/2026 10:30

Operación:
Crear reserva

Usuario:
154

Error:
Fallo conexión BD
```

El registro contiene información útil, pero no secretos.

## Registrar excepciones en PHP

Una gestión básica:

```php
try {

    realizarOperacion();

} catch (Exception $e) {

    error_log(
        $e->getMessage()
    );

    mostrarMensajeError();

}
```

El usuario recibe una respuesta controlada.

El detalle queda registrado.

## No registrar información sensible

Debe evitarse almacenar:

```text
Contraseñas

Tokens

Claves API

Datos completos innecesarios

Información bancaria
```

Ejemplo incorrecto:

```text
Usuario:
juan

Password:
123456
```

Ejemplo adecuado:

```text
Usuario:
juan

Error:
fallo autenticación
```

## Logs de Laravel

Laravel proporciona un sistema propio de logs.

La configuración se realiza mediante:

```text
config/logging.php
```

y variables de entorno.

Ejemplo:

```text
LOG_CHANNEL=stack

LOG_LEVEL=error
```

El nivel de registro debe adaptarse al entorno.

## Niveles de log

Los sistemas de registro suelen diferenciar niveles:

```text
debug

info

warning

error

critical
```

En producción normalmente interesa evitar un exceso de información de depuración.

Ejemplo:

```text
Desarrollo:

debug


Producción:

error
```

La configuración dependerá de las necesidades del proyecto.

## Ubicación de los logs

Los registros deben almacenarse en ubicaciones protegidas.

Ejemplo:

```text
storage/logs/
```

No deberían estar dentro del directorio público:

```text
public/
```

porque podrían descargarse mediante una URL.

Incorrecto:

```text
https://txurdigest.ejemplo/logs/error.log
```

## Rotación de logs

Los logs crecen con el tiempo.

Una aplicación en producción debe contemplar:

```text
Generar registros

        ↓

Almacenar durante un periodo

        ↓

Rotar archivos antiguos

        ↓

Eliminar cuando corresponda
```

La rotación evita:

- consumo excesivo de disco;
- pérdida de capacidad de registro;
- dificultad para encontrar información relevante.

## Logs y protección de datos

Los registros pueden contener información personal.

Por tanto deben aplicar medidas similares a otros datos sensibles:

- acceso restringido;
- conservación limitada;
- eliminación segura;
- revisión de contenido.

## Revisar errores durante el despliegue

Después de publicar una aplicación conviene comprobar:

```text
Realizar operación normal

        ↓

Provocar error controlado

        ↓

Comprobar respuesta usuario

        ↓

Revisar log interno
```

La aplicación debe comportarse correctamente en ambos lados.

## Herramientas de revisión

Según el entorno pueden utilizarse:

```bash
tail -f storage/logs/laravel.log
```

para observar registros recientes.

También pueden revisarse:

- logs de Apache;
- logs de Nginx;
- logs del sistema.

## Errores del servidor web

El servidor web también genera información:

Ejemplo:

```text
access.log

error.log
```

Estos registros ayudan a identificar:

- peticiones recibidas;
- errores HTTP;
- problemas de configuración.

## No ocultar problemas

Una aplicación segura no consiste en esconder todos los errores.

Debe existir equilibrio:

```text
Usuario

mensaje seguro


Equipo técnico

información suficiente
```

Ocultar un error sin registrarlo dificulta resolverlo.

## Ejemplo en TxurdiGest

Error:

```text
No se puede guardar una reserva
```

Usuario:

```text
No se ha podido completar la operación.
```

Log:

```text
Fecha

Usuario

Operación

Excepción técnica

Identificador de petición
```

El sistema permite investigar sin revelar detalles internos.

## Checklist

```text
[ ] DEBUG desactivado

[ ] Errores técnicos ocultos

[ ] Logs configurados

[ ] Logs fuera de acceso público

[ ] Rotación configurada

[ ] No se registran secretos

[ ] Se pueden investigar errores

[ ] Logs del servidor revisados
```

## Idea clave

> Los errores deben gestionarse como información sensible: ocultarse al usuario cuando sea necesario y registrarse de forma controlada para poder actuar sobre ellos.
