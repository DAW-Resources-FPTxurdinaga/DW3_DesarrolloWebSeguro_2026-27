# Baimenak inplementatzea

Baimenak zerbitzarian aplikatu behar dira eragiketa babestua exekutatu aurretik.

Fluxu orokorra hau da:

```text
Eskaera
   ↓
Erabiltzailea autentikatua dago?
   ↓
Rol egokia du?
   ↓
Baliabide honi aurre egiteko baimena du?
   ↓
Eragiketa exekutatu
```

Aplikazioak ez du fidatu behar interfazea funtzio bat ezkutatu duela edo bezeroak balio baliagarria bidali duela.

## Saioa autentikatua dagoela egiaztatu

Ekintza baimendu aurretik, aplikazioak erabiltzailearen identitatea ezagutu behar du.

```php
session_start();

if (!isset($_SESSION['usuario_id'])) {
    http_response_code(401);
    exit('Saioa hasi behar duzu.');
}
```

Ondoren lortu daiteke:

```php
$usuarioId = (int) $_SESSION['usuario_id'];
```

Identitatea saioaren barrukoa izan behar da, ez nabigatzaileak bidalitako eremuen artean.

## Baimenak rolaren arabera

Zenbait eragiketan rolaren egiaztapena nahikoa izan daiteke.

```php
if (
    !isset($_SESSION['rol']) ||
    $_SESSION['rol'] !== 'administrador'
) {
    http_response_code(403);
    exit('Ez du baimenik.');
}
```

## Hainbat rol onartu

Zenbait kasutan eragiketa rol bat baino gehiagorako egon daiteke eskuragarri.

```php
function requireAnyRole(array $roles): void
{
    $rolActual = $_SESSION['rol'] ?? null;

    if (!in_array($rolActual, $roles, true)) {
        http_response_code(403);
        exit('Ez du baimenik.');
    }
}
```

## Baliabide baten sarbidea egiaztatu

Rolak ez du beti bakarrik erabakitzen eragiketa baimendua den. Demagun irakasle batek kalifikazio bat aldatzea saiatzen dela. Zerbitzariak egiaztatu behar du ikasle hori irakasle autentikatua kudeatzen duen talde batean dagoela.

```php
$profesorId = (int) $_SESSION['usuario_id'];
$alumnoId = filter_input(
    INPUT_POST,
    'alumno_id',
    FILTER_VALIDATE_INT
);
```

## Kontsulta prestatu bidezko egiaztapena

Funtzio bat izan daiteke:

```php
function profesorPuedeGestionarAlumno(
    PDO $pdo,
    int $profesorId,
    int $alumnoId
): bool {
    $sql = "
        SELECT 1
        FROM alumnos a
        INNER JOIN grupos g
            ON g.id = a.grupo_id
        WHERE a.id = :alumno_id
          AND g.profesor_id = :profesor_id
        LIMIT 1
    ";

    $stmt = $pdo->prepare($sql);

    $stmt->execute([
        'alumno_id' => $alumnoId,
        'profesor_id' => $profesorId
    ]);

    return $stmt->fetchColumn() !== false;
}
```

## Baimendu aurretik aldatu

Ordena garrantzitsua da. Datu-basea eguneratu aurretik baimenak egiaztatu behar dira.

## Ez fidatu bezeroen bidalitako rolari

Rol edo identifikatzaileak bezeroak bidalita ez dira inoiz fidagarriak. Zerbitzariak beti egiaztatu behar du erabiltzailearen benetako rola eta baliabidea.

## Botoiak JavaScript-ekin ezkutatu

Interfazea JavaScript erabiliz egokitu daiteke, baina endpoint-ak oraindik egiaztatu behar du:

```php
if ($_SESSION['rol'] !== 'administrador') {
    http_response_code(403);
    exit;
}
```

## TxurdiGest-en adibidea

`12` identifikatzailea duen irakasle batek `152` ikaslearen nota aldatzeko eskatu duenean, aplikazioak honakoak egiaztatu behar ditu:

```text
Saio baliozkoa
    ↓
usuario_id = 12
    ↓
rol = profesor
    ↓
¿ikasle 152 bere taldeetako bat da?
    ↓
bai
    ↓
nota eguneratu
```

## Praktika onak

- Egiaztatu baimenak zerbitzarian.
- Lortu identitatea saioaren barrutik.
- Ez fidatu bezeroen bidalitako rol edo identifikatzaileei.
- Erabili rolak baimen orokorretarako.
- Egiaztatu baita ere erabiltzailearen eta baliabidearen arteko erlazioa beharrezkoa denean.
- Baimendu eragiketa exekutatu aurretik.
- Babestu HTML orriak, endpoint-ak eta API-ak.

## Laburpena

- Baimenak erabiltzailea identifikatu ondoren egiaztatzen dira eta ekintza exekutatu aurretik.
- Rolak ez dira beti nahikoa: eragiketa askok baliabide konkretuaren arabera dira.
- Identitatea saioetatik lortu behar da.
- Bezeroak bidalitako datuak ez dute automatikoki baimena frogatzen.
