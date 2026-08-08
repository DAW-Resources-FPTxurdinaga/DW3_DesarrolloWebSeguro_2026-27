# DVWA laborategia: fitxategi-karga

Laborategi honetan fitxategi-karga inplementazio ahul bat aztertuko da, zergatik ez den nahikoa izena, luzapena edo nabigatzaileak bidalitako MIME mota fidatzea ulertzeko.

Helburua ez da zerbitzarian kodea exekutatu, baizik eta garapen-erabaki batzuek nola bihurtzen duten fitxategi-karga funtzionaltasuna ez-segurua eta nola zuzendu behar den identifikatzea.

## Eszenatokia

**DVWA (Damn Vulnerable Web Application)** erabiliko dugu ingurune lokal eta kontrolatuan.

DVWA-ko fitxategi-kargako ariketa landuko dugu.

## 1. Portaera normala behatu

Sartu lehenik fitxategi onartua, adibidez irudia.

Ikusi:

- zein motak onartzen dituen interfazea;
- zer mezu itzultzen duen;
- non gordetzen den fitxategia;
- fitxategia geroago eskuragarri dagoen ala ez.

## 2. Bezeroak kontrolatutako informazioa aztertu

Fitxategia hautatzean nabigatzaileak informazio hau bidaltzen du:

```text
izena
MIME mota deklaratua
tamaina
edukia
```

## 3. Erabiltzen den balidazioa aztertu

Erabili DVWA-ko aukera kode iturria ikusteko.

Bilatu balidazioak aurretik fitxategia gordetzen aurretik.

## 4. Balidazio ez-oinarrizkoa identifikatu

Inplementazio sinple batek soilik izena egiaztatu lezake:

```php
$nombre = $_FILES['archivo']['name'];

if (!str_ends_with($nombre, '.jpg')) {
    exit('Fitxategia ez da onartzen.');
}
```

## 5. DVWA-n portaera egiaztatu

Soilik beharrezko probak egin, ez da beharrezkoa kodea exekutatu edo ihes teknikak garatzea.

## 6. Biltegiratze kokapena berrikusi

Arrisku handiko egitura bat izan daiteke:

```text
/var/www/html/uploads/
```

## 7. Balidazio segurua diseinatu

Inplementazio sendoago batek hainbat egiaztapen konbinatu behar ditu.

### Igoera emaitza egiaztatu

```php
if (
    $_FILES['archivo']['error']
    !== UPLOAD_ERR_OK
) {
    exit('Igoera errorea.');
}
```

### Tamaina mugatu

```php
$maxSize = 5 * 1024 * 1024;

if ($_FILES['archivo']['size'] > $maxSize) {
    exit('Fitxategia handiegia da.');
}
```

### MIME benetakoa detektatu zerbitzarian

```php
$finfo = new finfo(FILEINFO_MIME_TYPE);

$mime = $finfo->file(
    $_FILES['archivo']['tmp_name']
);
```

### Zerrenda itxia erabili

```php
$tiposPermitidos = [
    'image/jpeg' => 'jpg',
    'image/png' => 'png'
];

if (!isset($tiposPermitidos[$mime])) {
    exit('Mota ez da onartzen.');
}
```

### Izena zerbitzarian sortu

```php
$extension = $tiposPermitidos[$mime];

$nombreSeguro = bin2hex(
    random_bytes(16)
) . '.' . $extension;
```

### `move_uploaded_file()` bidez gorde

```php
$rutaDestino =
    '/var/www/app/storage/uploads/'
    . $nombreSeguro;

move_uploaded_file(
    $_FILES['archivo']['tmp_name'],
    $rutaDestino
);
```

## 8. Bi ereduen konparazioa

### Inplementazio ahula

```text
bezeroen bidalitako izena
        ↓
balidazio azpimarratua
        ↓
izen bera
        ↓
direktorio publikoa
```

### Inplementazio segurua

```text
fitxategia jasota
      ↓
errorea egiaztatu
      ↓
tamaina egiaztatu
      ↓
edukia aztertu
      ↓
zerrenda itxia
      ↓
izen sortu
      ↓
kokapen kontrolatua
```

## 9. Defentsa geruza anitzetan aplikatu

## TxurdiGest-i aplikatzea

## Zein gauza frogatu behar da

- fitxategiaren izena bezeroak kontrolatzen duela;
- luzapenak ez duela edukien mota benetakoa frogatzen;
- `$_FILES['type']` ez dela frogapen fidagarria;
- zerbitzariak fitxategiak aztertu eta mugatu behar dituela;
- fitxategi fisikoa zerbitzarian sortu behar dela;
- fitxategiak direktorio publikoaren kanpoan gordetzeak esposizioa murrizten duela;
- zerbitzariaren konfigurazioa eta baimenak segurtasunaren parte direla;
- fitxategi-karga segurua hainbat kontroleren konbinazioa dela.
