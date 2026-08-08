# Balidazioa PHP-n

Zerbitzariaren balidazioa da aplikazioak jasotako datuak onartu edo baztertu erabakitzen duen egiaztapen definitiboa.

Nahiz eta nabigatzaileak HTML edo JavaScript bidez balidazioak egin, zerbitzariak berriro egiaztatu behar ditu balio guztiak erabili aurretik.

## Jasotako datuak irakurri

PHP-n datuak iturri desberdinetatik irits daitezke:

- formularioak;
- URL parametroak;
- JSON eskaerak;
- cookie-ak;
- fitxategiak;
- APIak.

Adibidez, `POST` bidez bidalitako formulario batean:

```php
$email = $_POST['email'] ?? '';
$nota = $_POST['nota'] ?? null;
```

`??` erabiltzeak saihesten du parametroa ez badago iruzurrak eta agerian utzi ahal izatea.

## Beharrezko eremuak balidatu

Formatuak edo barrutiak aztertu baino lehen, beharrezko datuak daudela egiaztatu behar da.

```php
$email = trim($_POST['email'] ?? '');

if ($email === '') {
    $errores['email'] = 'Posta elektronikoa derrigorrezkoa da.';
}
```

Notarako:

```php
if (!isset($_POST['nota']) || $_POST['nota'] === '') {
    $errores['nota'] = 'Nota derrigorrezkoa da.';
}
```

## Motak eta formatuak balidatu

PHP-k formatu arrunt batzuk balidatzeko funtzioak eskaintzen ditu.

### Posta elektronikoa

```php
$email = trim($_POST['email'] ?? '');

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    $errores['email'] = 'Posta elektronikoak ez du formatu baliagarria.';
}
```

### Zenbaki osoa

```php
$edad = filter_input(INPUT_POST, 'edad', FILTER_VALIDATE_INT);

if ($edad === false || $edad === null) {
    $errores['edad'] = 'Adina zenbaki osoa izan behar da.';
}
```

### Zenbaki hamartarra

```php
$nota = filter_input(INPUT_POST, 'nota', FILTER_VALIDATE_FLOAT);

if ($nota === false || $nota === null) {
    $errores['nota'] = 'Nota zenbaki bat izan behar da.';
}
```

## Barrutiak balidatu

Mota egiaztatzea ez da nahikoa. Datuaren barruti propioak ere aplikatu behar dira.

```php
$nota = filter_input(INPUT_POST, 'nota', FILTER_VALIDATE_FLOAT);

if ($nota === false || $nota === null) {
    $errores['nota'] = 'Nota zenbaki bat izan behar da.';
} elseif ($nota < 0 || $nota > 10) {
    $errores['nota'] = 'Notak 0 eta 10 artekoa izan behar du.';
}
```

## Onarturiko balioak balidatu

Eremu batek multzo itxi bat soilik onartzen badu, hobeto da lista esplizitu baten bidez egiaztatzea.

```php
$estadosPermitidos = [
    'pendiente',
    'aprobada',
    'rechazada'
];

$estado = $_POST['estado'] ?? '';

if (!in_array($estado, $estadosPermitidos, true)) {
    $errores['estado'] = 'Adierazitako egoera ez da baliozkoa.';
}
```

## Luzera balidatu

Kateek ere arrazoizko muga batzuk bete behar dituzte.

```php
$nombre = trim($_POST['nombre'] ?? '');

if (mb_strlen($nombre) < 2 || mb_strlen($nombre) > 60) {
    $errores['nombre'] = 'Izenak 2 eta 60 karaktere arte izan behar ditu.';
}
```

## Negozio-arauak balidatu

Balidazio garrantzitsuenak ez dira beti datuaren formatutik eratorritakoak.

Adibidez, TxurdiGest-en nota bat baliozko izan daiteke eta hala ere ez luke onartu behar irakasleak ez duela esleitutako talderik aldatzen saiatzen bada.

```php
if (!$profesorTieneGrupo($usuarioId, $grupoId)) {
    http_response_code(403);
    exit('Ez du baimenik eragiketa hau egiteko.');
}
```

## Akatsak bildu jarraitu aurretik

Balidazioa antolatzeko modu erraza da akats guztiak bildu eta eragiketa exekutatu aurretik erabiltzea.

```php
$errores = [];

$email = trim($_POST['email'] ?? '');
$nota = filter_input(INPUT_POST, 'nota', FILTER_VALIDATE_FLOAT);

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    $errores['email'] = 'Posta elektronikoa ez da baliozkoa.';
}

if ($nota === false || $nota === null) {
    $errores['nota'] = 'Nota zenbaki bat izan behar da.';
} elseif ($nota < 0 || $nota > 10) {
    $errores['nota'] = 'Notak 0 eta 10 artean egon behar du.';
}

if (!empty($errores)) {
    return;
}
```

## JSON eskaerak balidatu

API batean datuak gorputz JSON batean irits daitezke.

```php
$datos = json_decode(
    file_get_contents('php://input'),
    true
);
```

Eta ondoren edozein bestelako sarrera bezala balidatu behar dira.

## Balidazioak huts egiten duenean erantzun

Datu bat ez bada baliozkoa, zerbitzariak:

1. eragiketa gelditu behar du;
2. ez du aldaketa partzialik onartu behar;
3. bezeroari behar bezala jakinarazi behar dio.

## Laburpena

- PHP-k sarrera guztia balidatu behar du aplikazioa babesteko.
- Datu batek formatua egokia izan dezake eta hala ere ez da baliogarria negozio-arauen arabera.
- Balidazioa eragiketa prozesatu aurretik osatu behar da.
- JavaScript edo APItik datoak etortzen badira ere, kanpoko sarrera bezala tratatu behar dira.
