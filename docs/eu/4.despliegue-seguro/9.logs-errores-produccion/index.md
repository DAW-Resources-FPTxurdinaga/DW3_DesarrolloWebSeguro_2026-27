# Logak eta erroreak produkzioan

Aplikazio seguru batek ez ditu erroreak bakarrik saihestu behar; gertatzen direnean, behar bezala kudeatu ere egin behar ditu.

Garapenean, erroreek arazoak aurkitzen laguntzen dute.

Produkzioan, kudeaketa aldatu egin behar da:

```text
Garapena

arazteko informazioa erakutsi


Produkzioa

informazioa babestu + beharrezkoa dena erregistratu
```

Helburua da aplikazioak modu kontrolatuan huts egitea.

## Errore ikusgaiak eta barne-erroreak

Arazoren bat gertatzen denean, bi behar desberdin daude:

### Erabiltzailea

Informazio argia jaso behar du:

```text
Ezin izan da eragiketa osatu.
```

### Talde teknikoa

Ikertzeko informazio nahikoa behar du:

```text
Data

Eragindako erabiltzailea

Egindako eragiketa

Errore teknikoa
```

Bi behar horiek ez dira nahastu behar.

## Barne-informazioa ez erakustea

Erantzun ez-seguru batek honakoa erakutsi dezake:

```text
SQL errore osoa

Zerbitzariaren bidea

Framework-aren bertsioa

Barne-fitxategia

Kode-lerroa
```

Adibidea:

```text
Fatal error:
PDOException in /var/www/app/database.php line 45
```

Informazio horrek erasotzaile bati aplikazioaren xehetasunak ezagutzen lagun diezaioke.

Produkzioan mezu kontrolatu batekin ordezkatu behar da.

## Erroreak barnean erregistratzea

Erabiltzaileak errore osoa ikusten ez badu ere, aplikazioak erregistratu egin behar du.

Adibidea:

```text
Erabiltzailea:

Ezin izan da erregistroa gorde.


Barne-loga:

2026-08-08
BD konexio-errorea
eragindako erabiltzailea
eragiketaren identifikatzailea
```

Erregistroak honakoa ahalbidetzen du:

- arazoak diagnostikatzea;
- intzidenteak ikertzea;
- akats errepikatuak detektatzea.

## Logetan agertu behar ez duen informazioa

Logak ere arrisku bihur daitezke informazio gehiegi gordetzen badute.

Ez lukete honakorik gorde behar:

```text
Pasahitzak

Token osoak

API gakoak

Beharrezkoak ez diren datu pertsonalak

Informazio sentikorra
```

Adibide okerra:

```text
Erabiltzaile login:
ana

Password:
secreto123
```

Erregistroak beharrezkoa den informazioa bakarrik eduki behar du.

## Xehetasun-maila ingurunearen arabera

Aplikazio batek erregistro-maila desberdinak erabil ditzake.

Garapena:

```text
Informazio gehiago

Xehetasun tekniko gehiago
```

Produkzioa:

```text
Informazio erabilgarria

Datu sentikorrik gabe
```

Konfigurazioa ingurunera egokitu behar da.

## Salbuespenak PHPn

PHPk erroreak kudeatzeko aukera ematen du salbuespen-mekanismoen bidez.

Adibidea:

```php
try {

    guardarDatos();

} catch (Exception $e) {

    error_log(
        $e->getMessage()
    );

    mostrarErrorUsuario();

}
```

Aplikazioak arazoa erregistratzen du, baina ez ditu barne-xehetasunak erakusten.

## Erroreak Laravel-en

Laravelrek bere mekanismoak ditu honetarako:

- salbuespenen kudeaketa;
- logen sorrera;
- ingurunearen konfigurazioa.

Elementu garrantzitsu bat:

```text
APP_DEBUG=false
```

produkzioan.

Konfigurazio horrekin, erabiltzaileari erroreen informazio xehea erakustea saihesten da.

## Web zerbitzariaren logak

Aplikazioaren logez gain, web zerbitzariaren erregistroak ere egon daitezke:

- HTTP sarbideak;
- web zerbitzariaren erroreak;
- sistemako gertaerak.

Erregistro horiek honakoa aztertzen laguntzen dute:

- jasotako eskaerak;
- errore errepikatuak;
- konfigurazio-arazoak.

## Log fitxategien babesa

Logek informazio sentikorra eduki dezakete.

Beraz:

```text
Logak

        ↓

babestuta egon behar dute
```

Ez lirateke publikoki eskuragarri dagoen karpeta batean egon behar.

Adibide okerra:

```text
https://ejemplo.com/logs/error.log
```

Kanpoko erabiltzaile batek ez lituzke barne-erregistroak deskargatu behar.

## Oinarrizko monitorizazioa

Hedapen profesional batek honakoa berrikusten du:

- errore maizak;
- zerbitzuaren erorketak;
- baliabideen kontsumoa;
- saiakera anomaloak;
- arazo errepikatuak.

Helburua da arazoak erabiltzaileei eragin aurretik detektatzea.

## Errore guztiak ezkutatu ez egitea

Erroreak behar bezala kudeatzeak ez du esan nahi baztertu behar direnik.

Jardunbide txarra:

```text
salbuespena harrapatu

        ↓

ezer ez egin
```

Aplikazioak honakoa egin behar du:

- zuzen informatzea;
- beharrezkoa denean erregistratzea;
- ikertzea ahalbidetzea.

## Segurtasunarekiko lotura

Erroreak aplikazio baten informazio-azaleraren parte dira.

Aplikazio bat ondo programatuta egon daiteke, baina honakoa erakusten badu:

```text
barne-egitura

bertsioak

bideak

kontsultak

kredentzialak
```

erroreen bidez, segurtasunaren zati bat galtzen du.

## TxurdiGest-en adibidea

Egoera:

```text
Errorea erreserba bat gordetzean
```

Erabiltzailea:

```text
Ezin izan da eragiketa osatu.
```

Talde teknikoa:

```text
Loga:

data
erabiltzailea
eragiketa
errore teknikoa
```

Erabiltzaileak ez du barne-informaziorik jasotzen.

Taldeak arazoa iker dezake.

## Checklist-a

```text
[ ] DEBUG desaktibatuta produkzioan

[ ] Errore teknikoak ezkutatuta erabiltzaileari

[ ] Logak konfiguratuta

[ ] Logak babestuta

[ ] Ez da sekreturik erregistratzen

[ ] Ikertzeko informazio nahikoa dago

[ ] Erroreak probatuta produkzio-ingurunean
```

## Gako-ideia

> Aplikazio seguru batek ez ditu errore guztiak saihesten; erroreek informazioa ez erakustea eta modu kontrolatuan aztertu ahal izatea lortzen du.
