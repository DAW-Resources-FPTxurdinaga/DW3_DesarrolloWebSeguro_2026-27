# PHP eta kontsulta prestatuak

SQL-rekin PHP-tik lan egiteko gomendatutako modua **kontsulta prestatuak** erabiltzea da.

Haien helburu nagusia hau da:

```text
SQL instrukzioa
        +
Datuak
```

modu horretan, jasotako balioak ez dutela kontsultaren egitura aldatu.

## PDO bidezko konexioa

Adibide sinple bat honakoa izan daiteke:

```php
$dsn = 'mysql:host=localhost;dbname=txurdigest;charset=utf8mb4';

$pdo = new PDO(
    $dsn,
    'usuario_app',
    'clave_app',
    [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
    ]
);
```

Aplikazio errealean kredentzialak ez lirateke kode iturrian zuzenean agertu behar. Sekretuen eta konfigurazioaren kudeaketa bloke berezi batean aztertuko da.

## Parametroak dituen kontsulta prestatua

Demagun erabiltzaile bat posta elektronikoaren arabera bilatu nahi dugula.

Kontsulta honela defini daiteke:

```php
$sql = "
    SELECT id, nombre, email
    FROM usuarios
    WHERE email = :email
";
```

`:email` markatzaileak parametro bat adierazten du.

Ondoren kontsulta prestatu egiten da:

```php
$stmt = $pdo->prepare($sql);
```

Eta azkenean exekutatzen da balioa aparte bidaliz:

```php
$stmt->execute([
    'email' => $email
]);
```

Datuak ez dira SQL katearen barruan konkatena.

## Emaitzak berreskuratu

Kontsulta exekutatu ondoren:

```php
$usuario = $stmt->fetch();
```

Egiaztatu dezakegu badagoela:

```php
if ($usuario === false) {
    // Ez da erabiltzaile bat aurkitu.
}
```

## Identifikatzaile baten bidez bilatu

URL-tik jasotako identifikatzailea ere balidatu eta parametrizatu behar da.

```php
$id = filter_input(
    INPUT_GET,
    'id',
    FILTER_VALIDATE_INT
);
```

Eta ondoren:

```php
$sql = "
    SELECT id, nombre, email
    FROM alumnos
    WHERE id = :id
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'id' => $id
]);

$alumno = $stmt->fetch();
```

Ez da eraiki behar:

```php
$sql = "SELECT * FROM alumnos WHERE id = $id";
```

nahiz eta aurrez `$id` zenbakia izan behar den espero.

## Datuak txertatu

Kontsulta prestatuak `INSERT` eragiketetan ere erabili behar dira.

```php
$sql = "
    INSERT INTO alumnos (nombre, email)
    VALUES (:nombre, :email)
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'nombre' => $nombre,
    'email' => $email
]);
```

## Datuak eguneratu

Adibidea:

```php
$sql = "
    UPDATE alumnos
    SET email = :email
    WHERE id = :id
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'email' => $email,
    'id' => $id
]);
```

## Datuak ezabatu

`DELETE`-n ere:

```php
$sql = "
    DELETE FROM alumnos
    WHERE id = :id
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'id' => $id
]);
```

## Parametro posizionalak

PDO-k `?` ere onartzen du:

```php
$sql = "
    SELECT id, nombre
    FROM alumnos
    WHERE grupo_id = ?
      AND activo = ?
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    $grupoId,
    1
]);
```

## `bindValue()`

Beste aukera bat parametro bakoitza esplizituki lotzea da.

```php
$stmt = $pdo->prepare(
    "SELECT * FROM alumnos WHERE id = :id"
);

$stmt->bindValue(
    ':id',
    $id,
    PDO::PARAM_INT
);

$stmt->execute();
```

## Parametroak balioetarako, ez SQL egituratzeko

Parametroek balioak adierazten dituzte.

Ezin dira zuzenean SQL egitura osatzen duten zatietarako erabili.

## Kontsultak dinamikoak

Batzuetan kontsulta iragazki opcionalei menpe dago.

Adibidez:

- taldea;
- egoera;
- izena.

Modu segurua da aplikazioak definitutako SQL zatiak soilik eraikitzea eta parametroak aparte gordetzea.

## Ez konkatena balidatua izan arren

Patroi hau oraindik desegokia da:

```php
$id = filter_input(
    INPUT_GET,
    'id',
    FILTER_VALIDATE_INT
);

$sql = "SELECT * FROM alumnos WHERE id = $id";
```

Balidazioak arriskua murrizten du kasu honetan, baina erantzukizunak nahasten ditu eta beste puntu batzuetan errore errazagoa sortzen du.

## Ez saiatu kontsultak eskuz ihes egiten

Tampoko ez da komeni kontsultak honela eraikitzea:

```php
$email = addslashes($email);

$sql = "
    SELECT *
    FROM usuarios
    WHERE email = '$email'
";
```

## Erroreak datu-basean

Aplikazioak ere ez luke erabiltzaileari SQL errore osoak erakutsi behar.

```php
try {
    $stmt = $pdo->prepare($sql);
    $stmt->execute($parametros);
} catch (PDOException $e) {
    error_log($e->getMessage());

    http_response_code(500);
    exit('Ezin izan da eragiketa burutu.');
}
```

## Gutxieneko baimen printzipioa

Aplikazioak datu-basearekin konektatzeko erabilitako kontuak beharrezko baimenak baino ez izan behar ditu.

## TxurdiGest-en adibidea

Demagun irakasle batek kalifikazio bat aldatzen duela.

Aplikazioak honakoak jasotzen ditu:

```text
alumno_id=152
nota=8.5
```

Lehenengo datuak balidatzen dira eta ondoren eguneratu egiten da parametroekin.

```php
$sql = "
    UPDATE calificaciones
    SET nota = :nota
    WHERE alumno_id = :alumno_id
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'nota' => $nota,
    'alumno_id' => $alumnoId
]);
```

## Praktika onak

- Erabili PDO eta kontsulta prestatuak.
- Ez konkatena jasotako datuak SQL-rekin.
- Parametrizatu `SELECT`, `INSERT`, `UPDATE` eta `DELETE`.
- Balidatu datuak erabili aurretik.
- Erabili zerrenda itxiak egitura dinamikoetarako.
- Ez ihes egin eskuz balio SQLak.
- Ez erakutsi erabiltzaileari barneko datu-base erroreak.
- Erabili datu-base kontu minimo baimenekin.
- Mantendu arau uniforme bat: balioak parametroen bidez bidaltzen dira.

## Laburpena

- `prepare()` kontsultaren egitura definitzen du.
- `execute()` datuak modu bereizian ematen ditu.
- Parametroak balioetarako dira, ez taula edo zutabe izenetarako.
- Kontsulta prestatuak sistematik erabili behar dira SQL eragiketa guztietan.
- Balidazioa, baimenak, parametrizazioa eta datu-baseko baimenak kontrol osagarriak dira.
