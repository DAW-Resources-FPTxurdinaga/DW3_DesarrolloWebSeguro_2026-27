# DVWA laborategia: SQL Injection

Laborategi honetan **SQL Injection**-ri aurre egiten dion inplementazio ahul bat aztertuko da, kontsulta konkatena bidez eraikia datu jasotakoak alda ditzakeela ulertzeko.

Helburua ez da exploit teknikak ikastea, baizik eta garapen-segurtasun oinarrizko erabaki bat ulertzea:

> **Datuak ez dira inoiz SQL kontsultaren egituran parte izan behar.**

## Eszenatokia

**DVWA (Damn Vulnerable Web Application)** erabiliko dugu ingurune lokal eta kontrolatuan.

DVWA-ko SQL Injection ariketa landuko dugu.

## 1. Portaera normala behatu

Sartu lehenik identifikatzaile baliozkoa SQL Injection ariketan.

Adibidez:

```text
1
```

Ikusi jasotako erantzuna.

## 2. Kontsultaren eraikuntza aztertu

Arazoa hau da:

```php
WHERE user_id = '$id'
```

Jasotako balioa zuzenean SQL katearen barruan txertatzen da.

## 3. Egiaztatu kontsulta aldatu daitekeela

DVWA-ko ingurune kontrolatuan sarrera minimo bat erabil daiteke kontsulta aldatu dela ikusteko.

Adibidez:

```text
1' OR '1'='1
```

## 4. Arrazoia benetazkoa identifikatu

Ahultasuna ez da SQL-a ez-segurua delako.

Ez da soilik komatxo bat sartu delako ere.

Arrazoia kontsulta eraikitzeko moduari dagokio.

## 5. Kode ahula berrikusi

Erabili DVWA-ko aukera kode iturria ikusteko.

Bilatu:

1. nondik jasotzen den datua;
2. nondik eraikitzen den kontsulta;
3. nondik konkatena den balioa;
4. nondik exekutatzen den kontsulta.

## 6. Kontsulta prestatua erabiliz zuzendu

PDO-rekin inplementazio segurua honela idatz daiteke:

```php
$id = filter_input(
    INPUT_GET,
    'id',
    FILTER_VALIDATE_INT
);
```

Eta ondoren parametro bat erabiliz:

```php
$sql = "
    SELECT first_name, last_name
    FROM users
    WHERE user_id = :id
";
```

Prestatu:

```php
$stmt = $pdo->prepare($sql);
```

Eta datua aparte eman:

```php
$stmt->execute([
    'id' => $id
]);
```

## 7. Bi ereduen konparazioa

### Inplementazio ahula

```php
$sql = "
    SELECT *
    FROM users
    WHERE user_id = '$id'
";
```

### Inplementazio segurua

```php
$sql = "
    SELECT *
    FROM users
    WHERE user_id = :id
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'id' => $id
]);
```

## 8. Balidazioa eta parametrizazioa

Garrantzitsua da behatu bi kontrol daudela:

```php
$id = filter_input(
    INPUT_GET,
    'id',
    FILTER_VALIDATE_INT
);
```

eta:

```php
$stmt->execute([
    'id' => $id
]);
```

Balidazioa erantzuten du:

> ¿Identifikatzaile hau aplikazioarentzat baliozkoa da?

Kontsulta prestatua erantzuten du:

> ¿Balio honek SQL egitura aldatu dezake?

Neurri batek ez du bestea ordezkatzen.

## 9. Proba errepikatu

Inplementazioa aztertu edo zuzendu ondoren:

1. egin kontsulta identifikatzaile baliozkoa erabiliz;
2. egiaztatu oraindik funtzionatzen duela;
3. errepikatu ahultasuna ikusteko erabilitako sarrera;
4. egiaztatu ez duela kontsulta aldatu.

## TxurdiGest-i aplikatzea

Demagun TxurdiGest-ek ikasle bat honela kontsultatzen duela:

```text
/alumnos.php?id=152
```

Inplementazio okerra honakoa litzateke:

```php
$id = $_GET['id'];
$sql = "
    SELECT *
    FROM alumnos
    WHERE id = $id
";
```

Inplementazioak lehenengo identifikatzailea balidatu behar du:

```php
$id = filter_input(
    INPUT_GET,
    'id',
    FILTER_VALIDATE_INT
);
```

eta ondoren kontsulta prestatua erabili:

```php
$sql = "
    SELECT *
    FROM alumnos
    WHERE id = :id
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'id' => $id
]);
```

Printzipio bera aplikatu behar da:

- ikasleak bilatzea;
- taldeak kontsultatzea;
- kalifikazioak txertatzea;
- datuak aldatzea;
- erregistroak ezabatzea.

## Zein gauza frogatu behar da

Laborategiaren amaieran argi egon behar da:

- SQL Injection agertzen dela datuak kontsulta egitura aldatu dezaketenean;
- sarrerak SQL barruan konkatena egitea inplementazio ez-segurua dela;
- datu bat baliozkoa izateak ez duela kontsulta parametrizatu beharrik ordezkatzen;
- kontsulta prestatuak instrukzioak eta balioak bereizten dituztela;
- `prepare()` eta `execute()` sistematik erabili behar direla;
- inplementazio bat zuzentu ondoren proba bera errepikatu behar dela.
