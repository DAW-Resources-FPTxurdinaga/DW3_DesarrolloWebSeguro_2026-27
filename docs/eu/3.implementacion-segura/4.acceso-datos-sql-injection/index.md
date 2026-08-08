# Datuetara sarbide segurua eta SQL Injection

Web aplikazio batek sarritan datu-baseko kontsultak eraikitzen ditu formularioko, URL, saio edo APIetako informazioarekin.

Datu horiek SQL kontsulta baten barruan zuzenean txertatzen badira, zerbitzariak exekutatu nahi zuen instrukzioa alda dezakete.

Arazo hau **SQL Injection** bezala ezagutzen da.

## Arazoa SQL-n ez dago, baizik eta kontsulta nola eraikitzen den

Demagun bilaketa sinple bat posta elektronikoaren arabera.

Inplementazio ez-seguru batek honela izan lezake:

```php
$email = $_POST['email'] ?? '';

$sql = "SELECT * FROM usuarios WHERE email = '$email'";
```

Hemen `$email` balioa zuzenean kontsultaren barruan konkatena da.

Aplikazioak bi gauza desberdin nahasten ari da:

```text
SQL kodea
+
jasotako datua
```

Datuak SQL-ren esanahi bereziak baditu, kontsultaren egitura aldatu daiteke.

## Instrukzioak eta datuak bereiztu

SQL Injection saihesteko oinarrizko ideia hau da:

> **SQL kodea alde batean definitu behar da eta datuak beste alde batean bidali.**

PHP-n PDO-rekin kontsulta prestatuak erabiliz lortzen da.

Adibidez:

```php
$sql = "SELECT * FROM usuarios WHERE email = :email";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'email' => $email
]);
```

Orain `:email` parametro bat da.

Datu-basearen motorra kontsultaren egitura ezagutzen du balio konkretua jasotzen aurretik eta balio hori datu gisa tratatzen du, ez SQL instrukzioaren zati gisa.

## Balidazioa ez da parametrizazioa ordezkatzen

Sarreren balidazioa beharrezkoa izaten jarraitzen du.

Adibidez, posta elektronikoa egiaztatu behar da:

```php
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    // Baztertu datua.
}
```

Baina balidazio zuzena ez da kontsulta prestatuen ordezko izan behar.

Bi kontrol desberdin dira:

| Balidazioa | Kontsulta prestatua |
|---|---|
| Datuak aplikazioaren arauak betetzen dituela egiaztatzen du. | Datuak SQL instrukziotik bereizten ditu. |
| Formatu edo balio okerrak baztertu ditzake. | Datuak kontsultaren egitura aldatzea eragozten du. |
| Sarrerak tratatzeko parte da. | Datu-basearen sarbide seguruko parte da. |

Aplikazio segurua bi mekanismoak erabiltzen ditu dagokionean.

## Ez fidatu barneko datuei

SQL Injection ez da soilik formularioan zuzenean idatzitako balioekin agertzen.

Datu bat honetatik etor daiteke:

- URL parametroak;
- ezkutuko eremuak;
- cookie-ak;
- JSON eskaerak;
- aurretik gordetako datuak;
- zerbitzu kanpokoak.

Adibidez:

```php
$id = $_GET['id'] ?? '';

$sql = "SELECT * FROM alumnos WHERE id = $id";
```

Nahiz eta interfazea normalean baliozko identifikatzaileak sortu, eskaera alda daiteke.

Kontsulta oraindik eraikuntza ez-seguru batean dago.

## TxurdiGest-en adibidea

Demagun TxurdiGest-ek ikasle baten datuak identifikatzaile baten bidez kontsultatzeko aukera ematen duela.

Inplementazio ez-seguru batek honela eraikiko luke:

```php
$id = $_GET['id'] ?? '';

$sql = "SELECT * FROM alumnos WHERE id = $id";
```

Modu segurua parametro bat erabiltzea da:

```php
$sql = "SELECT * FROM alumnos WHERE id = :id";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'id' => $id
]);
```

Gainera, identifikatzailea erabili aurretik balidatu beharko litzateke:

```php
$id = filter_input(
    INPUT_GET,
    'id',
    FILTER_VALIDATE_INT
);
```

Balidazioa datua egiaztatzen du.

Kontsulta prestatua SQL egitura babesten du.

## Irakurketa eta idazketa kontsultak

Parametrizazioa bai irakurtzeko bai aldatzeko kontsultetan erabili behar da.

Adibidez:

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

Berbera aplikatzen da:

- `SELECT`;
- `INSERT`;
- `UPDATE`;
- `DELETE`.

## Ez egin behar dena

Ez da gomendagarria kontsulta babestea kate-konkatenezioak eta iragazki improvisatuekin saiatzea.

Adibidez:

```php
$email = str_replace("'", "", $_POST['email']);
```

edo:

```php
$sql = "SELECT * FROM usuarios WHERE email = '" .
       addslashes($email) .
       "'";
```

Soluzio hauek datuaren arazoa eta kontsultaren eraikuntza nahasten dituzte eta segurtasun sentsazio faltsua sor dezakete.

## Atalak

Gai honetan honakoak landuko ditugu:

- [PHP eta kontsulta prestatuak](php-consultas-preparadas.md): PDO, parametroak eta datu-base sarbide seguruko ereduen erabilera.
- [DVWA laborategia](laboratorio-dvwa.md): kontsulta ahul baten azterketa, arrazoia identifikazioa eta parametrizatutako inplementazioarekin konparazioa.

## Laburpena

- SQL Injection agertzen da datu ez fidagarriak SQL instrukzioa aldatu dezaketenean.
- Kontsultaren barruan balioak konkatena egitea inplementazio ez-segurua da.
- Kontsulta prestatuak SQL kodea eta datuak bereizten dituzte.
- Sarreren balidazioa eta kontsulten parametrizazioa kontrol osagarriak dira.
- Parametrizazioa irakurketa eta idazketa kontsultetan aplikatu behar da.

