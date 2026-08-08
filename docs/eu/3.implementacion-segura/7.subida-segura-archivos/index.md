# Fitxategi-karga segurua

Erabiltzaile batek fitxategiak igotzea baimentzea arrisku gehigarri batzuk dakartza, aplikazioak ondoren gorde eta zerbitzarian eskuragarri utzi ditzakeelako.

Arazoa ez da soilik fitxategiaren luzapena egiaztatzea.

Inplementazio segurua kontrolatu behar du:

- zein fitxategi onartzen diren;
- zenbateko tamaina izan dezaketen;
- zer motatako edukia daukaten;
- nola izendatzen diren;
- non gordetzen diren;
- zein baimen dituzten;
- exekutatu daitezkeen ala ez;
- norrek sarbidea izan dezakeen.

## Fitxategi batek bere izena baino informazio gehiago dauka

Demagun erabiltzaileak:

```text
informe.pdf
```

aukeratzen duela.

Aplikazioak hainbat elementu jasotzen ditu:

```text
Izen deklaratua
MIME mota
Tamaina
Edukia
Igoeraren errore-kodea
```

PHP-n informazio hau normalean `$_FILES`-en agertzen da.

Adibidez:

```php
$_FILES['documento']['name']
$_FILES['documento']['type']
$_FILES['documento']['size']
$_FILES['documento']['tmp_name']
$_FILES['documento']['error']
```

Ezin da erabat fidatu nabigatzaileak bidalitako datu horietara soilik, izan ere, ez dira fidagarriak.

## Izena ez da edukia zehazten

```text
documento.pdf
```

izeneko fitxategi batek ez du zertan PDF izan.

Eta soilik:

```php
str_ends_with($nombre, '.pdf')
```

egiaztatzeak ez du bermatzen edukia motatxo hori dela.

Luzapena egiaztapena osagarri bat izan daiteke, baina ez da bakarrik erabili behar.

## Nabigatzaileak bidalitako MIME mota ere ez da nahikoa

Nabigatzaileak balio hau bidal dezake:

```text
application/pdf
```

baina datu hori eskaeraren parte da eta manipula daiteke.

Beraz, zerbitzariak jasotako fitxategia bere mekanismo propioekin aztertu behar du.

PHP-n, adibidez, `finfo` erabil daiteke.

## Tamaina mugatu

Fitxategi mugagabeak onartzeak honakoak kontsumitu ditzake:

- disko espazioa;
- memoria;
- prozesatzeko denbora;
- banda-zabalera.

Beraz, aplikazioak arrazoizko tamaina maximoa ezarri behar du.

## Ez gorde zuzenean bidalitako izena

Inplementazio ez-seguru batek honela egin lezake:

```php
$nombre = $_FILES['documento']['name'];

$ruta = 'uploads/' . $nombre;
```

Jatorrizko izena bezeroak kontrolatzen du.

Gainera, honako arazoak sor ditzake:

- talka;
- gainidazketa;
- izen arazoak;
- informazioaren erakustea;
- bide ezustekoak.

Praktika segurua izendatzea zerbitzarian sortzea da.

## Biltegiaren kokapena garrantzitsua da

Fitxategi igotakoak zuzenean zerbitzari web-aren direktorio publiko batean gordetzeak arrisku gehiago handitzen du.

Adibidez:

```text
/var/www/html/uploads/
```

Baliteke zerbitzariak fitxategi mota batzuk bertan exekutatzeko baimena izatea.

Ahal denean, fitxategiak direktorio publikoaren kanpoan gorde behar dira eta deskarga aplikazioak kontrolatu behar du.

## Soilik beharrezkoa dena onartu

Aplikazioak bakarrik beharrezko fitxategi motak onartu behar ditu.

Adibidez, funtzionalitateak PDF dokumentuak soilik behar baditu:

```text
Onartzen da:
application/pdf
```

ez du zentzurik lehenetsita onartzea:

```text
edozein fitxategi
```

## Igo eta exekutatu ez dira gauza berdinak

Aplikazio batek dokumentu bat gorde behar duela esan dezake.

Hori ez da esan nahi zerbitzariak dokumentu hori interpretatu edo exekutatu behar duenik.

Erregela izan behar da:

> **Erabiltzaileek igotako fitxategiak datu gisa tratatu behar dira.**

## Baimenak

Fitxategi-kargaren segurtasuna ez da fitxategia balioztatu ondoren amaitzen.

Baita ere egiaztatu behar da:

- nor igotzen duen;
- zein baliabiderekin lotuta dagoen;
- nor deskargatu dezakeen;
- nor ezabatu dezakeen.

## TxurdiGest-en adibidea

Demagun TxurdiGest-ek PDF formatuan justifikante bat erantsi ahal izatea baimentzen duela.

Aplikazioak honela definitu lezake:

```text
Baimendutako mota: PDF
Tamaña maximoa: 5 MB
Izena: zerbitzariak sortua
Kokapena: direktorio publikoaren kanpoan
Sarbidea: soilik baimendutako erabiltzaileei
```

Fluxua hau izango litzateke:

```text
Fitxategia jasota
       ↓
zerbitzaria balidatzen du
       ↓
biltegi pribatuan gordetzen du
       ↓
aplikazioa kontrolatzen du deskarga
```

## Laburpena

- Fitxategi-karga bat sarrera ez fidagarri bat da.
- Fitxategiaren izena, luzapena edo nabigatzaileak bidalitako MIME mota ez dira nahikoa.
- Fitxategiak zerbitzariak zein modutan tratatu behar diren kontrolatu behar da.
- Biltegiaren kokapena, izenak, tamaina eta baimenak parte dira segurtasunetik.
