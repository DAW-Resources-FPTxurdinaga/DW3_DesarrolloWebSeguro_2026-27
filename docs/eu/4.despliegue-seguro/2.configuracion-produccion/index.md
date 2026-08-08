# Produkzioko konfigurazioa

Aplikazio baten konfigurazioa exekutatzen den ingurunera egokitu behar da.

Kode bera garapenean, probetan eta produkzioan erabil daiteke, baina balio batzuk aldatu egin behar dira:

- exekuzio-modua;
- kredentzialak;
- bideak;
- erabilitako zerbitzuak;
- erakutsitako informazio-maila;
- arazketa-aukerak.

Konfigurazioa ez da iturburu-kodearekin nahastu behar.

## Kodea eta konfigurazioa bereizita

Aplikazio batek bereizketa argia mantendu beharko luke:

```text
Iturburu-kodea
      +
Ingurunearen konfigurazioa
      ↓
Aplikazioa exekutatzen
```

Kodeak aplikazioaren portaera definitzen du.

Konfigurazioak ingurune jakin batean nola exekutatzen den definitzen du.

Adibidea:

```text
Garapena

Datu-basea:
localhost

Produkzioa

Datu-basea:
barne-zerbitzaria
```

Aplikazioa bera da, baina konfigurazioa aldatu egiten da.

## Garapeneko konfigurazioa eta produkziokoa

Garapenean programazioa errazten duten aukerak aktiba daitezke:

```text
DEBUG = true
```

Horrek honakoak erakuts ditzake:

- errore osoak;
- exekuzio-aztarnak;
- framework-aren informazioa;
- barne-xehetasunak.

Produkzioan aukera horiek desaktibatuta egon behar dute.

Adibide kontzeptuala:

```text
Garapena

Errore xeheak
Arazketa aktiboa
Informazio tekniko ikusgaia


Produkzioa

Errore kontrolatuak
Barne-erregistroa
Erabiltzaileari gutxieneko informazioa
```

## Arazketa-modua

Errore-mezuak erabilgarriak dira garapenean.

Adibidez:

```text
SQL errorea:
erabiltzaileen taula ez da aurkitu
fitxategia:
/var/www/app/modelo.php
35. lerroa
```

Informazio horrek lagundu egiten dio programatzaileari.

Baina produkzioan honakoa agerian utz dezake:

- barne-egitura;
- zerbitzariaren bideak;
- taulen izenak;
- erabilitako osagaiak.

Aplikazioak mezu generiko bat erakutsi behar du:

```text
Ezin izan da eragiketa osatu.
```

eta teknikoki zehatza den informazioa barnean erregistratu.

## Konfigurazioa ingurune-aldagaien bidez

Ohiko praktika bat ingurune-aldagaiak erabiltzea da.

Adibidea:

```text
DB_HOST=servidor-bd
DB_NAME=txurdigest
DB_USER=usuario_app
DB_PASSWORD=secreto
```

Kodeak balio horiek kontsultatzen ditu:

```php
$dbHost = getenv('DB_HOST');
```

Aplikazioak ez du instalazio bakoitzeko balio zehatzak ezagutu behar.

## Konfigurazioa bereiztearen abantailak

Bereizketa honek honakoa ahalbidetzen du:

### Hainbat ingurune erabiltzea

Aplikazio bera honela exekuta daiteke:

```text
Garapena
    ↓
Tokiko datu-basea

Probak
    ↓
Probetako datu-basea

Produkzioa
    ↓
Benetako datu-basea
```

kodea aldatu gabe.

### Informazio sentikorra babestea

Honelako datuak:

- pasahitzak;
- API gakoak;
- tokenak;
- zerbitzu-kredentzialak;

ez dira argitaratuta amai dezaketen proiektu-fitxategietan gorde behar.

### Hedapena erraztea

Zerbitzari berri bat behar dituen aldagaiak emanez konfigura daiteke, aplikazioa aldatu gabe.

## Konfigurazio-fitxategiak

Framework batzuek honelako fitxategiak erabiltzen dituzte:

