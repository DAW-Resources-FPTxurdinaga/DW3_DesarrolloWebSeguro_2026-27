# Subida segura de archivos

Permitir que un usuario suba archivos introduce riesgos adicionales porque la aplicación recibe contenido que posteriormente puede almacenarse y quedar accesible desde el servidor.

El problema no consiste únicamente en comprobar la extensión del archivo.

Una implementación segura debe controlar:

- qué archivos se aceptan;
- cuánto pueden ocupar;
- qué tipo de contenido contienen;
- cómo se nombran;
- dónde se almacenan;
- con qué permisos;
- si pueden ejecutarse o no;
- quién puede acceder a ellos.

## Un archivo contiene más información que su nombre

Supongamos que un usuario selecciona:

```text
informe.pdf
```

La aplicación recibe varios elementos:

```text
Nombre declarado
Tipo MIME
Tamaño
Contenido
Código de error de subida
```

En PHP, esta información aparece normalmente en:

```php
$_FILES
```

Por ejemplo:

```php
$_FILES['documento']['name']
$_FILES['documento']['type']
$_FILES['documento']['size']
$_FILES['documento']['tmp_name']
$_FILES['documento']['error']
```

Ninguno de estos datos debe considerarse confiable únicamente porque haya sido proporcionado por el navegador.

## El nombre no determina el contenido

Un archivo llamado:

```text
documento.pdf
```

no tiene por qué contener realmente un PDF.

Del mismo modo, comprobar únicamente:

```php
str_ends_with($nombre, '.pdf')
```

no garantiza que el contenido sea del tipo esperado.

La extensión puede ser una comprobación adicional, pero no debe ser el único criterio.

## El tipo MIME enviado por el navegador tampoco es suficiente

El navegador puede enviar un valor como:

```text
application/pdf
```

pero ese dato también forma parte de la petición y puede manipularse.

Por tanto, el servidor debe analizar el archivo recibido utilizando mecanismos propios.

En PHP puede utilizarse, por ejemplo, `finfo`.

## Limitar el tamaño

Aceptar archivos sin límite puede consumir:

- espacio en disco;
- memoria;
- tiempo de procesamiento;
- ancho de banda.

Por tanto, la aplicación debe establecer un tamaño máximo razonable según su necesidad funcional.

Por ejemplo:

```text
Documentos PDF
máximo 5 MB
```

El límite debería comprobarse tanto en la configuración del servidor como en la lógica de la aplicación.

## No conservar directamente el nombre enviado

Una implementación insegura puede hacer:

```php
$nombre = $_FILES['documento']['name'];

$ruta = 'uploads/' . $nombre;
```

El nombre original está controlado por el cliente.

Además puede provocar:

- colisiones;
- sobrescrituras;
- nombres problemáticos;
- exposición de información;
- rutas inesperadas si la implementación es incorrecta.

Una práctica más segura consiste en generar el nombre en el servidor.

Por ejemplo:

```text
8f92c310b8a74f9c.pdf
```

La aplicación puede conservar el nombre original únicamente como metadato si realmente lo necesita.

## La ubicación de almacenamiento importa

Guardar archivos subidos directamente dentro de una carpeta pública del servidor web puede aumentar el riesgo.

Por ejemplo:

```text
/var/www/html/uploads/
```

Si el servidor permite ejecutar determinados tipos de archivo en esa ubicación, un archivo peligroso podría pasar de ser un dato almacenado a convertirse en código ejecutable.

Siempre que sea posible, los archivos deberían almacenarse fuera del directorio público y servirse mediante lógica controlada por la aplicación.

Conceptualmente:

```text
Usuario
   ↓
sube archivo
   ↓
servidor valida
   ↓
almacenamiento no público
   ↓
aplicación controla la descarga
```

## Permitir solo lo necesario

Una aplicación debe aceptar únicamente los tipos de archivo que realmente necesita.

Por ejemplo, si una funcionalidad requiere únicamente documentos PDF:

```text
Permitido:
application/pdf
```

no tiene sentido aceptar de forma genérica:

```text
cualquier archivo
```

Cuanto más amplia sea la funcionalidad, mayor será la superficie de exposición.

## Subir y ejecutar son cosas diferentes

Una aplicación puede necesitar almacenar un documento.

Eso no significa que el servidor deba interpretarlo o ejecutarlo.

La regla debe ser:

> **Los archivos subidos por usuarios deben tratarse como datos.**

Este principio es equivalente al que ya hemos utilizado en otros apartados:

```text
XSS
datos ≠ HTML ejecutable

SQL Injection
datos ≠ SQL

Subida de archivos
datos ≠ código ejecutable
```

## Autorización

La seguridad de la subida no termina cuando el archivo ha sido validado.

También debe comprobarse:

- quién puede subirlo;
- a qué recurso pertenece;
- quién puede descargarlo;
- quién puede eliminarlo.

Por ejemplo, un alumno podría tener permiso para subir una entrega propia, pero no para sustituir la de otro alumno.

El control debe realizarse en el servidor.

## Ejemplo en TxurdiGest

Supongamos que TxurdiGest permite adjuntar un justificante en formato PDF.

La aplicación podría definir:

```text
Tipo permitido: PDF
Tamaño máximo: 5 MB
Nombre: generado por el servidor
Ubicación: fuera del directorio público
Acceso: únicamente usuarios autorizados
```

El flujo sería:

```text
Archivo recibido
      ↓
comprobar error de subida
      ↓
comprobar tamaño
      ↓
comprobar tipo real
      ↓
generar nombre seguro
      ↓
guardar en ubicación controlada
      ↓
registrar metadatos
```

## Implementación

En [Implementación](implementacion.md) trabajaremos:

- formularios con `multipart/form-data`;
- estructura de `$_FILES`;
- comprobación de errores;
- límites de tamaño;
- detección del tipo MIME;
- nombres generados por el servidor;
- `move_uploaded_file()`;
- almacenamiento fuera del directorio público;
- control de acceso a los archivos.

En [Laboratorio DVWA](laboratorio-dvwa.md) analizaremos una implementación vulnerable para comprobar por qué confiar únicamente en el nombre o la extensión del archivo no es suficiente.

## Resumen

- Un archivo recibido debe considerarse una entrada no confiable.
- La extensión y el tipo MIME enviado por el navegador no son pruebas suficientes.
- El servidor debe limitar tamaño y tipos permitidos.
- El nombre del archivo debería generarse en el servidor.
- La ubicación de almacenamiento debe impedir ejecuciones innecesarias.
- La aplicación debe controlar también quién puede subir, consultar y eliminar cada archivo.
