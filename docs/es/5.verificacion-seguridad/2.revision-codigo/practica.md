# Práctica: revisión de código segura

## Contexto

La revisión de código permite comprobar si una funcionalidad aplica correctamente las decisiones de seguridad previstas.

En esta práctica no se revisará todo el proyecto.

Cada equipo seleccionará una funcionalidad concreta y seguirá su flujo completo.

Ejemplos adecuados:

- iniciar sesión;
- crear una reserva;
- editar un perfil;
- modificar un pedido;
- subir un archivo;
- consultar un recurso protegido.

## Objetivo

Revisar una funcionalidad de la aplicación y detectar posibles problemas relacionados con:

- validación;
- acceso a datos;
- autenticación;
- autorización;
- salida;
- secretos;
- gestión de errores.

La revisión debe terminar con una decisión:

```text
Correcto

o

Necesita corrección
```

## Organización

La práctica puede realizarse:

- dentro del propio equipo;
- por parejas;
- mediante revisión cruzada entre equipos.

Cuando sea posible, es recomendable que una persona revise código que no haya escrito ella misma.

## Paso 1. Seleccionar una funcionalidad

Elegir una funcionalidad que tenga un flujo claro.

Ejemplo:

```text
Editar reserva
```

Identificar:

```text
Entrada

    ↓

Controlador o lógica

    ↓

Acceso a datos

    ↓

Comprobación de permisos

    ↓

Respuesta
```

## Paso 2. Identificar las entradas

Anotar qué datos recibe la funcionalidad.

Por ejemplo:

```text
ID de reserva

fecha

número de personas

usuario autenticado
```

Comprobar:

```text
[ ] Los datos se validan en el servidor

[ ] Se comprueba el tipo de dato

[ ] Se comprueban rangos o formatos

[ ] Los valores inesperados se rechazan
```

## Paso 3. Revisar el acceso a datos

Localizar las consultas relacionadas con la funcionalidad.

Comprobar:

```text
[ ] Se utilizan consultas preparadas o mecanismos equivalentes

[ ] No se construyen consultas concatenando datos del usuario

[ ] El usuario de base de datos tiene permisos adecuados
```

Ejemplo problemático:

```php
$sql = "SELECT * FROM reservas WHERE id = " . $_GET['id'];
```

Ejemplo más seguro:

```php
$stmt = $pdo->prepare(
    "SELECT * FROM reservas WHERE id = ?"
);

$stmt->execute([$id]);
```

## Paso 4. Revisar autenticación

Si la funcionalidad requiere usuario autenticado, comprobar:

```text
[ ] Se verifica que existe una sesión válida

[ ] La funcionalidad no puede ejecutarse sin autenticación

[ ] El cierre de sesión invalida correctamente la sesión
```

## Paso 5. Revisar autorización

Comprobar que no basta con estar autenticado.

Ejemplo:

```text
Usuario A

        ↓

/reservas/25/editar
```

La aplicación debe comprobar si la reserva pertenece al usuario o si tiene permiso para modificarla.

Checklist:

```text
[ ] Se comprueba el propietario o rol

[ ] La autorización se realiza antes de modificar datos

[ ] Cambiar el identificador no permite acceder a recursos ajenos
```

## Paso 6. Revisar la salida

Comprobar si la funcionalidad muestra información recibida del usuario.

Ejemplo:

```php
echo $nombre;
```

Preguntas:

```text
[ ] ¿El dato se muestra de forma segura?

[ ] ¿Puede interpretarse como HTML?

[ ] ¿Puede incluir contenido introducido por un usuario?
```

## Paso 7. Revisar errores

Comprobar qué ocurre si algo falla.

Ejemplo:

```text
Reserva inexistente

Error de base de datos

Dato inválido
```

La aplicación debe evitar mostrar:

- rutas internas;
- consultas SQL;
- excepciones completas;
- credenciales;
- información de depuración.

Checklist:

```text
[ ] El usuario recibe un mensaje controlado

[ ] El error técnico puede registrarse internamente

[ ] No se muestran detalles sensibles
```

## Paso 8. Revisar secretos

Buscar en los archivos relacionados con la funcionalidad:

```text
contraseñas

tokens

claves API

credenciales

claves privadas
```

Comprobar:

```text
[ ] No existen secretos escritos directamente en el código

[ ] La configuración sensible se obtiene del entorno
```

## Paso 9. Registrar hallazgos

No es necesario redactar un informe largo.

Para cada problema encontrado basta con indicar:

```text
Problema

Dónde aparece

Riesgo

Corrección propuesta
```

Ejemplo:

```text
Problema:
no se comprueba el propietario de la reserva

Dónde:
controlador de edición

Riesgo:
un usuario podría modificar reservas ajenas

Corrección:
comprobar el usuario propietario antes de actualizar
```

## Paso 10. Corregir y volver a revisar

Si se detecta un problema:

```text
Detectar

    ↓

Corregir

    ↓

Revisar de nuevo
```

La revisión termina cuando la funcionalidad cumple los controles previstos.

## Evidencia

La entrega puede contener:

- funcionalidad revisada;
- checklist completado;
- uno o dos hallazgos relevantes;
- correcciones realizadas;
- fragmentos de código necesarios para justificar la revisión.

No es necesario entregar grandes cantidades de código.

## Aplicación a TxurdiGest

Ejemplo de funcionalidad:

```text
Editar una reserva
```

Posibles puntos de revisión:

```text
ID recibido

        ↓

Validación

        ↓

Consulta

        ↓

Comprobación de propietario

        ↓

Actualización

        ↓

Respuesta
```

El objetivo es comprobar todo el flujo, no una única línea.

## Checklist final

```text
[ ] Entradas revisadas

[ ] Consultas revisadas

[ ] Autenticación revisada

[ ] Autorización revisada

[ ] Salida revisada

[ ] Errores revisados

[ ] Secretos revisados

[ ] Problemas corregidos o documentados
```

## Idea clave

> Una revisión de código útil sigue el flujo de una funcionalidad y comprueba, punto por punto, dónde se aplican los controles de seguridad.
