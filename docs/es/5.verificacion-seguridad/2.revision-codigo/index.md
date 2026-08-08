# Revisión de código

La revisión de código permite detectar decisiones inseguras antes de que lleguen a producción.

No consiste en leer todo el proyecto línea por línea sin un criterio.

Una revisión útil sigue el flujo de una funcionalidad.

```text
Entrada

    ↓

Validación

    ↓

Procesamiento

    ↓

Acceso a datos

    ↓

Autenticación / autorización

    ↓

Respuesta
```

La pregunta principal es:

> ¿Dónde se aplican realmente los controles que deberían proteger este flujo?

## Revisar controles, no volver a implementarlos

En los bloques anteriores se ha trabajado cómo aplicar distintos mecanismos de seguridad.

En este bloque no se pretende volver a explicarlos.

La revisión debe aprender a localizar:

- controles ausentes;
- controles aplicados en un lugar incorrecto;
- controles que dependen únicamente del cliente;
- cambios que han debilitado una implementación segura;
- diferencias entre lo previsto y lo implementado.

## Entrada de datos

Una aplicación puede recibir información desde:

- formularios;
- parámetros de URL;
- JSON;
- cookies;
- cabeceras;
- archivos;
- APIs.

Durante la revisión debemos localizar dónde se valida cada dato.

Ejemplo:

```php
$edad = $_POST['edad'];
```

Preguntas de revisión:

```text
¿Se valida después de recibirlo?

¿Se comprueba el tipo?

¿Se comprueba el rango?

¿Se rechazan valores inesperados?

¿La comprobación existe también en el servidor?
```

La validación JavaScript puede mejorar la experiencia de usuario, pero no debe ser el único control.

## Salida

Cuando la aplicación muestra datos debemos identificar si proceden de una fuente no confiable.

Ejemplo:

```php
echo $comentario;
```

Preguntas:

```text
¿El dato procede del usuario?

¿Se trata antes de incorporarlo a HTML?

¿Podría interpretarse como código?
```

La revisión debe reconocer si se utiliza un mecanismo de salida segura adecuado al contexto.

## Acceso a datos

La revisión debe buscar especialmente consultas construidas concatenando datos recibidos.

Patrón que requiere revisión:

```php
$sql = "SELECT * FROM usuarios WHERE email = '" . $email . "'";
```

Frente a mecanismos parametrizados, por ejemplo:

```php
$stmt = $pdo->prepare(
    "SELECT * FROM usuarios WHERE email = ?"
);

$stmt->execute([$email]);
```

La finalidad no es memorizar una sintaxis.

Es comprobar que los datos del usuario no modifican la estructura de la consulta.

## Autenticación

La revisión debe localizar dónde se comprueba la identidad del usuario y cómo se mantiene la sesión.

Comprobar:

```text
[ ] Las contraseñas se almacenan mediante mecanismos adecuados

[ ] La comprobación de credenciales se realiza en el servidor

[ ] La sesión se inicia correctamente

[ ] El cierre de sesión invalida el acceso

[ ] No se confía en datos controlados por el cliente para identificar al usuario
```

## Autorización

La autorización debe revisarse sobre cada recurso protegido.

Ejemplo:

```text
Usuario autenticado

        ↓

/reservas/25/editar
```

No basta con comprobar que existe una sesión.

También debemos localizar:

```text
¿La reserva pertenece al usuario?

¿Tiene el rol o permiso necesario?

¿La comprobación se ejecuta antes de realizar la operación?
```

## Identificadores

Los identificadores recibidos desde el cliente pueden modificarse.

```text
/reservas/25

        ↓

/reservas/26
```

La revisión debe comprobar que el servidor vuelve a autorizar el acceso al recurso solicitado.

## Secretos

Buscar en el código y en el repositorio:

- contraseñas;
- claves API;
- tokens;
- credenciales de base de datos;
- claves privadas;
- secretos de aplicación.

Ejemplo incorrecto:

```php
$password = "mi-password-produccion";
```

El objetivo de la revisión es confirmar que la configuración sensible está fuera del código y del repositorio.

## Subida de archivos

Cuando exista esta funcionalidad, comprobar:

```text
[ ] Se limita el tamaño

[ ] Se valida el tipo

[ ] Se controla el nombre

[ ] El almacenamiento se realiza en una ubicación adecuada

[ ] Los archivos subidos no pueden ejecutarse

[ ] No pueden sobrescribirse archivos arbitrarios
```

## APIs

Una API debe revisarse con los mismos criterios que cualquier otra entrada a la aplicación.

Comprobar:

- validación de JSON;
- autenticación;
- autorización por recurso;
- códigos HTTP;
- información devuelta;
- CORS cuando corresponda.

## Errores

Buscar puntos en los que una excepción o detalle técnico pueda enviarse directamente al usuario.

Ejemplo que debe revisarse:

```php
catch (Exception $e) {
    echo $e->getMessage();
}
```

En producción, el detalle técnico debe quedar en el registro interno y el usuario debe recibir una respuesta controlada.

## Revisar cambios concretos

No siempre es necesario revisar la aplicación completa.

Una estrategia útil es:

```text
Cambio realizado

        ↓

Código afectado

        ↓

Controles relacionados

        ↓

Comprobación
```

Esto permite integrar la seguridad en el trabajo habitual del equipo.

## Revisión entre iguales

La revisión entre compañeros puede organizarse de forma sencilla.

### Autor

Explica:

- qué funcionalidad ha desarrollado;
- qué datos recibe;
- qué controles deberían aplicarse.

### Revisor

Localiza:

- validación;
- acceso a datos;
- autenticación;
- autorización;
- salida;
- secretos;
- errores.

### Equipo

Decide:

```text
Correcto

o

Necesita corrección
```

La revisión se centra en el código y en las decisiones técnicas, no en la persona que lo ha desarrollado.

## Aplicación al Reto 1

En el proyecto con PHP, JavaScript y CSS3 debe distinguirse claramente entre:

```text
JavaScript

→ apoyo a la interfaz y experiencia de usuario


PHP

→ controles efectivos en el servidor
```

La revisión debe comprobar especialmente que la seguridad no dependa únicamente de JavaScript.

## Aplicación al Reto 2

En Laravel, Vue 3 y Tailwind se aplica el mismo criterio:

```text
Vue

→ interfaz y experiencia de usuario


Laravel

→ validación, autenticación, autorización y acceso a datos
```

También deben revisarse las rutas y recursos protegidos, las respuestas de la API y la configuración que afecta al servidor.

## Guía breve de revisión

```text
[ ] ¿Los datos recibidos se validan en el servidor?

[ ] ¿La salida se genera de forma segura?

[ ] ¿El acceso a datos utiliza mecanismos parametrizados?

[ ] ¿La autenticación se comprueba en el servidor?

[ ] ¿La autorización se aplica a cada recurso protegido?

[ ] ¿Los secretos están fuera del código?

[ ] ¿Las subidas de archivos están controladas cuando existen?

[ ] ¿Las APIs aplican los mismos controles?

[ ] ¿Los errores se gestionan de forma segura?
```

## Aplicación a TxurdiGest

Puede seleccionarse una funcionalidad concreta:

```text
Editar reserva
```

y seguir su flujo:

1. cómo recibe el identificador;
2. cómo valida los datos;
3. cómo obtiene la reserva;
4. cómo comprueba el propietario;
5. cómo actualiza la base de datos;
6. qué respuesta devuelve.

## Idea clave

> Revisar código de forma segura significa localizar los controles que deberían proteger un flujo y comprobar que están realmente presentes en el lugar adecuado.
