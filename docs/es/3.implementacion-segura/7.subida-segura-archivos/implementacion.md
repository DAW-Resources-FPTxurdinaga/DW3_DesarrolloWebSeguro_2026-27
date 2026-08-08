# Implementación de una subida segura de archivos

La subida de archivos debe tratarse como cualquier otra entrada no confiable.

El servidor debe decidir si acepta el archivo, cómo lo almacena y quién podrá acceder posteriormente a él.

## Formulario de subida

El formulario debe utilizar:

```html
<form
    method="post"
    action="subir.php"
    enctype="multipart/form-data"
>
    <label for="documento">Documento PDF</label>

    <input
        type="file"
        id="documento"
        name="documento"
        accept="application/pdf"
        required
    >

    <button type="submit">Subir archivo</button>
</form>
```

El atributo:

```text
enctype="multipart/form-data"
```

es necesario para enviar archivos.

El atributo:

```text
accept="application/pdf"
```

ayuda al usuario a seleccionar el tipo esperado, pero no constituye una medida de seguridad.

El servidor debe comprobar igualmente el archivo recibido.

## Comprobar que existe una subida

En PHP, los archivos enviados aparecen en:

```php
$_FILES
```

Por ejemplo:

```php
if (!isset($_FILES['documento'])) {
    http_response_code(400);
    exit('No se ha recibido ningún archivo.');
}
```

Después podemos trabajar con:

```php
$archivo = $_FILES['documento'];
```

## Comprobar el código de error

PHP informa del resultado de la subida mediante:

```php
$archivo['error']
```

Antes de procesar el contenido debe comprobarse:

```php
if ($archivo['error'] !== UPLOAD_ERR_OK) {
    http_response_code(400);
    exit('No se ha podido completar la subida.');
}
```

No debe asumirse que el archivo está disponible correctamente solo porque exista una entrada en `$_FILES`.

## Limitar el tamaño

Supongamos que TxurdiGest permite documentos de hasta 5 MB.

Podemos definir:

```php
$maxSize = 5 * 1024 * 1024;
```

y comprobar:

```php
if ($archivo['size'] > $maxSize) {
    http_response_code(413);
    exit('El archivo supera el tamaño permitido.');
}
```

También conviene configurar límites coherentes en PHP mediante directivas como:

```text
upload_max_filesize
post_max_size
```

La aplicación y el servidor deben aplicar límites compatibles.

## No confiar en `$_FILES['type']`

El navegador puede enviar:

```php
$archivo['type']
```

pero ese valor forma parte de la petición y puede manipularse.

Por tanto, no es suficiente hacer:

```php
if ($archivo['type'] !== 'application/pdf') {
    exit;
}
```

El servidor debe analizar el archivo recibido.

## Detectar el MIME real con `finfo`

PHP permite inspeccionar el contenido mediante `finfo`.

```php
$finfo = new finfo(FILEINFO_MIME_TYPE);

$mime = $finfo->file(
    $archivo['tmp_name']
);
```

Después puede compararse con una lista permitida:

```php
$tiposPermitidos = [
    'application/pdf'
];

if (!in_array($mime, $tiposPermitidos, true)) {
    http_response_code(415);
    exit('Tipo de archivo no permitido.');
}
```

Esto resulta más fiable que confiar en el tipo declarado por el navegador.

## Utilizar una lista cerrada de tipos

Cuando se permiten varios formatos, puede relacionarse cada MIME con una extensión controlada por la aplicación.

Por ejemplo:

```php
$tiposPermitidos = [
    'application/pdf' => 'pdf',
    'image/jpeg' => 'jpg',
    'image/png' => 'png'
];
```

Después:

```php
if (!array_key_exists($mime, $tiposPermitidos)) {
    http_response_code(415);
    exit('Tipo de archivo no permitido.');
}
```

La extensión final puede obtenerse de la lista:

```php
$extension = $tiposPermitidos[$mime];
```

De esta forma, la aplicación no depende de la extensión proporcionada por el usuario.

## Generar el nombre en el servidor

No conviene guardar directamente:

```php
$archivo['name']
```

como nombre físico.

Una opción sencilla es generar un identificador aleatorio:

