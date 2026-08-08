# Sekretuen eta ingurune-aldagaien inplementazioa

Hedapenean sekretuak kudeatzea aplikazioari beharrezko konfigurazioa ematea da, informazio sentikorra iturburu-kodean sartu gabe.

Gomendatutako fluxua:

```text
Biltegia

(sekreturik gabe)

        ↓

Produkzioko zerbitzaria

(ingurune-aldagaiak)

        ↓

Aplikazioa

(kargatutako konfigurazioa)
```

## Ingurune-aldagaiak definitzea

Aplikazio batek konfigurazioa jaso dezake sistemako ingurune-aldagaien bidez.

Adibidea:

```text
APP_ENV=production

APP_DEBUG=false

DB_HOST=db-interno

DB_DATABASE=txurdigest

DB_USERNAME=usuario_app

DB_PASSWORD=secreto
```

Aldagai horiek aplikazioa exekutatzen den inguruneak ematen ditu.

## Aldagaiak PHPn kargatzea

PHPk ingurune-aldagaiak kontsultatzeko aukera ematen du honen bidez:

```php
getenv()
```

Adibidea:

```php
$host = getenv('DB_HOST');

$usuario = getenv('DB_USERNAME');

$password = getenv('DB_PASSWORD');
```

Aplikazioak balioak erabiltzen ditu, baina ez ditu kredentzialak barruan gordetzen.

## `.env` bidezko konfigurazioa

Garapenean fitxategi hau erabil daiteke:

```text
.env
```

Adibidea:

```text
DB_HOST=localhost

DB_DATABASE=txurdigest_dev

DB_USERNAME=root

DB_PASSWORD=
```

Fitxategi horrek konfigurazio desberdinekin lan egitea errazten du.

Hala ere:

```text
.env fitxategiak sekretuak ditu

        ↓

babestu egin behar da
```

## `.env` fitxategiaren babesa

`.env` fitxategia ez da:

- biltegira igo behar;
- beharrezkoak ez diren zerbitzarietara kopiatu behar;
- URL publiko baten bidez eskuragarri egon behar;
- kontrolik gabe partekatu behar.

Hauetan sartu behar da:

```text
.gitignore
```

Adibidea:

```text
.env
```

## `.env.example` fitxategia

Behar den konfigurazioa dokumentatzeko hau erabil daiteke:

```text
.env.example
```

Adibidea:

```text
APP_ENV=

APP_DEBUG=

DB_HOST=

DB_DATABASE=

DB_USERNAME=

DB_PASSWORD=
```

Fitxategi hori proiektuaren parte izan daiteke, ez duelako benetako baliorik.

Ohiko prozesua:

```text
.env.example

        ↓

kopiatu

        ↓

.env

        ↓

inguruneko balioak sartu
```

## Laravel eta ingurune-aldagaiak

Laravelrek normalean hau erabiltzen du:

```text
.env
```

konfigurazioa kargatzeko.

Adibidea:

```text
APP_ENV=production

APP_DEBUG=false

APP_KEY=valor-secreto
```

Produkzioan bereziki garrantzitsua da:

```text
APP_DEBUG=false
```

barneko informazioa erakustea saihesten duelako.

Konfigurazioa aldatu ondoren, cachea eguneratu behar izatea gerta daiteke:

```bash
php artisan config:cache
```

## Ingurune-aldagaiak Linux zerbitzari batean

Linux zerbitzari batean aldagaiak defini daitezke aplikazioa exekutatzen duen prozesuarentzat.

Kontzeptualki:

```text
Sistema eragilea

        ↓

PHP/Laravel prozesua

        ↓

Aplikazioa
```

Aplikazioak ez ditu balioak bere fitxategietan gorde behar.

## `.env` fitxategiaren baimenak

`.env` fitxategia egon arren, baimen egokiekin babestu behar da.

Aplikazioak irakurri ahal izan behar du, baina ez du baimenik gabeko erabiltzaileentzat eskuragarri egon behar.

Adibide kontzeptuala:

```text
Aplikazioaren jabea
        ↓
irakurketa baimenduta

Kanpoko erabiltzaileak
        ↓
sarbiderik gabe
```

Baimen-arazo bat ez da gehiegi irekitako konfigurazioekin konpondu behar.

## Sekretuak AWS-en

AWSeko hedapen batean konfigurazioa emateko modu desberdinak daude.

Adibidez:

```text
EC2 zerbitzaria

        ↓

Ingurune-aldagaiak

        ↓

Laravel/PHP aplikazioa
```

Ingurune profesionaletan sekretuak kudeatzeko zerbitzu espezifikoak ere erabil daitezke.

Printzipioa beti bera da:

```text
Zerbitzariak sekretua ezagutzen du.

Kodeak ez.
```

## Sekretuak aldatzea

Sekretu bat aldatu behar denean:

```text
Balio berria sortu

        ↓

Ingurunea eguneratu

        ↓

Aplikazioa berrabiarazi, beharrezkoa bada

        ↓

Balio zaharra baliogabetu
```

Ez litzateke beharrezkoa izan behar iturburu-kodea aldatzea.

## Esposatutako sekretuak egiaztatzea

Aplikazio bat argitaratu aurretik, komeni da honakoa berrikustea:

```text
[ ] Ez dago pasahitzik PHP fitxategietan

[ ] Ez dago API gakorik JavaScript-en

[ ] .env ez dago Git-en

[ ] .env ez da nabigatzailetik irisgarria

[ ] Produkzioko aldagaiak konfiguratuta daude

[ ] Ingurune bakoitzerako kredentzial desberdinak

[ ] Baimenak berrikusita
```

## TxurdiGest-en adibidea

Biltegia:

```text
TxurdiGest

Iturburu-kodea
.env.example
.gitignore
```

Zerbitzaria:

```text
Ingurune-aldagaiak

DB_HOST=db-interno

DB_PASSWORD=valor-real
```

Exekuzioa:

```text
Laravel

        ↓

konfigurazioa irakurtzen du

        ↓

zerbitzuekin konektatzen da
```

Benetako pasahitza ez da inoiz proiektuaren parte.

## Ohiko errorea

Praktika okerra:

```php
define(
    'DB_PASSWORD',
    'miPassword123'
);
```

Funtzionatu arren, segurtasun-arazo bat sortzen du.

Sekretua kodeari lotuta geratzen da.

Praktika zuzena:

```php
$password = getenv('DB_PASSWORD');
```

Inguruneak ematen du balioa.

## Gako-ideia

> Konfigurazio sentikorra hedapenean kudeatu behar da, ez aplikazioaren barruan gorde.
