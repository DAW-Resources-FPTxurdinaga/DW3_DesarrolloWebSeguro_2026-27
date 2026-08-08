# Práctica: diseño y ejecución de pruebas de seguridad

## Contexto

Una prueba de seguridad debe comprobar una situación concreta y comparar el resultado obtenido con el comportamiento esperado.

En esta práctica cada equipo diseñará y ejecutará una pequeña batería de pruebas sobre una funcionalidad de su aplicación.

No se busca probar todo el proyecto.

El objetivo es seleccionar unos pocos casos representativos y ejecutarlos de forma ordenada.

## Objetivo

Diseñar, ejecutar y registrar pruebas relacionadas con:

- validación;
- autenticación;
- autorización;
- errores;
- APIs o formularios;
- acceso a recursos.

Cada prueba debe indicar claramente:

```text
Situación inicial

        ↓

Acción realizada

        ↓

Resultado esperado

        ↓

Resultado obtenido
```

## Paso 1. Seleccionar una funcionalidad

Elegir una funcionalidad que permita realizar pruebas positivas y negativas.

Ejemplos:

- editar una reserva;
- consultar un pedido;
- modificar un perfil;
- subir un archivo;
- acceder a una zona privada;
- consumir un endpoint de una API.

## Paso 2. Definir el caso válido

Antes de probar situaciones incorrectas, comprobar que la funcionalidad funciona correctamente.

Ejemplo:

```text
Usuario autenticado

        ↓

Edita su propia reserva

        ↓

Datos válidos

        ↓

Actualización correcta
```

Registrar:

```text
Prueba:
edición de reserva propia

Esperado:
200 o redirección correcta

Obtenido:
________________

Estado:
________________
```

## Paso 3. Probar una entrada inválida

Modificar un dato de entrada.

Ejemplos:

```text
Fecha imposible

Número negativo

Texto demasiado largo

Campo obligatorio vacío
```

Registrar:

```text
Prueba:
________________

Dato modificado:
________________

Esperado:
petición rechazada

Obtenido:
________________

Estado:
________________
```

Comprobar:

```text
[ ] El servidor rechaza el valor

[ ] No se produce un error interno

[ ] El mensaje mostrado es controlado
```

## Paso 4. Evitar la validación del cliente

Si existe validación JavaScript, comprobar que el servidor no depende de ella.

Puede utilizarse:

- DevTools;
- Burp Suite;
- modificación directa de la petición.

Ejemplo:

```text
Interfaz

no permite:

personas = -2
```

Modificar la petición:

```text
personas = -2
```

Resultado esperado:

```text
El servidor rechaza la petición
```

Registrar el resultado.

## Paso 5. Probar autenticación

Seleccionar una funcionalidad protegida.

Comprobar:

```text
[ ] Funciona con una sesión válida

[ ] Se rechaza sin sesión

[ ] Se rechaza con una sesión inválida

[ ] Después de cerrar sesión no se mantiene el acceso
```

Registrar al menos una evidencia.

## Paso 6. Probar autorización

Utilizar dos usuarios diferentes cuando sea posible.

Ejemplo:

```text
Usuario A

posee:

reserva 25
```

```text
Usuario B

posee:

reserva 26
```

Prueba:

```text
Usuario A

        ↓

intenta acceder a reserva 26
```

Resultado esperado:

```text
403

o

Acceso denegado
```

Registrar:

```text
Prueba:
usuario A accede a recurso de B

Esperado:
________________

Obtenido:
________________

Estado:
________________
```

## Paso 7. Manipular un identificador

Localizar una petición que incluya un identificador.

Ejemplo:

```text
GET /reservas/25
```

Modificar:

```text
25 → 26
```

Comprobar si la aplicación vuelve a verificar la autorización.

```text
[ ] El cambio de ID no permite acceder a recursos ajenos
```

## Paso 8. Probar errores

Provocar una situación controlada.

Ejemplos:

- recurso inexistente;
- dato inválido;
- operación no permitida.

Comprobar:

```text
[ ] No se muestran rutas internas

[ ] No se muestran consultas SQL

[ ] No aparece una traza completa

[ ] No se muestran credenciales

[ ] El usuario recibe un mensaje adecuado
```

## Paso 9. Revisar la respuesta HTTP

Utilizar DevTools o Burp Suite para observar:

- código de estado;
- cabeceras;
- cuerpo de la respuesta.

Ejemplo:

```text
Solicitud de recurso ajeno

        ↓

HTTP 403
```

La interfaz puede mostrar un mensaje, pero la prueba debe comprobar también la respuesta HTTP real.

## Paso 10. Registrar las pruebas

Utilizar una tabla o formato similar:

| Prueba | Resultado esperado | Resultado obtenido | Estado |
|---|---|---|---|
| Caso válido | Correcto | | |
| Entrada inválida | Rechazada | | |
| Sin autenticar | Acceso denegado | | |
| Recurso ajeno | Acceso denegado | | |
| Error controlado | Sin información sensible | | |

No es necesario realizar un gran número de pruebas.

Es preferible realizar pocas pruebas bien definidas.

## Corrección

Si una prueba falla:

```text
Prueba

    ↓

Resultado incorrecto

    ↓

Localizar causa

    ↓

Corregir

    ↓

Repetir prueba
```

Una prueba fallida no termina el proceso.

Sirve para descubrir una mejora necesaria.

## Evidencias

La entrega puede incluir:

- tabla de pruebas;
- capturas de DevTools o Burp Suite;
- petición modificada;
- respuesta HTTP;
- explicación breve de una corrección.

No deben incluirse:

- contraseñas;
- tokens;
- cookies de sesión completas;
- secretos;
- datos personales innecesarios.

## Aplicación a TxurdiGest

Ejemplo de batería mínima:

```text
[ ] Crear una reserva válida

[ ] Enviar una fecha inválida

[ ] Enviar personas = -2 evitando JavaScript

[ ] Acceder a reservas sin autenticar

[ ] Consultar una reserva propia

[ ] Cambiar el ID para solicitar una reserva ajena

[ ] Solicitar una reserva inexistente
```

Cada prueba debe tener definido previamente su resultado esperado.

## Checklist final

```text
[ ] Existe al menos un caso válido

[ ] Existe al menos una entrada inválida

[ ] Se ha probado autenticación

[ ] Se ha probado autorización

[ ] Se ha manipulado un identificador cuando procede

[ ] Se ha revisado una respuesta HTTP

[ ] Se ha probado un error controlado

[ ] Las pruebas tienen resultado esperado

[ ] Los fallos encontrados se han corregido o documentado
```

## Idea clave

> Probar seguridad significa definir qué debería impedir la aplicación, comprobarlo realmente y repetir la prueba después de cada corrección.
