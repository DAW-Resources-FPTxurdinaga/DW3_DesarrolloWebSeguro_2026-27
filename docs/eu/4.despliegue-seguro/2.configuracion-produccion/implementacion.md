# Produkzioko konfigurazioaren inplementazioa

Produkzio-konfigurazioak aplikazioak ingurune erreal batean funtzionatzea ahalbidetu behar du, iturburu-kodea aldatu gabe.

Ideia nagusia hau da:

```text
Kode bera

        ↓

Konfigurazio desberdinak

        ↓

Ingurune desberdinak
```

Aplikazioak exekutatzeko behar dituen balioak ingurunetik jaso behar ditu.

## Ingurune-aldagaiak PHPrekin

PHPrekin ingurune-aldagaietara honen bidez sar daiteke:

```php
getenv()
```

Adibidez:

```php
$dbHost = getenv('DB_HOST');

$dbName = getenv('DB_DATABASE');

$dbUser = getenv('DB_USERNAME');

$dbPassword = getenv('DB_PASSWORD');
```

Aplikazioak balio horiek erabiltzen ditu, baina ez daki non definituta dauden.

## Datu-baserako konexioaren adibidea

Konexio ez-seguru batek honakoa izan lezake:

```php
$pdo = new PDO(
    'mysql:host=localhost;dbname=txurdigest',
    'admin',
    'password123'
);
```

Arazkoa da:

- kredentzialak kodean daudela;
- Git-en amai dezaketela;
- ingurune guztiek balio berak erabiliko lituzketela;
- konfigurazioa aldatzeko aplikazioa aldatu behar dela.

Alternatiba bat:

```php
$pdo = new PDO(
    getenv('DB_DSN'),
    getenv('DB_USERNAME'),
    getenv('DB_PASSWORD')
);
```

Orain konfigurazioa ingurunearena da.

## `.env` fitxategia

Framework askok ingurune-aldagaietan oinarritutako konfigurazio-fitxategiak erabiltzen dituzte.

Adibidea:

```text
APP_ENV=production
APP_DEBUG=false

DB_HOST=servidor-bd
DB_DATABASE=txurdigest
DB_USERNAME=usuario_app
DB_PASSWORD=secreto
```

`.env` fitxategia lan egiteko modu erosoa da, baina babestu egin behar da.

Ez da:

- argitaratu behar;
- biltegira bidali behar;
- beharrik gabe partekatu behar.

## `.env.example`

Ohiko praktika da txantiloi bat mantentzea:

```text
APP_ENV=
APP_DEBUG=

DB_HOST=
DB_DATABASE=
DB_USERNAME=
DB_PASSWORD=
```

Txantiloi horrek aplikazioak zer aldagai behar dituen adierazten du, baina ez du informazio sentikorrik.

Fluxua honakoa litzateke:

```text
.env.example

        ↓

kopiatu

        ↓

.env benetako balioekin
```

## Konfigurazioa Git-ekin

Fitxategia:

```text
.env
```

normalean honetan sartu beharko litzateke:

```text
.gitignore
```

Adibidea:

```text
.env
```

Horrela, Git-ek ez du biltegian sartuko.

Ondoren, egiaztatu daiteke:

```bash
git status
```

zain dagoen fitxategi gisa agertzen ez dela ikusteko.

## Laravel-en konfigurazioa produkzioan

Laravelrek ingurune-aldagaiak erabiltzen ditu honen bidez:

```text
.env
```

Balio garrantzitsu batzuk:

```text
APP_ENV=production

APP_DEBUG=false

APP_KEY=clave-secreta
```

Bereziki garrantzitsua:

```text
APP_DEBUG=false
```

Produkzioan ez zaizkio erabiltzaileari salbuespen osoak erakutsi behar.

Aplikazio batek honakoa agerian utz lezake:

- barne-bideak;
- kontsultak;
- framework-aren egitura;
- zerbitzariaren informazioa.

## Konfigurazio-cachea Laravel-en

Laravelrek konfigurazio konpilatua gordetzeko aukera ematen du errendimendua hobetzeko.

Ingurune-aldagaiak aldatu ondoren, baliteke cachea eguneratu behar izatea:

```bash
php artisan config:cache
```

Aplikazioak erabiltzen duen konfigurazioak benetako ingurunearekin bat etorri behar du.

## Produkzioko mendekotasunak

Produkzioan instalatutako mendekotasunak beharrezkoak direnak bakarrik izan behar dira.

Adibidez, PHPrekin eta Composerrekin:

```bash
composer install --no-dev --optimize-autoloader
```

Aukerak:

```text
--no-dev
```

garapenean soilik erabiltzen diren mendekotasunak instalatzea saihesten du.

Beharrezkoak ez diren osagaiak murrizteak esposizio-azalera txikitzen du.

## Inguruneen bereizketa

Aplikazio berak honakoa izan dezake:

```text
Garapena

DB_DATABASE=txurdigest_dev


Probak

DB_DATABASE=txurdigest_test


Produkzioa

DB_DATABASE=txurdigest_prod
```

Kodea ez da aldatzen.

Konfigurazio-balioak aldatzen dira.

## Gakoen eta sekretuen kudeaketa

Balio batzuek babes berezia behar dute:

- pasahitzak;
- API gakoak;
- tokenak;
- ziurtagiri pribatuak;
- zifratze-gakoak.

Ez dira honakoetan gorde behar:

```text
iturburu-kodean

ezta

biltegietan ere
```

Ingurune profesionaletan sekretuak kudeatzeko sistema espezifikoak erabil daitezke.

DAW proiektu baterako, oinarrizko printzipioa hau da:

> Sekretu batek aplikazioa exekutatzen den ingurunean egon behar du, ez iturburu-kodearen barruan.

## Web zerbitzariaren konfigurazioa

Zerbitzariaren konfigurazioa ere hedapenaren parte da.

Adibideak:

- erro-direktorio zuzena;
- fitxategi pribatuak irisgarri ez egotea;
- PHP kodearen exekuzioa;
- baimen egokiak;
- errore ikusgairik ez.

Aplikazioa eta zerbitzaria batera konfiguratu behar dira.

## Argitaratu aurreko egiaztapenak

Oinarrizko berrikuspena:

```text
[ ] APP_DEBUG desaktibatuta

[ ] Ingurune-aldagaiak konfiguratuta

[ ] .env ez argitaratuta

[ ] Sekretuak Git-etik kanpo

[ ] Garapeneko mendekotasunak ezabatuta

[ ] Produkzioko kredentzial zuzenak

[ ] Konfigurazioa berrikusita
```

## TxurdiGest-en adibidea

Garapenean:

```text
DB_HOST=localhost

DB_DATABASE=txurdigest_dev

APP_DEBUG=true
```

Produkzioan:

```text
DB_HOST=db-interno

DB_DATABASE=txurdigest

APP_DEBUG=false
```

Proiektuak kode bera mantentzen du.

Inguruneak emandako konfigurazioa bakarrik aldatzen da.

## Gako-ideia

> Produkzioko konfigurazioa ingurunera egokitu behar da, aplikazioaren kodea aldatzera behartu gabe.
