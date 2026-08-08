# Logen eta erroreen inplementazioa produkzioan

Erroreen kudeaketak hedapenaren konfigurazioaren parte izan behar du.

Produkzioan dagoen aplikazio batek bi helburu lortu behar ditu:

```text
Erabiltzaileari informatu, informazio sentikorra agerian utzi gabe

        +

Talde teknikoarentzat informazio nahikoa erregistratu
```

## Produkzio-ingurunea konfiguratzea

Lehen urratsa ingurunearen konfigurazioa berrikustea da.

PHP eta Laravel aplikazioetan, erroreak zuzenean erakustea saihestu behar da.

Adibide kontzeptuala:

```text
Garapena

APP_DEBUG=true


Produkzioa

APP_DEBUG=false
```

Aplikazioak erroreak erregistratzen jarraitzen du, baina erabiltzaileari erakusteari uzten dio.

## PHP konfigurazioa

PHPk erroreen bistaratzearekin lotutako aukerak ditu.

Garapenean:

```ini
display_errors = On
```

programazioa erraztu dezake.

Produkzioan:

```ini
display_errors = Off
```

barne-informazioa agerian uztea saihesten du.

Erroreak kontrolatutako erregistroetara bidali behar dira.

## Erroreen erregistroa

Erregistro batek honelako galderei erantzuteko balio behar du:

```text
Zer gertatu da?

Noiz gertatu da?

Zein eragiketari eragin dio?

Zein erabiltzaile zegoen inplikatuta?

Non gertatu da?
```

Adibide kontzeptuala:

```text
Data:
08/08/2026 10:30

Eragiketa:
Erreserba sortu

Erabiltzailea:
154

Errorea:
BD konexio-hutsa
```

Erregistroak informazio erabilgarria du, baina ez sekretuak.

## Salbuespenak PHPn erregistratzea

Oinarrizko kudeaketa bat:

```php
try {

    realizarOperacion();

} catch (Exception $e) {

    error_log(
        $e->getMessage()
    );

    mostrarMensajeError();

}
```

Erabiltzaileak erantzun kontrolatu bat jasotzen du.

Xehetasuna erregistratuta geratzen da.

## Informazio sentikorra ez erregistratzea

Hau gordetzea saihestu behar da:

```text
Pasahitzak

Tokenak

API gakoak

Beharrezkoak ez diren datu osoak

Banku-informazioa
```

Adibide okerra:

```text
Erabiltzailea:
juan

Password:
123456
```

Adibide egokia:

```text
Erabiltzailea:
juan

Errorea:
autentikazio-hutsa
```

## Laravel logak

Laravelrek bere log-sistema propioa ematen du.

Konfigurazioa honen bidez egiten da:

```text
config/logging.php
```

eta ingurune-aldagaien bidez.

Adibidea:

```text
LOG_CHANNEL=stack

LOG_LEVEL=error
```

Log-maila ingurunera egokitu behar da.

## Log-mailak

Erregistro-sistemek normalean mailak bereizten dituzte:

```text
debug

info

warning

error

critical
```

Produkzioan normalean komeni da arazketa-informazio gehiegi ez izatea.

Adibidea:

```text
Garapena:

debug


Produkzioa:

error
```

Konfigurazioa proiektuaren beharren araberakoa izango da.

## Logen kokapena

Erregistroak kokapen babestuetan gorde behar dira.

Adibidea:

```text
storage/logs/
```

Ez lirateke direktorio publikoaren barruan egon behar:

```text
public/
```

URL baten bidez deskargatu ahal izango liratekeelako.

Okerra:

```text
https://txurdigest.ejemplo/logs/error.log
```

## Logen errotazioa

Logak denborarekin hazten doaz.

Produkzioan dagoen aplikazio batek honakoa aurreikusi behar du:

```text
Erregistroak sortu

        ↓

Epe batez gorde

        ↓

Log zaharrak biratu

        ↓

Dagokionean ezabatu
```

Errotazioak hau saihesten du:

- disko-kontsumo gehiegizkoa;
- erregistratzeko gaitasuna galtzea;
- informazio garrantzitsua aurkitzeko zailtasuna.

## Logak eta datuen babesa

Erregistroek informazio pertsonala eduki dezakete.

Beraz, beste datu sentikorren antzeko neurriak aplikatu behar dira:

- sarbide mugatua;
- kontserbazio mugatua;
- ezabaketa segurua;
- edukien berrikuspena.

## Hedapenean erroreak berrikustea

Aplikazio bat argitaratu ondoren, komeni da egiaztatzea:

```text
Eragiketa arrunta egin

        ↓

Errore kontrolatua eragin

        ↓

Erabiltzailearen erantzuna egiaztatu

        ↓

Barne-loga berrikusi
```

Aplikazioak ondo jokatu behar du bi aldeetan.

## Berrikuspen-tresnak

Ingurunearen arabera, hau erabil daiteke:

```bash
tail -f storage/logs/laravel.log
```

azken erregistroak behatzeko.

Hauek ere berrikus daitezke:

- Apache logak;
- Nginx logak;
- sistemako logak.

## Web zerbitzariaren erroreak

Web zerbitzariak ere informazioa sortzen du:

Adibidea:

```text
access.log

error.log
```

Erregistro horiek honakoa identifikatzen laguntzen dute:

- jasotako eskaerak;
- HTTP erroreak;
- konfigurazio-arazoak.

## Arazoak ez ezkutatzea

Aplikazio segurua ez da errore guztiak ezkutatzea.

Oreka egon behar da:

```text
Erabiltzailea

mezu segurua


Talde teknikoa

informazio nahikoa
```

Errore bat erregistratu gabe ezkutatzeak konpontzea zailtzen du.

## TxurdiGest-en adibidea

Errorea:

```text
Ezin da erreserba gorde
```

Erabiltzailea:

```text
Ezin izan da eragiketa osatu.
```

Loga:

```text
Data

Erabiltzailea

Eragiketa

Salbuespen teknikoa

Eskaeraren identifikatzailea
```

Sistemak ikertzea ahalbidetzen du, barne-xehetasunak agerian utzi gabe.

## Checklist-a

```text
[ ] DEBUG desaktibatuta

[ ] Errore teknikoak ezkutatuta

[ ] Logak konfiguratuta

[ ] Logak sarbide publikotik kanpo

[ ] Errotazioa konfiguratuta

[ ] Ez da sekreturik erregistratzen

[ ] Erroreak ikertu daitezke

[ ] Web zerbitzariaren logak berrikusita
```

## Gako-ideia

> Erroreak informazio sentikor gisa kudeatu behar dira: behar denean erabiltzaileari ezkutatu, eta modu kontrolatuan erregistratu, ondoren jardun ahal izateko.
