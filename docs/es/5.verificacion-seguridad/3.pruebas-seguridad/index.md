# Pruebas de seguridad

La revisión del código permite detectar muchos problemas, pero no es suficiente por sí sola.

También es necesario comprobar cómo se comporta la aplicación cuando recibe datos, acciones o peticiones inesperadas.

Las pruebas de seguridad permiten verificar ese comportamiento.

```text
Situación

    ↓

Acción de prueba

    ↓

Respuesta de la aplicación

    ↓

Resultado esperado
```

El objetivo no es “romper” la aplicación, sino comprobar que responde de forma segura.

## Pruebas positivas y negativas

Una prueba positiva comprueba que una funcionalidad válida funciona correctamente.

Ejemplo:

```text
Usuario autenticado

        ↓

Consulta sus propias reservas

        ↓

Respuesta correcta
```

Una prueba negativa comprueba que una acción no permitida se rechaza correctamente.

Ejemplo:

```text
Usuario autenticado

        ↓

Intenta consultar la reserva de otro usuario

        ↓

Acceso denegado
```

Ambos tipos de prueba son necesarios.

## Qué puede probarse

Las pruebas de seguridad pueden centrarse en:

- validación de entradas;
- autenticación;
- autorización;
- sesiones;
- subida de archivos;
- acceso a datos;
- APIs;
- errores;
- configuración de producción.

No es necesario probar todo de una sola vez.

Conviene seleccionar flujos concretos.

## Probar entradas inválidas

Una aplicación debe rechazar datos que no cumplen las reglas definidas.

Ejemplos:

```text
Edad negativa

Correo sin formato válido

Fecha imposible

Texto demasiado largo

Valor fuera de rango
```

La prueba debe comprobar:

```text
[ ] La petición se rechaza

[ ] El servidor valida el dato

[ ] No se produce un error interno

[ ] El usuario recibe un mensaje controlado
```

## Probar que JavaScript no es el único control

Una validación en cliente puede modificarse o evitarse.

Por tanto, una prueba útil consiste en enviar una petición directamente al servidor con un valor que la interfaz no permitiría.

Ejemplo:

```text
Formulario

        ↓

JavaScript impide enviar edad = -5
```

Pero la prueba debe comprobar también:

```text
Petición modificada

edad = -5

        ↓

Servidor
```

El resultado esperado es que el servidor rechace igualmente el valor.

## Probar autenticación

Algunas comprobaciones básicas:

```text
[ ] Credenciales válidas permiten iniciar sesión

[ ] Credenciales incorrectas se rechazan

[ ] No se puede acceder a recursos protegidos sin sesión

[ ] El cierre de sesión invalida el acceso

[ ] Una sesión inválida no permite continuar
```

La prueba debe observar el resultado real, no únicamente la interfaz.

## Probar autorización

La autorización es uno de los controles más importantes que deben verificarse.

Ejemplo:

```text
Usuario A

        ↓

Accede a /reservas/25

        ↓

La reserva pertenece a A
```

Resultado:

```text
Acceso permitido
```

Después:

```text
Usuario A

        ↓

Cambia 25 por 26

        ↓

La reserva pertenece a B
```

Resultado esperado:

```text
Acceso denegado
```

La prueba demuestra que el control depende del recurso, no únicamente de que exista una sesión.

## Probar roles

Cuando existen distintos roles, deben verificarse sus límites.

Ejemplo:

```text
Usuario normal

        ↓

/administracion
```

Resultado esperado:

```text
403

o

Acceso denegado
```

También debe comprobarse que el rol autorizado sí puede acceder.

## Probar subida de archivos

Las pruebas pueden incluir:

- archivo permitido;
- extensión no permitida;
- tamaño excesivo;
- nombre extraño;
- archivo vacío;
- archivo con nombre repetido.

Ejemplo:

```text
imagen.jpg
```

Resultado:

```text
Aceptado
```

Ejemplo:

```text
archivo.php
```

Resultado esperado:

```text
Rechazado
```

El comportamiento dependerá de las reglas definidas por la aplicación.

## Probar errores

Una prueba también debe comprobar cómo falla la aplicación.

Por ejemplo:

```text
Solicitar recurso inexistente

Enviar dato inválido

Provocar una operación no permitida
```

La respuesta no debería mostrar:

- rutas internas;
- trazas completas;
- consultas SQL;
- credenciales;
- información de depuración.

## Probar códigos de estado

Los códigos HTTP ayudan a comprobar el comportamiento.

Ejemplos habituales:

```text
200 → operación correcta

400 → petición incorrecta

401 → autenticación requerida

403 → acceso no permitido

404 → recurso no encontrado

422 → datos no válidos

500 → error interno
```

El código exacto dependerá de la aplicación y del framework.

Lo importante es que la respuesta sea coherente con la situación.

## Probar APIs

Una API debe verificarse igual que una interfaz web.

Puede probarse:

- JSON válido;
- JSON incompleto;
- campos inesperados;
- usuario sin autenticar;
- recurso ajeno;
- método HTTP incorrecto.

Ejemplo:

```text
PUT /api/reservas/25
```

La prueba puede modificar:

```text
25 → 26
```

y comprobar si la autorización continúa funcionando.

## Repetibilidad

Una prueba útil debería poder repetirse.

Por ejemplo:

```text
Condición inicial

        ↓

Petición

        ↓

Resultado esperado
```

Esto permite ejecutar la misma comprobación después de modificar el código.

## Registrar el resultado

No es necesario generar un informe extenso.

Para cada prueba puede bastar con:

```text
Prueba

Resultado esperado

Resultado obtenido

Estado
```

Ejemplo:

```text
Prueba:
usuario A intenta editar reserva de B

Esperado:
403

Obtenido:
403

Estado:
correcto
```

## Aplicación a los retos

En los retos DAW, las pruebas pueden integrarse durante el desarrollo.

Ejemplo:

```text
Implementar edición de reservas

        ↓

Probar caso válido

        ↓

Probar ID manipulado

        ↓

Corregir si es necesario

        ↓

Continuar
```

Así, la verificación no se acumula para el final.

## Aplicación a TxurdiGest

Una pequeña batería de pruebas para la gestión de reservas podría incluir:

```text
[ ] Crear una reserva válida

[ ] Enviar fecha inválida

[ ] Acceder sin autenticar

[ ] Consultar una reserva propia

[ ] Consultar una reserva ajena

[ ] Modificar el ID en la petición

[ ] Provocar un error controlado
```

Cada prueba debe tener un resultado esperado antes de ejecutarse.

## Idea clave

> Una prueba de seguridad útil no busca comportamientos al azar: define una situación, una acción y un resultado seguro esperado.