```php
$nombreSeguro = bin2hex(
    random_bytes(16)
) . '.' . $extension;
```

El resultado podría ser:

```text
e93ab87f4d9c2a730f4ca7e52891b1f2.pdf
```

El nombre original puede conservarse aparte si existe una necesidad funcional.

Por ejemplo, en base de datos:

```text
nombre_original = justificante_medico.pdf
nombre_fisico   = e93ab87f4d9c2a730f4ca7e52891b1f2.pdf
```

## Elegir una ubicación segura

Siempre que sea posible, los archivos deberían almacenarse fuera del directorio público del servidor web.

Por ejemplo:

```text
/var/www/app/
├── public/
│   └── index.php
│
└── storage/
    └── uploads/
```

La carpeta:

```text
storage/uploads/
```

no sería accesible directamente mediante una URL pública.

La aplicación controla posteriormente la descarga.

## Construir la ruta

Por ejemplo:

```php
$directorio = dirname(__DIR__) . '/storage/uploads';

$rutaDestino = $directorio . '/' . $nombreSeguro;
```

Conviene comprobar que el directorio existe y dispone de los permisos necesarios.

```php
if (!is_dir($directorio)) {
    throw new RuntimeException(
        'El directorio de almacenamiento no existe.'
    );
}
```

## Mover el archivo recibido

PHP proporciona:

```php
move_uploaded_file()
```

Esta función comprueba que el archivo procede realmente del mecanismo de subida HTTP de PHP.

```php
if (
    !move_uploaded_file(
        $archivo['tmp_name'],
        $rutaDestino
    )
) {
    http_response_code(500);
    exit('No se ha podido almacenar el archivo.');
}
```

No debería utilizarse simplemente `rename()` para este paso si se está procesando una subida HTTP.

## Ejemplo completo

Una implementación simplificada para aceptar únicamente PDF podría ser:

```php
<?php

if (!isset($_FILES['documento'])) {
    http_response_code(400);
    exit('No se ha recibido ningún archivo.');
}

$archivo = $_FILES['documento'];

if ($archivo['error'] !== UPLOAD_ERR_OK) {
    http_response_code(400);
    exit('Error durante la subida.');
}

$maxSize = 5 * 1024 * 1024;

if ($archivo['size'] > $maxSize) {
    http_response_code(413);
    exit('El archivo supera el tamaño permitido.');
}

$finfo = new finfo(FILEINFO_MIME_TYPE);

$mime = $finfo->file(
    $archivo['tmp_name']
);

$tiposPermitidos = [
    'application/pdf' => 'pdf'
];

if (!array_key_exists($mime, $tiposPermitidos)) {
    http_response_code(415);
    exit('Tipo de archivo no permitido.');
}

$extension = $tiposPermitidos[$mime];

$nombreSeguro = bin2hex(
    random_bytes(16)
) . '.' . $extension;

$directorio = dirname(__DIR__) .
    '/storage/uploads';

$rutaDestino = $directorio .
    '/' .
    $nombreSeguro;

if (
    !move_uploaded_file(
        $archivo['tmp_name'],
        $rutaDestino
    )
) {
    http_response_code(500);
    exit('No se ha podido almacenar el archivo.');
}
```

Este ejemplo cubre varias decisiones importantes:

```text
Archivo recibido
      ↓
comprobar error
      ↓
comprobar tamaño
      ↓
detectar MIME real
      ↓
permitir únicamente tipos previstos
      ↓
generar nombre
      ↓
guardar fuera del directorio público
```

## Registrar metadatos

En muchas aplicaciones será necesario registrar información en base de datos.

Por ejemplo:

```php
$sql = "
    INSERT INTO documentos (
        usuario_id,
        nombre_original,
        nombre_fisico,
        mime,
        tamano
    )
    VALUES (
        :usuario_id,
        :nombre_original,
        :nombre_fisico,
        :mime,
        :tamano
    )
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'usuario_id' => $usuarioId,
    'nombre_original' => $archivo['name'],
    'nombre_fisico' => $nombreSeguro,
    'mime' => $mime,
    'tamano' => $archivo['size']
]);
```

El nombre original se conserva únicamente como información.

No determina la ruta física utilizada por el servidor.

## Controlar quién puede subir

