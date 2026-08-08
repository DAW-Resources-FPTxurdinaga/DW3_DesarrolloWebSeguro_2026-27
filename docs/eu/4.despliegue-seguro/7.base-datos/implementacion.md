# Datu-basearen inplementazio segurua

Produkzioan datu-base baten inplementazioak bermatu behar du baimendutako aplikazioak bakarrik izan dezakeela datu-baserako sarbidea.

Konfigurazio seguruak honakoak konbinatzen ditu:

```text
Kokapen egokia

        +

Kredentzial babestuak

        +

Gutxieneko baimenak

        +

Segurtasun-kopiak
```

## Aplikaziorako erabiltzaile espezifiko bat sortzea

Aplikazioa ez litzateke administratzaile-erabiltzaileak erabiliz konektatu behar.

Adibide okerra:

```text
Erabiltzailea:

root

Baimenak:

denak
```

Aplikazioak segurtasun-arazo bat badu, pribilegio altuko erabiltzaile batek inpaktua handitzen du.

Gomendatutako eredua:

```text
Datu-basea

        ↓

Aplikazioaren erabiltzailea

        ↓

Beharrezko baimenak
```

## Baimenen adibidea

Aplikazio tipiko batek honakoa behar dezake:

```text
SELECT

INSERT

UPDATE

DELETE
```

Baina normalean ez du hau behar:

```text
CREATE USER

DROP DATABASE

Zerbitzariaren konfigurazioa aldatzea
```

Baimenak benetako eragiketetara egokitu behar dira.

## Konexioa konfiguraziotik sortzea

Aplikazioak konexio-datuak ingurune-aldagaien bidez lortu behar ditu.

Adibidea:

```text
DB_HOST=db-interno

DB_DATABASE=txurdigest

DB_USERNAME=txurdigest_app

DB_PASSWORD=secreto
```

Aplikazioak balio horiek erabiltzen ditu:

```php
$conexion = new PDO(
    getenv('DB_DSN'),
    getenv('DB_USERNAME'),
    getenv('DB_PASSWORD')
);
```

Iturburu-kodeak ez du kredentzialik izan behar.

## Administrazio-konexioak ez erabiltzea

Garapenean ohiko praktika bat da:

```text
root
```

erabiltzea, probak errazten dituelako.

Produkzioaren aurretik, erabiltzaile espezifiko batez ordeztu behar da.

Adibidea:

Garapena:

```text
root
```

Produkzioa:

```text
txurdigest_app
```

baimen mugatuekin.

## Sareko sarbidea murriztea

Datu-baseak beharrezko zerbitzuetatik datozen konexioak bakarrik onartu behar ditu.

Arkitektura:

```text
Web zerbitzaria

IP baimendua

        ↓

Datu-basea
```

Ez:

```text
Internet

        ↓

Datu-basea
```

AWSen kontrol hori sare-arauen eta Security Groups-en bidez egin daiteke.

## Security Groups-ekin adibidea

Web zerbitzaria:

```text
Sarrera:

443 HTTPS
22 SSH mugatua
```

Datu-basea:

```text
Sarrera:

3306

jatorria:
aplikazio-zerbitzaria
```

Datu-baseak ez ditu edozein jatorritako konexioak onartzen.

## Ingurune-aldagaiak produkzioan

Zerbitzarian:

```text
DB_HOST=db-privada

DB_DATABASE=txurdigest

DB_USERNAME=txurdigest_app

DB_PASSWORD=valor-real
```

Biltegian:

```text
Ez dago kredentzialik
```

Hedapenak beharrezko konfigurazioa ematen du.

## Datu-baseko migrazioak

Aplikazioek sarritan egitura eguneratu behar dute:

```text
Bertsio berria

        ↓

Migrazioa

        ↓

Datu-base eguneratua
```

Adibideak:

- taulak sortzea;
- zutabeak gehitzea;
- indizeak aldatzea.

Eragiketa horiek modu kontrolatuan egin behar dira.

## Migrazio okerren arriskuak

Gaizki diseinatutako migrazio batek honakoa eragin dezake:

- datuak galtzea;
- taulak blokeatzea;
- informazio okerra aldatzea.

Jardunbide onak:

- aurretik proba-ingurune batean probatzea;
- aurretik segurtasun-kopiak egitea;
- aldaketa suntsitzaileak berrikustea;
- leheneratze-prozedura bat mantentzea.

## Segurtasun-kopiak

Oinarrizko segurtasun-kopia batek:

```bash
mysqldump
```

datu guztiak dituen fitxategi bat sor dezake.

Fitxategi hori babestu egin behar da.

Adibidea:

```text
backup.sql
```

honakoa eduki dezake:

- erabiltzaileak;
- datu pertsonalak;
- negozio-datuak.

Ez luke publikoki eskuragarri egon behar.

## Segurtasun-kopien leheneratzea

Kopia bat erabilgarria da leheneratu daitekeenean bakarrik.

Egiaztatu beharrekoa:

```text
Kopia sortu

        ↓

Kopia leheneratu

        ↓

Aplikazioa egiaztatu
```

Probatu gabeko backup batek ez du berreskuratzea bermatzen.

## Biltegiratutako pasahitzak

Erabiltzaileen pasahitzak ez dira inoiz zuzenean gorde behar.

Okerra:

```text
erabiltzailea

contraseña123
```

Zuzena:

```text
erabiltzailea

hash
```

PHPn:

```php
password_hash()
```

eta:

```php
password_verify()
```

pasahitzak behar bezala kudeatzeko balio dute.

## Logak eta datu sentikorrak

Aplikazioaren logek ez lukete honakorik gorde behar:

- pasahitzak;
- tokenak;
- beharrezkoak ez diren datu osoak.

Adibide okerra:

```text
Erabiltzaile login:

ana

Pasahitza:

secreto123
```

Logak ere datu sentikortzat hartu behar dira.

## Administrazio-tresnak

Garapenean honakoak erabil daitezke:

- phpMyAdmin;
- bezero grafikoak;
- web panelak.

Produkzioan berrikusi egin behar dira.

Aukerak:

- ezabatu;
- sarbidea mugatu;
- autentikazio gehigarriarekin babestu;
- sarearen arabera mugatu.

## TxurdiGest-en adibidea

Konfigurazioa:

```text
Aplikazio-zerbitzaria

        ↓

Erabiltzailea:

txurdigest_app

        ↓

Datu-basea:

txurdigest
```

Baimenak:

```text
Beharrezko taulak erabil ditzake

Ezin du zerbitzari osoa administratu
```

Sarea:

```text
Internet

    ↓

Web zerbitzaria

    ↓

Datu-base pribatua
```

## Checklist-a

```text
[ ] Aplikazioak ez du administratzaile-erabiltzailerik erabiltzen

[ ] Kredentzialak kodetik kanpo daude

[ ] Datu-baseak ez du Internetetik konexiorik onartzen

[ ] Erabiltzaileak gutxieneko baimenak ditu

[ ] Migrazioak kontrolatuta daude

[ ] Segurtasun-kopiak babestuta daude

[ ] Leheneratzea probatu da

[ ] Administrazio-tresnak babestuta daude

[ ] Logek ez dute sekreturik jasotzen
```

## Gako-ideia

> Datu-basearen segurtasuna sarbidea nola programatzen denaren mende dago, baina baita exekutatzen den ingurunea nola konfiguratzen denaren mende ere.
