# Sekretuak eta ingurune-aldagaiak

Aplikazioek konfigurazio-informazioa behar dute beste zerbitzu batzuekin konektatzeko.

Adibide batzuk:

- datu-baseko kredentzialak;
- API gakoak;
- tokenak;
- zifratze-gakoak;
- kanpoko zerbitzuen pasahitzak.

Datu horiek beharrezkoak dira aplikazioak funtzionatzeko, baina ez dira negozio-logikaren parte.

Horregatik, kanpoko konfigurazio gisa kudeatu behar dira.

## Kodea eta sekretuak

Praktika ez-seguru bat da sekretuak zuzenean kodean sartzea.

Adibidea:

```php
$usuario = "admin";
$password = "clave123";
```

edo:

```javascript
const apiKey = "abc123";
```

Ikuspegi horrek hainbat arazo sortzen ditu:

- sekretua kodearekin batera gordeta geratzen da;
- biltegi batean ager daiteke;
- beste ingurune batzuetara kopiatu daiteke;
- kredentzialak aldatzea zailtzen du.

Aplikazioak sekretua nola lortu jakin behar du, baina ez du zuzenean barruan eduki behar.

## Kodearen eta konfigurazioaren arteko bereizketa

Gomendatutako eredua:

```text
Iturburu-kodea

        +

Ingurunearen konfigurazioa

        ↓

Aplikazioa exekutatzen
```

Kode berak konfigurazio desberdinak erabil ditzake:

```text
Garapena

Probetako datu-basea


Produkzioa

Benetako datu-basea
```

Aplikazioa aldatu gabe.

## Ingurune-aldagaiak

Ingurune-aldagaiek informazioa prozesuari emateko aukera ematen dute abiarazten denean.

Adibidea:

```text
DB_HOST=servidor-interno
DB_DATABASE=txurdigest
DB_USERNAME=usuario_app
DB_PASSWORD=secreto
```

Aplikazioak balio horiek kontsultatzen ditu:

```php
$password = getenv('DB_PASSWORD');
```

Kodeak ez du benetako balioa ezagutzen.

## Informazio sentikorraren motak

Datu guztiek ez dute garrantzi bera.

Adibide batzuk:

### Kredentzialak

```text
Erabiltzailea
Pasahitza
Sarbide-tokenak
```

Zerbitzu baten aurrean autentikatzeko balio dute.

### Gako kriptografikoak

Adibidea:

```text
APP_KEY
SECRET_KEY
```

Honelako eragiketetarako erabiltzen dira:

- zifratzea;
- datuen sinadura;
- tokenen sorkuntza.

### Kanpoko zerbitzuen gakoak

Adibidez:

```text
API_KEY
```

kanpoko zerbitzuekin komunikatzeko.

Guztiak sekretu gisa babestu behar dira.

## `.env` fitxategia

Ingurune askok fitxategi hau erabiltzen dute:

```text
.env
```

tokiko konfigurazioa gordetzeko.

Adibidea:

```text
APP_ENV=production
APP_DEBUG=false

DB_HOST=db-interno
DB_PASSWORD=secreto
```

Fitxategi hau erosoa da garapenean, baina informazio sentikorra dauka.

Beraz:

```text
.env

EZ da argitaratu behar
```

## Git biltegiak

Akatsik ohikoenetako bat da sekretuak nahi gabe biltegira igotzea.

Adibidea:

```bash
git add .
git commit
git push
```

`.env` sartuta badago, kredentzialak proiektuaren historian gordeta gera daitezke.

Ohiko prebentzioa:

```text
.gitignore
```

Adibidea:

```text
.env
```

## Ez da nahikoa argitaratutako sekretu bat ezabatzea

Pasahitz bat nahi gabe Git-era igotzen bada, fitxategia commit geroago batean ezabatzeak ez du beti arazoa konpontzen.

Sekretua hemen gera daiteke:

- historian;
- kopietan;
- klonetan;
- kanpoko sistemetan.

Jardunbide zuzena hau da:

```text
Esposizioa detektatu

        ↓

Sekretua ezeztatu edo aldatu

        ↓

Aztarnak ezabatu, beharrezkoa bada

        ↓

Konfigurazioa eguneratu
```

Lehentasuna konprometitutako sekretua baliogabetzea da.

## Pribilegio minimoaren printzipioa

Sekretu batek ez ditu behar baino baimen gehiago eman behar.

Adibide okerra:

```text
Web aplikazioa

        ↓

Datu-basearen administratzaile-erabiltzailea
```

Aplikazioak taula jakin batzuk kontsultatu eta aldatu besterik behar ez badu, ez luke baimen osoak dituen kontu bat erabili behar.

Gomendatutako eredua:

```text
Aplikazioa

        ↓

Erabiltzaile espezifikoa

        ↓

Beharrezko baimenak
```

## Sekretuen errotazioa

Sekretuak ez lirateke mugagabe mantendu behar.

Kudeaketa egoki batek honakoa hartzen du kontuan:

- sorrera;
- biltegiratze segurua;
- erabilera;
- berritzea;
- erretiratzea.

Prozesu horri sekretuen errotazioa deitzen zaio.

## Sekretuak ingurune desberdinetan

Ingurune bakoitzak bere balio propioak izan behar ditu.

Adibidea:

```text
Garapena

DB_PASSWORD=dev_password


Probak

DB_PASSWORD=test_password


Produkzioa

DB_PASSWORD=prod_password
```

Inoiz ez litzateke kredentzial bera erabili behar ingurune guztietarako.

## Ingurune-aldagaiak hedapenean

Hedapenean, zerbitzariak beharrezko konfigurazioa eman behar du.

Kontzeptualki:

```text
Zerbitzaria

        ↓

Ingurune-aldagaiak

        ↓

Aplikazioa

        ↓

Kanpoko zerbitzuak
```

Aplikazioak exekutatzean jasotzen ditu balioak.

## 3. blokearekiko lotura

3. blokean hau landu zen:

```text
Sekretuak kodean ez gordetzea
```

Bloke honetan hau lantzen dugu:

```text
Sekretu horiek hedapenean nola eman
```

Printzipio beraren bi une desberdin dira.

## TxurdiGest-en adibidea

Konfigurazio okerra:

```php
$conexion = new PDO(
    "mysql:host=db",
    "usuario",
    "password"
);
```

Konfigurazio egokia:

```php
$conexion = new PDO(
    getenv('DB_DSN'),
    getenv('DB_USER'),
    getenv('DB_PASSWORD')
);
```

Produkzioan:

```text
Zerbitzaria

DB_PASSWORD=valor_real

        ↓

TxurdiGest
```

Biltegiak ez du inoiz pasahitza edukitzen.

## Checklist-a

Hedapena egin aurretik:

```text
[ ] Kodean ez dago sekreturik

[ ] .env ez dago argitaratuta

[ ] Git-ek fitxategi sentikorrak baztertzen ditu

[ ] Ingurune bakoitzak bere sekretuak erabiltzen ditu

[ ] Kontuek gutxieneko baimenak dituzte

[ ] Berritze-prozedura bat dago

[ ] Sekretuak zerbitzarian konfiguratuta daude
```

## Gako-ideia

> Sekretuak aplikazioa exekutatzen den ingurunean egon behar dira, ez iturburu-kodearen barruan.