```text
.env
```

tokiko konfigurazioa gordetzeko.

Adibidez:

```text
APP_ENV=production
APP_DEBUG=false

DB_HOST=localhost
DB_DATABASE=txurdigest
```

Fitxategi horiek behar bezala kudeatu behar dira.

Ez dira biltegi publikoetan sartu behar.

## `.env` fitxategia eta Git

Ohiko akatsa da hau igotzea:

```text
.env
```

biltegira.

Horrek honakoa agerian utz dezake:

- pasahitzak;
- gako pribatuak;
- tokenak;
- konexio-datuak.

Ohiko praktika da honetan sartzea:

```text
.gitignore
```

eta adibide-fitxategi bat ematea:

```text
.env.example
```

beharrezko egiturarekin baina benetako sekreturik gabe.

Adibidea:

```text
DB_HOST=
DB_DATABASE=
DB_USERNAME=
DB_PASSWORD=
```

## Mendekotasunak eta produkzio-modua

Aplikazioek kanpoko liburutegiak erabiltzen dituzte normalean.

Garapenean tresna gehigarriak instala daitezke:

- arazketa;
- probak;
- analisia;
- dokumentazio-sorkuntza.

Produkzioan beharrezko mendekotasunak bakarrik instalatu behar dira.

Beharrezkoak ez diren osagaiak murrizteak esposizio-azalera txikitzen du.

## Laravel eta produkzioko konfigurazioa

Laravel aplikazioetan ohikoa da hau berrikustea:

```text
APP_ENV
APP_DEBUG
APP_KEY
```

Produkzio-ingurune batek honakoa erabili beharko luke:

```text
APP_ENV=production

APP_DEBUG=false
```

Gakoak:

```text
APP_KEY
```

existitu behar du eta sekretu gisa mantendu.

Konfigurazioa aldatu ondoren, baliteke konfigurazio-cacheak garbitu edo birsortu behar izatea.

## PHP eta produkzioko konfigurazioa

PHPrekin ere badira aukera garrantzitsuak.

Adibidez:

```text
display_errors
```

Garapenean:

```text
display_errors = On
```

programazioa erraztu dezake.

Produkzioan:

```text
display_errors = Off
```

erabiltzaileari xehetasun teknikoak erakustea saihesten du.

Erroreak barne-mekanismoen bidez erregistratu behar dira.

## Ingurune bakoitzerako kodea ez aldatzea

Praktika txar bat honakoa litzateke:

```php
if ($entorno === 'produccion') {
    $conexion = "...";
}
```

balioak zuzenean kodean idatzita.

Horrek aplikazio-logika eta konfigurazioa nahasten ditu.

Hobe da:

```php
$conexion = getenv('DB_CONNECTION');
```

Aplikazioak inguruneak emandako konfigurazioa erabiltzen du.

## TxurdiGest-en adibidea

Garapenean:

```text
Zerbitzaria:
localhost

Datu-basea:
txurdigest_dev

Debug:
aktibo
```

Produkzioan:

```text
Zerbitzaria:
barne-zerbitzaria

Datu-basea:
txurdigest_prod

Debug:
desaktibatuta
```

TxurdiGest-en kodea ez da aldatzen.

Ingurunearen konfigurazioa bakarrik aldatzen da.

## Argitaratu aurreko checklist-a

Hedapena egin aurretik, hau egiaztatu beharko litzateke:

```text
[ ] DEBUG desaktibatuta

[ ] Errore teknikoak ezkutatuta

[ ] Sekretuak kodetik kanpo

[ ] Ingurune-aldagaiak konfiguratuta

[ ] .env fitxategia babestuta

[ ] Beharrezko mendekotasunak instalatuta

[ ] Produkziorako konfigurazioa berrikusita

[ ] Proba-datuak ezabatuta
```

## Gako-ideia

> Konfigurazioa segurtasunaren parte da. Kode bera segurua edo ez-segurua izan daiteke exekutatzen den ingurunea nola konfiguratzen den arabera.
