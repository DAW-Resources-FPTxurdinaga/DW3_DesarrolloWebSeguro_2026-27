# Datu-basea hedapen seguru batean

Datu-basea web aplikazio baten osagai garrantzitsuenetako bat da.

Kritikoa izan daitekeen informazioa dauka:

- erabiltzaileak;
- zifratutako pasahitzak;
- datu pertsonalak;
- negozio-informazioa;
- jarduera-erregistroak.

Horregatik, hedapenean duen konfigurazioak babes-neurri espezifikoak aplikatu behar ditu.

## Datu-basea ez da zuzenean agerian egon behar

Arkitektura seguru batek osagaiak bereizten ditu:

```text
Erabiltzailea

    ↓ HTTPS

Web zerbitzaria

    ↓

Aplikazioa

    ↓

Datu-basea
```

Erabiltzailea ez litzateke inoiz datu-basera zuzenean konektatu behar.

Arkitektura okerra:

```text
Internet

    ↓

Datu-basea
```

Aplikazioak kontrolatu behar du zein eragiketa egin daitezkeen.

## Aplikazioaren eta datu-basearen arteko bereizketa

Datu-basea barne-zerbitzu gisa hartu behar da.

Adibidea:

```text
Web zerbitzaria

IP publikoa


Datu-basea

IP pribatua
```

Aplikazioa datu-basearekin komunikatu daiteke, baina kanpoko erabiltzaileek ez lukete zuzeneko sarbiderik izan behar.

## Aplikaziorako erabiltzaile espezifikoa

Ohiko errore bat da pribilegio gehiegiko kontuak erabiltzea.

Adibide okerra:

```text
Aplikazioa

    ↓

BDko administratzaile-erabiltzailea
```

Aplikazioak baimen guztiak dituen kontu bat erabiltzen badu, aplikazioaren arazo batek ondorio handiagoak izan ditzake.

Gomendatutako eredua:

```text
Aplikazioa

    ↓

Erabiltzaile espezifikoa

    ↓

Beharrezko baimenak
```

## Pribilegio minimoaren printzipioa datu-basean

Aplikazioak erabiltzen duen kontuak beharrezko baimenak bakarrik izan beharko lituzke.

Adibidez:

```text
Egin dezake:

SELECT
INSERT
UPDATE

Ezin du:

erabiltzaileak sortu
datu-baseak ezabatu
zerbitzariaren konfigurazioa aldatu
```

Aplikazioak ez luke administrazio-kontu bat erabili behar.

## Datu-baseko kredentzialak

Konexio-kredentzialak aplikazioaren sekretuen parte dira.

Ez lirateke inoiz agertu behar:

```php
$usuario = "root";
$password = "123456";
```

Kanpoko konfigurazioaren bidez eman behar dira:

```text
DB_HOST=db-interno

DB_DATABASE=txurdigest

DB_USERNAME=usuario_app

DB_PASSWORD=secreto
```

Aplikazioak inguruneko balioak erabiltzen ditu.

## Konexioa aplikaziotik

Konexioak konfigurazioak emandako datuak erabili behar ditu.

Adibidea:

```php
$pdo = new PDO(
    getenv('DB_DSN'),
    getenv('DB_USERNAME'),
    getenv('DB_PASSWORD')
);
```

Aplikazioak ez du balio horiek nola gordetzen diren jakin behar.

## Komunikazioen zifratzea

Aplikazioa eta datu-basea bereizita daudenean, bien arteko komunikazioak babesa behar izan dezake.

Adibideak:

```text
Web zerbitzaria

       ↓ konexio segurua

Datu-basea
```

Beharrizan zehatza honen araberakoa da:

- arkitektura;
- erabilitako sarea;
- datuen sentikortasuna;
- ingurunearen eskakizunak.

## Segurtasun-kopiak

Datu-base seguru batek segurtasun-kopien estrategia bat behar du.

Hau definitu behar da:

- maiztasuna;
- kokapena;
- babesa;
- kontserbazio-denbora;
- berreskuratze-prozedura.

Kopia batek informazio sentikorra dauka.

Beraz:

```text
Backup

babestu beharreko datua ere bada
```

## Ez gorde pasahitzak testu lauan

Datu-baseak ez ditu inoiz pasahitzak zuzenean gorde behar.

Okerra:

```text
erabiltzailea

password123
```

Zuzena:

```text
erabiltzailea

pasahitz-hasha
```

Hasha sortzea aplikazioaren mekanismo egokiekin egin behar da.

PHP adibidea:

```php
password_hash()
```

## Migrazioak eta hasierako datuak

Hedapenean honelako prozesuak exekuta daitezke:

- taulen sorrera;
- egituraren eguneraketa;
- hasierako datuen karga.

Prozesu horiek modu kontrolatuan egin behar dira.

Ez lirateke berrikuspenik gabe eragiketa suntsitzaileak automatikoki exekutatu behar.

## Administrazio-tresnen esposizioa

Honelako tresnak:

- phpMyAdmin;
- administrazio-panelak;
- BDko interfaze grafikoak;

produkzioaren aurretik berrikusi behar dira.

Beharrezko galderak:

```text
Beharrezkoa al da?

Nork izan dezake sarbidea?

Babestuta al dago?

Ezaba daiteke?
```

Babesik gabe argitaratutako tresna osagarri batek esposizio-azalera handitzen du.

## Datu-basea eta AWS

Ohiko arkitektura bat:

```text
Internet

    ↓

EC2 aplikazio-zerbitzaria

    ↓

RDS / BD zerbitzari pribatua
```

Datu-baserako sarbidea mugatu daiteke:

```text
Baimendu:

aplikazio-zerbitzaria

Blokeatu:

Internet
```

Helburua da beharrezko osagaiek bakarrik komunikatu ahal izatea.

## TxurdiGest-en adibidea

Arkitektura:

```text
Erabiltzailea

    ↓ HTTPS

Laravel/PHP zerbitzaria

    ↓

Barneko datu-basea
```

Konfigurazioa:

```text
DB_HOST=db-interno

DB_DATABASE=txurdigest

DB_USERNAME=txurdigest_app
```

Aplikazioak ez du erabiltzen:

```text
root
```

eta ez du datu-basea publikoki agerian uzten.

## Checklist-a

```text
[ ] BD ez dago Internetetik irisgarri

[ ] Aplikaziorako erabiltzaile espezifiko bat dago

[ ] Baimenak minimoak dira

[ ] Kredentzialak kodetik kanpo daude

[ ] Pasahitzak hashen bidez gordetzen dira

[ ] Segurtasun-kopiak babestuta daude

[ ] Administrazio-tresnak berrikusita daude

[ ] Komunikazioa berrikusita dago arkitekturaren arabera
```

## Gako-ideia

> Datu-base seguru bat ez dago soilik erabiltzen duen kodearen mende: kokapenaren, sarbideen eta baimenen mende ere badago.