Antes de almacenar el archivo debe comprobarse la autorización.

Por ejemplo:

```php
session_start();

if (!isset($_SESSION['usuario_id'])) {
    http_response_code(401);
    exit;
}
```

Y, si la operación depende de un recurso concreto, también debe comprobarse el permiso correspondiente.

Por ejemplo:

```text
Alumno autenticado
      ↓
¿puede adjuntar archivos a esta entrega?
      ↓
sí
      ↓
procesar subida
```

## Controlar quién puede descargar

Guardar un archivo fuera del directorio público permite servirlo mediante un script PHP que compruebe primero los permisos.

Conceptualmente:

```text
GET /documentos/42
        ↓
comprobar sesión
        ↓
comprobar autorización
        ↓
localizar archivo
        ↓
enviar contenido
```

La aplicación puede impedir así que un usuario descargue archivos ajenos modificando una URL.

## No exponer rutas internas

La base de datos o la respuesta de la API no debería revelar rutas físicas como:

```text
/var/www/app/storage/uploads/e93ab87f.pdf
```

Es mejor utilizar un identificador lógico:

```text
documento_id = 42
```

y dejar que el servidor resuelva internamente la ubicación.

## No confiar en extensiones dobles

Un nombre como:

```text
imagen.jpg.php
```

o:

```text
documento.pdf.exe
```

demuestra por qué la extensión proporcionada por el cliente no debe decidir el tratamiento del archivo.

Si la aplicación genera el nombre final a partir del MIME permitido:

```php
$extension = $tiposPermitidos[$mime];
```

el nombre original deja de influir en la extensión física utilizada.

## Evitar ejecución en la carpeta de subida

Incluso si la aplicación valida correctamente los archivos, la configuración del servidor debería impedir la ejecución de contenido dentro de la carpeta destinada a documentos subidos.

La defensa debe existir en varias capas:

```text
Aplicación
    ↓
valida el archivo

Sistema de archivos
    ↓
limita permisos

Servidor web
    ↓
impide ejecución

Autorización
    ↓
controla acceso
```

La configuración concreta del servidor se trabajará en el bloque de despliegue seguro.

## Procesamiento adicional según el tipo

Algunos tipos de archivo pueden requerir comprobaciones específicas.

Por ejemplo, si una aplicación permite imágenes, puede resultar conveniente procesarlas con una biblioteca de imágenes y generar una nueva copia.

Esto reduce la dependencia del archivo original.

Sin embargo, no existe una única regla válida para todos los formatos.

La estrategia debe adaptarse a la funcionalidad real.

## Ejemplo en TxurdiGest

Supongamos que un alumno adjunta un justificante en PDF.

La aplicación podría aplicar:

```text
Usuario autenticado
      ↓
autorización sobre la entrega
      ↓
archivo recibido
      ↓
máximo 5 MB
      ↓
MIME application/pdf
      ↓
nombre generado
      ↓
almacenamiento privado
      ↓
registro en base de datos
```

El nombre visible podría seguir siendo:

```text
justificante_medico.pdf
```

mientras que físicamente se almacena como:

```text
f2d870fce9b342c3ab425fa6f979ee77.pdf
```

## Buenas prácticas

- Comprueba siempre `$_FILES['error']`.
- Limita el tamaño de los archivos.
- No confíes en `$_FILES['type']`.
- Detecta el MIME en el servidor.
- Utiliza listas cerradas de tipos permitidos.
- Genera el nombre físico en el servidor.
- Evita utilizar directamente el nombre original en rutas.
- Utiliza `move_uploaded_file()`.
- Almacena fuera del directorio público cuando sea posible.
- Impide la ejecución en las carpetas de subida.
- Comprueba autorización tanto para subir como para descargar.
- Conserva las rutas físicas únicamente en el servidor.
- Configura también límites y permisos a nivel de servidor.

## Resumen

- Los archivos recibidos son entradas no confiables.
- La extensión y el MIME declarado por el cliente no son suficientes.
- El servidor debe validar tamaño, tipo y resultado de la subida.
- El nombre y la ubicación deben estar controlados por la aplicación.
- Almacenar fuera del directorio público reduce la exposición.
- La seguridad de archivos incluye también autorización, permisos y configuración del servidor.
