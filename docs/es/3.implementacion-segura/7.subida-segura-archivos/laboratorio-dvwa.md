# Laboratorio DVWA: subida de archivos

En este laboratorio se analizará una implementación vulnerable de subida de archivos para comprender por qué no es suficiente confiar en el nombre, la extensión o el tipo declarado por el navegador.

El objetivo no es conseguir ejecutar código en un servidor, sino identificar qué decisiones de desarrollo convierten una funcionalidad de subida en insegura y cómo corregirlas.

## Escenario

Utilizaremos **DVWA (Damn Vulnerable Web Application)** en un entorno local y controlado.

Trabajaremos con el ejercicio de subida de archivos disponible en DVWA.

La secuencia será:

```text
Archivo recibido
      ↓
validación insuficiente
      ↓
almacenamiento inseguro
      ↓
archivo accesible desde el servidor
```

## 1. Observar el comportamiento normal

Accede al ejercicio de subida de archivos e intenta subir primero un archivo permitido, por ejemplo una imagen.

Observa:

- qué tipos acepta la interfaz;
- qué mensaje devuelve;
- dónde indica que se ha almacenado el archivo;
- si el archivo queda accesible posteriormente.

La aplicación parece funcionar correctamente cuando se utiliza de la forma prevista.

## 2. Revisar qué información controla el cliente

Al seleccionar un archivo, el navegador envía información como:

```text
nombre
tipo MIME declarado
tamaño
contenido
```

Por ejemplo:

```text
foto.jpg
image/jpeg
125 KB
```

Estos datos forman parte de la petición.

Por tanto, el servidor no debería asumir que son correctos simplemente porque proceden del navegador.

## 3. Analizar la validación utilizada

Utiliza la opción de DVWA que permite visualizar el código fuente del ejercicio.

Localiza las comprobaciones que se realizan antes de guardar el archivo.

Busca especialmente si la aplicación utiliza únicamente elementos como:

```php
$_FILES['archivo']['name']
```

o:

```php
$_FILES['archivo']['type']
```

o una comprobación simple de extensión.

La pregunta importante es:

> **¿Cómo decide realmente el servidor que un archivo es seguro?**

## 4. Identificar una validación insuficiente

Una implementación demasiado simple podría comprobar solo el nombre:

```php
$nombre = $_FILES['archivo']['name'];

if (!str_ends_with($nombre, '.jpg')) {
    exit('Archivo no permitido.');
}
```

El problema es que el nombre está controlado por el cliente.

Otro ejemplo insuficiente sería:

```php
if (
    $_FILES['archivo']['type']
    !== 'image/jpeg'
) {
    exit('Archivo no permitido.');
}
```

El tipo enviado por el navegador tampoco constituye una prueba fiable del contenido real.

## 5. Comprobar el comportamiento en DVWA

Realiza únicamente las pruebas necesarias para observar cómo responde el ejercicio ante archivos que no cumplen exactamente lo esperado.

No es necesario intentar ejecutar contenido ni desarrollar técnicas de evasión.

El objetivo es responder a estas preguntas:

1. ¿Qué comprueba DVWA?
2. ¿Qué información procede del cliente?
3. ¿Dónde guarda el archivo?
4. ¿Queda dentro de una ubicación accesible públicamente?
5. ¿Podría el servidor interpretar algún archivo almacenado como código?

!!! warning "Entorno controlado"

    Las pruebas deben limitarse a DVWA u otros laboratorios diseñados expresamente para formación en seguridad.

## 6. Revisar la ubicación de almacenamiento

Uno de los aspectos más importantes es comprobar dónde se guardan los archivos.

Una estructura de riesgo sería:

```text
/var/www/html/uploads/
```

si esa carpeta es pública y el servidor web puede interpretar determinados tipos de archivo.

Conceptualmente:

```text
Archivo externo
      ↓
directorio público
      ↓
servidor web
      ↓
posible interpretación
```

Una opción más segura es:

```text
/var/www/app/storage/uploads/
```

fuera del directorio público.

Después, la aplicación controla la descarga.

## 7. Diseñar una validación segura

Una implementación más robusta debe combinar varias comprobaciones.

### Comprobar el resultado de la subida

```php
if (
    $_FILES['archivo']['error']
    !== UPLOAD_ERR_OK
) {
    exit('Error de subida.');
}
```

### Limitar el tamaño

```php
$maxSize = 5 * 1024 * 1024;

if ($_FILES['archivo']['size'] > $maxSize) {
    exit('Archivo demasiado grande.');
}
```

### Detectar el MIME en el servidor

```php
$finfo = new finfo(FILEINFO_MIME_TYPE);

$mime = $finfo->file(
    $_FILES['archivo']['tmp_name']
);
```

### Utilizar una lista cerrada

```php
$tiposPermitidos = [
    'image/jpeg' => 'jpg',
    'image/png' => 'png'
];

if (!isset($tiposPermitidos[$mime])) {
    exit('Tipo no permitido.');
}
```

### Generar el nombre en el servidor

```php
$extension = $tiposPermitidos[$mime];

$nombreSeguro = bin2hex(
    random_bytes(16)
) . '.' . $extension;
```

### Guardar mediante `move_uploaded_file()`

```php
$rutaDestino =
    '/var/www/app/storage/uploads/'
    . $nombreSeguro;

move_uploaded_file(
    $_FILES['archivo']['tmp_name'],
    $rutaDestino
);
```

## 8. Comparar ambos modelos

### Implementación insegura

```text
nombre enviado por cliente
        ↓
comprobación superficial
        ↓
mismo nombre
        ↓
directorio público
```

### Implementación segura

```text
archivo recibido
      ↓
comprobar error
      ↓
comprobar tamaño
      ↓
analizar contenido
      ↓
lista cerrada de tipos
      ↓
nombre generado
      ↓
ubicación controlada
```

La seguridad no depende de una única comprobación.

## 9. Aplicar defensa en varias capas

Incluso una validación correcta puede complementarse con controles adicionales.

Por ejemplo:

```text
Aplicación
    ↓
valida tipo y tamaño

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

Esta combinación reduce el impacto de posibles errores.

## Aplicación a TxurdiGest

Supongamos que TxurdiGest permite subir un justificante PDF.

Una implementación insegura podría hacer:

```php
$nombre = $_FILES['documento']['name'];

move_uploaded_file(
    $_FILES['documento']['tmp_name'],
    '/var/www/html/uploads/' . $nombre
);
```

La aplicación está confiando en el nombre enviado y guarda directamente el archivo en una ubicación pública.

Una implementación más segura debería aplicar:

```text
usuario autenticado
      ↓
autorización
      ↓
máximo 5 MB
      ↓
MIME application/pdf
      ↓
nombre generado por servidor
      ↓
almacenamiento privado
      ↓
registro de metadatos
```

## Qué debe quedar demostrado

Al finalizar el laboratorio debe quedar claro que:

- el nombre del archivo está controlado por el cliente;
- la extensión no demuestra el tipo real del contenido;
- `$_FILES['type']` no debe considerarse una prueba fiable;
- el servidor debe analizar y limitar los archivos aceptados;
- el nombre físico debería generarse en el servidor;
- almacenar archivos fuera del directorio público reduce la exposición;
- la configuración del servidor y los permisos forman parte de la protección;
- una subida segura requiere combinar varios controles.
