# Fitxategi-karga segurua inplementatzea

Fitxategi-karga sarrera ez fidagarri gisa tratatu behar da. Zerbitzariak erabaki behar du fitxategia onartu, nola gorde eta norrek sarbidea izan dezakeen geroago.

## Igoera formularioa

Formularioak honakoak erabili behar ditu:

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

    <button type="submit">Fitxategia igo</button>
</form>
```

## `$_FILES` egiaztatu

PHP-n fitxategiak `$_FILES`-en agertzen dira.

```php
if (!isset($_FILES['documento'])) {
    http_response_code(400);
    exit('Ez da fitxategirik jaso.');
}
```

## Igoera erroreak egiaztatu

```php
$archivo = $_FILES['documento'];

if ($archivo['error'] !== UPLOAD_ERR_OK) {
    http_response_code(400);
    exit('Ezin izan da karga burutu.');
}
```

## Tamaina mugatu

```php
$maxSize = 5 * 1024 * 1024;

if ($archivo['size'] > $maxSize) {
    http_response_code(413);
    exit('Fitxategiak baimendutako tamaina gainditzen du.');
}
```

## Ez fidatu `$_FILES['type']`-ri

`$_FILES['type']` bezeroak bidalitako balio bat da, eta ez du edukia benetan egiaztatzen. Hori ez da nahikoa.

## `finfo` erabiliz MIME benetakoa detektatu

```php
$finfo = new finfo(FILEINFO_MIME_TYPE);

$mime = $finfo->file(
    $archivo['tmp_name']
);
```

## Zerrenda itxia erabili

```php
$tiposPermitidos = [
    'application/pdf' => 'pdf'
];

if (!array_key_exists($mime, $tiposPermitidos)) {
    http_response_code(415);
    exit('Fitxategi mota ez da onartzen.');
}
```

## Izena zerbitzarian sortu

```php
$extension = $tiposPermitidos[$mime];

$nombreSeguro = bin2hex(
    random_bytes(16)
) . '.' . $extension;
```

## Kokaleku segurua aukeratu

Ahal denean, fitxategiak direktorio publikoaren kanpoan gorde behar dira.

## `move_uploaded_file()` erabili

```php
if (
    !move_uploaded_file(
        $archivo['tmp_name'],
        $rutaDestino
    )
) {
    http_response_code(500);
    exit('Ezin izan da fitxategia gorde.');
}
```

## Praktika onak

- Ez fidatu bezeroaren bidalitako izenei.
- Erabili `finfo` MIME benetakoa detektatzeko.
- Mugatu tamaina.
- Gorde fitxategiak direktorio publikoaren kanpoan.
- Erabili `move_uploaded_file()`.
- Erregistratu metadatuak datu-basean.

## Laburpena

- Fitxategi-karga sarrera ez fidagarri gisa tratatu behar da.
- Zerbitzariak fitxategia onartu, gordetzeko modua erabaki eta sarbidea kontrolatu behar du.
- Fitxategiaren izena, luzapena eta MIME mota ez dira nahikoa.
