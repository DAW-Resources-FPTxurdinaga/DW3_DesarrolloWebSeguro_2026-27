# Web APIak eta CORS inplementatzea

API segurua endpoint bakoitzean honako erabakiak aplikatu behar ditu:

```text
Sarrera
  ↓
Balidazioa
  ↓
Autentifikazioa
  ↓
Baimenak
  ↓
Negozio logika
  ↓
Erantzun kontrolatua
```

Eskaera JavaScript, Vue edo Axios bidez etortzen den ala ez ez du erantzukizun horiek aldatzen.

## PHP-n JSON jasotzea

Eskaera bat JSON gorputz batekin bidal daiteke:

```json
{
    "alumnoId": 152,
    "nota": 8.5
}
```

PHP-n honela irakur daiteke:

```php
$contenido = file_get_contents('php://input');

$datos = json_decode(
    $contenido,
    true
);
```

Eta ondoren egiaztatu behar da JSON-a ondo interpretatu dela.

```php
if (!is_array($datos)) {
    http_response_code(400);
    exit;
}
```

## Jasotako datuak balidatu

JSON-a sintaktikoki zuzena izateaz gain, datuak aplikazioaren arauak bete behar ditu.

```php
$alumnoId = $datos['alumnoId'] ?? null;
$nota = $datos['nota'] ?? null;

if (!filter_var(
    $alumnoId,
    FILTER_VALIDATE_INT
)) {
    http_response_code(422);
    exit;
}

if (
    !is_numeric($nota) ||
    $nota < 0 ||
    $nota > 10
) {
    http_response_code(422);
    exit;
}
```

## JSON erantzunak

API batek erantzun koherenteak itzuli behar ditu.

```php
header('Content-Type: application/json');
```

Erantzun zuzena:

```php
http_response_code(200);

echo json_encode([
    'ok' => true
]);
```

Balidazio erantzuna:

```php
http_response_code(422);

echo json_encode([
    'errors' => [
        'nota' => 'Nota 0 eta 10 artean egon behar du.'
    ]
]);
```

## Barruko xehetasunak ez itzuli

Erantzuna ez luke honelako informazioa erakutsi behar:

```text
SQL osoa
zerbitzariaren bideak
stack traces
auth tokens
```

## Autentifikazioa endpoint-ean

API-k PHP saioak erabiltzen baditu, endpoint babestu bakoitzak saioa hasi eta egiaztatu behar du.

```php
session_start();

if (!isset($_SESSION['usuario_id'])) {
    http_response_code(401);

    echo json_encode([
        'error' => 'Saioa hasi behar duzu.'
    ]);

    exit;
}
```

## Baimenak eragiketa bakoitzean

Endpoint bat honakoera adibidez:

```text
PATCH /api/alumnos/152/nota
```

Zerbitzariak egiaztatu behar du erabiltzaile autentikatua `152` ikaslearen gainean ekintza egin dezakeela.

## CORS konfigurazio oinarrizkoa

Adibidez, frontend-a:

```text
http://localhost:5173
```

eta API-a:

```text
http://localhost:8000
```

API-k jatorri hori esplizituki baimendu dezake:

```php
header(
    'Access-Control-Allow-Origin: http://localhost:5173'
);
```

## `*` saihestu ez da beharrezkoa denean

```php
header('Access-Control-Allow-Origin: *');
```

hala ere, API pribatu edo autentikatuekin ez da automatikoki erabili behar.

## Jatorri baimendutako zerrenda

```php
$origenesPermitidos = [
    'http://localhost:5173',
    'https://txurdigest.ejemplo'
];

$origin = $_SERVER['HTTP_ORIGIN'] ?? '';

if (
    in_array(
        $origin,
        $origenesPermitidos,
        true
    )
) {
    header(
        'Access-Control-Allow-Origin: ' .
        $origin
    );
}
```

## Peticiones preflight

Zenbait eskaerak `OPTIONS` eskaera aurrekoa behar dute.

```php
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}
```

## CORS cookie-ekin

```php
header(
    'Access-Control-Allow-Credentials: true'
);
```

eta jatorri esplizitua erabili:

```php
header(
    'Access-Control-Allow-Origin: https://txurdigest.ejemplo'
);
```

## CORS ez da baimenak ordezkatzen

Nahiz eta zerbitzariak soilik:

```text
https://txurdigest.ejemplo
```

baimendu, endpoint-ak oraindik egiaztatu behar du:

```text
saioa
autorizazioa
balidazioa
```

## Praktika onak

- Tratatu JSONa sarrera ez fidagarri gisa.
- Balidatu eremu guztiak.
- Egiaztatu autentifikazioa eta baimenak endpoint bakoitzean.
- Lortu identitatea saioetatik.
- Itzuli soilik beharrezko eremuak.
- Ez erakutsi barneko erroreak.
- Erabili HTTP kode koherenteak.
- Definitu jatorri baimenduak esplizituki.
- Ez erabili `Access-Control-Allow-Origin: *` lehenespenez.
- Kudeatu `OPTIONS` eskaerak.
- Konfiguratu koherente cookieak, kredentzialak eta CORS.
- Ez erabili CORS autentifikazio edo baimenak ordezkatzeko.

## Laburpena

- API segurua balidazioa, autentifikazioa eta baimenak zerbitzarian aplikatzen ditu.
- Frontend-ek ez du eskaeraren legitimotasuna frogatzen.
- Erantzunak informazio esposeduna mugatu behar dute.
- CORS-ek nabigatzaileak zer jatorritako erantzunak erabil ditzakeen definitzen du.
- Kredentzialekin, jatorria esplizituki konfiguratu behar da.
- Endpoint-aren segurtasuna CORS-ek ez du determinatzen.
