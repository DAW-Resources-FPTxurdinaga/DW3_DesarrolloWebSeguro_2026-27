# Revisión de código

La revisión de código permite detectar problemas de seguridad antes de que lleguen a producción.

No se trata de leer todo el proyecto línea por línea sin un criterio.

Una revisión útil se centra en decisiones concretas:

```text
Entrada

    ↓

Procesamiento

    ↓

Acceso a datos

    ↓

Autenticación y autorización

    ↓

Respuesta
```

El objetivo es identificar puntos donde una decisión incorrecta puede introducir un riesgo.

## Qué revisar

La revisión debe apoyarse en los contenidos trabajados durante el módulo.

Entre los aspectos principales:

- validación de entradas;
- salida segura;
- acceso a datos;
- autenticación;
- autorización;
- sesiones;
- subida de archivos;
- APIs;
- secretos;
- gestión de errores.

## Revisar la entrada de datos

Una aplicación recibe información desde múltiples orígenes:

- formularios;
- parámetros de URL;
- JSON;
- cookies;
- cabeceras;
- archivos;
- APIs.

La pregunta principal es:

> ¿Dónde se valida realmente la información?

La validación en JavaScript mejora la experiencia del usuario, pero no sustituye la validación en el servidor.

Ejemplo de revisión:

```php
$edad = $_POST['edad'];
```

La pregunta no es únicamente si la variable existe.

También debemos comprobar:

```text
¿Se valida?

¿Se comprueba el tipo?

¿Se comprueba el rango?

¿Se rechazan valores inesperados?
```

## Revisar la salida

Los datos mostrados en una página deben tratarse de forma segura.

Ejemplo:

```php
echo $comentario;
```

Durante una revisión debemos preguntarnos:

```text
¿Este dato procede del usuario?

¿Se escapa antes de mostrarlo?

¿Puede interpretarse como HTML o JavaScript?
```

Una alternativa habitual en PHP:

```php
echo htmlspecialchars(
    $comentario,
    ENT_QUOTES,
    'UTF-8'
);
```

## Revisar el acceso a datos

Una revisión debe identificar consultas construidas mediante concatenación.

Ejemplo problemático:

```php
$sql = "SELECT * FROM usuarios WHERE email = '" . $email . "'";
```

Debe comprobarse si se utilizan consultas preparadas.

```php
$stmt = $pdo->prepare(
    "SELECT * FROM usuarios WHERE email = ?"
);

$stmt->execute([$email]);
```

La revisión no consiste en memorizar una sintaxis concreta.

Consiste en reconocer decisiones que reducen el riesgo de inyección.

## Revisar autenticación

La autenticación responde a:

> ¿Quién es el usuario?

Durante la revisión pueden comprobarse aspectos como:

- contraseñas almacenadas mediante hash;
- comparación segura de contraseñas;
- sesiones correctamente iniciadas;
- cierre de sesión;
- regeneración del identificador de sesión cuando proceda.

Ejemplo en PHP:

```php
password_verify(
    $password,
    $hash
);
```

## Revisar autorización

La autorización responde a:

> ¿Qué puede hacer este usuario?

Un error frecuente es comprobar únicamente que el usuario está autenticado.

Ejemplo:

```text
Usuario autenticado

        ↓

/reservas/25/editar
```

La revisión debe comprobar además:

```text
¿La reserva 25 pertenece al usuario?

¿Tiene el rol necesario?

¿Existe una comprobación antes de ejecutar la acción?
```

## Revisar identificadores

Los identificadores incluidos en una URL o petición no deben considerarse fiables.

Ejemplo:

```text
/reservas/25
```

Debe asumirse que el usuario puede cambiar:

```text
25 → 26
```

Por tanto, la aplicación debe verificar que el usuario tiene permiso sobre el recurso solicitado.

## Revisar secretos

Una revisión de código debe buscar:

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

La configuración sensible debe estar fuera del código y del repositorio.

## Revisar subida de archivos

Una funcionalidad de subida de archivos requiere varias comprobaciones.

La revisión puede preguntar:

```text
¿Se limita el tamaño?

¿Se valida el tipo?

¿Se genera un nombre seguro?

¿El archivo se guarda fuera de zonas ejecutables?

¿Puede un usuario sobrescribir archivos?
```

No debe confiarse únicamente en el nombre o extensión enviados por el navegador.

## Revisar APIs

En una API deben revisarse las mismas decisiones de seguridad.

Por ejemplo:

- validación de JSON recibido;
- autenticación;
- autorización;
- códigos de estado;
- información devuelta;
- CORS cuando corresponda.

Una API no debe considerarse segura simplemente porque no tenga interfaz gráfica.

## Revisar errores

Durante la revisión debe comprobarse si el código muestra detalles internos.

Ejemplo problemático:

```php
catch (Exception $e) {

    echo $e->getMessage();

}
```

En producción es preferible registrar el detalle y mostrar un mensaje controlado.

## Revisar cambios, no solo aplicaciones completas

En un entorno profesional no siempre se revisa todo el proyecto.

Es habitual revisar:

```text
Cambio realizado

        ↓

Código afectado

        ↓

Riesgo introducido

        ↓

Comprobación
```

Esto permite integrar la revisión en el trabajo diario.

## Revisión entre iguales

La revisión entre compañeros puede seguir un procedimiento sencillo.

### Autor

Explica:

- qué funcionalidad ha desarrollado;
- qué datos recibe;
- qué decisiones de seguridad ha aplicado.

### Revisor

Comprueba:

- entradas;
- acceso a datos;
- autenticación;
- autorización;
- salida;
- configuración relacionada.

### Equipo

Decide:

```text
Correcto

o

Necesita corrección
```

La revisión debe centrarse en el código y en las decisiones técnicas, no en la persona que lo ha desarrollado.

## Preguntas de revisión

Una lista breve puede servir como guía:

```text
[ ] ¿Los datos recibidos se validan en el servidor?

[ ] ¿La salida generada es segura?

[ ] ¿Las consultas utilizan parámetros?

[ ] ¿La autenticación está correctamente implementada?

[ ] ¿La autorización se comprueba en cada recurso protegido?

[ ] ¿Los secretos están fuera del código?

[ ] ¿Las subidas de archivos están controladas?

[ ] ¿Los errores se gestionan de forma segura?
```

## Aplicación a TxurdiGest

Una revisión de TxurdiGest podría seleccionar una funcionalidad concreta.

Por ejemplo:

```text
Editar reserva
```

El equipo revisaría:

1. cómo recibe el identificador;
2. cómo valida los datos;
3. cómo obtiene la reserva;
4. cómo comprueba el propietario;
5. cómo actualiza la base de datos;
6. qué respuesta devuelve ante un error.

Esta revisión sigue el flujo real de la funcionalidad.

## Idea clave

> Revisar código de forma segura no significa buscar errores al azar. Significa comprobar sistemáticamente las decisiones que protegen cada flujo de la aplicación.
