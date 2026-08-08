# Web zerbitzaria eta esposizio-azalera

Aplikazio bat Interneten argitaratzen denean, ez dago jada soilik garapen-taldearen kontrolpean.

Web zerbitzariak, aktibo dauden zerbitzuek, irekita dauden atakek eta sare-konfigurazioak zehazten dute aplikazioaren zer zati dauden kanpoko erabiltzaileentzat eskuragarri.

Hedapen seguruaren helburua esposizio-azalera murriztea da:

> Aplikazioak behar duena bakarrik egon behar da eskuragarri.

## Zer da esposizio-azalera

Esposizio-azalerak kanpoko interakzioak jaso ditzaketen elementu guztiak adierazten ditu.

Honakoak har ditzake barne:

- web orriak;
- APIak;
- ataka irekiak;
- sistemako zerbitzuak;
- datu-baseak;
- administrazio-panelak;
- fitxategi eskuragarriak;
- tresna osagarriak.

Zenbat eta elementu gehiago egon agerian, orduan eta handiagoa da erroreak edo konfigurazio okerrak izateko aukera.

Kontzeptualki:

```text
Agerian zerbitzu gehiago

        ↓

Esposizio-azalera handiagoa

        ↓

Babes handiagoaren beharra
```

## Web aplikazio baten oinarrizko arkitektura

Ohiko arkitektura bat:

```text
Erabiltzailea

   ↓ HTTPS

Web zerbitzaria

   ↓

Aplikazioa

   ↓

Datu-basea
```

Osagai bakoitzak ardura desberdina du.

Erabiltzaileak ez luke barneko elementu guztietara zuzenean sartu behar.

## Zerbitzuen esposizio egokia

Konfigurazio seguru batek sarbideak mugatzen saiatzen da:

```text
Internet

    ↓

HTTPS ataka

    ↓

Web zerbitzaria

    ↓

Aplikazioa

    ↓

Datu-base pribatua
```

Datu-basea ez litzateke zuzenean Interneten argitaratuta egon behar.

Eredu okerra:

```text
Internet

    ↓

Datu-basea
```

Aplikazioak bitartekari gisa jokatu behar du.

## Atakak eta zerbitzuak

Eskuragarri dagoen zerbitzu bakoitzak normalean komunikazio-ataka bat erabiltzen du.

Adibideak:

```text
HTTP
80

HTTPS
443

SSH
22

MySQL
3306
```

Horrek ez du esan nahi denak Internetetik eskuragarri egon behar dutenik.

Oinarrizko arau bat:

```text
Beharrezko zerbitzua

        ↓

Sarbidea baimendu


Beharrezkoa ez den zerbitzua

        ↓

Ez agerian utzi
```

## Gutxieneko sarbidearen printzipioa

Web zerbitzariaren konfigurazioak pribilegio minimoaren printzipioa aplikatu behar du.

Adibideak:

Web zerbitzari batek hau behar du:

```text
HTTPS eskaerak onartzea
```

baina ez du zertan behar:

```text
Internetetik datu-baserako zuzeneko konexioak onartzea
```

Konfigurazioak mugatu egin behar du nork komunikatu daitekeen zerbitzu bakoitzarekin.

## AWSekin lotura

AWSen kontrol hori honelako elementuen bidez aplika daiteke:

- Security Groups;
- azpisareak;
- zerbitzu publikoen eta pribatuen arteko bereizketa.

Ohiko arkitektura bat:

```text
Internet

    ↓

Web zerbitzari publikoa

    ↓

Barne-sarea

    ↓

Datu-base pribatua
```

Datu-basea aplikazioarekin komunika daiteke, baina ez egon zuzenean Internetetik eskuragarri.

## Security Groups

Security Group batek sareko sarbide-kontrol gisa funtzionatzen du.

Honakoa definitzeko aukera ematen du:

- zein ataka dauden irekita;
- zein jatorritatik;
- zein baliabidetara.

Adibidea:

Web zerbitzaria:

```text
Baimendu:

443 HTTPS
```

Datu-basea:

```text
Baimendu:

3306

web zerbitzaritik bakarrik
```

Erabaki garrantzitsua da sarbidea espezifikoa izatea.

## Web zerbitzariaren direktorio publikoa

Web zerbitzariak beharrezko fitxategiak bakarrik argitaratu behar ditu.

Adibidea:

```text
Aplikazioa

/app

    config/

    storage/

    vendor/

    public/

        index.php
```

Web zerbitzariak honetara apuntatu beharko luke:

```text
public/
```

eta ez aplikazio osora.

Horrela, hau agerian uztea saihesten da:

- konfigurazio-fitxategiak;
- mendekotasunak;
- barneko informazioa.

## Publikoak izan behar ez duten fitxategiak

Fitxategi batzuk ez lirateke inoiz URL bidez eskuragarri egon behar:

```text
.env

.git/

composer.json

logs/

segurtasun-kopiak
```

Honelako eskaera batek:

```text
https://ejemplo.com/.env
```

ez luke informaziorik itzuli behar.

## Panelak eta tresna osagarriak

Garapenean honelako tresnak egon daitezke:

- administrazio-panelak;
- probako orriak;
- arazketa-tresnak.

Produkzioaren aurretik berrikusi egin behar dira.

Beharrezko galderak:

```text
Beharrezkoa al da?

Nork izan behar du sarbidea?

Babestuta al dago?

Ezaba daiteke?
```

## Agerian dagoen informazioa murriztea

Web zerbitzariak ez luke beharrezkoa ez den informaziorik azaldu behar.

Adibideak:

Goiburuak:

```text
Zerbitzaria: Apache/2.x
PHP: 8.x
```

Mezuak:

```text
barne-bideak

bertsio zehatzak

errore teknikoak
```

Inguruneko informazioa mugatu egin behar da.

## Garapen seguruarekin lotura

Web zerbitzariaren konfigurazioak kodea osatzen du.

Adibidez:

Aplikazioak hau saihesten du:

```text
SQL Injection
```

Web zerbitzariak hau saihesten du:

```text
datu-basearen zuzeneko esposizioa
```

Babes-geruza desberdinak dira.

## TxurdiGest-en adibidea

Arkitektura egokia:

```text
Erabiltzailea

   ↓ HTTPS

Web zerbitzari publikoa

   ↓

Laravel/PHP aplikazioa

   ↓

Datu-base pribatua
```

Ez litzateke gomendagarria:

```text
Erabiltzailea

   ↓

Datu-basea
```

ezta:

```text
Erabiltzailea

   ↓

Aplikazioaren barne-karpeta
```

## Checklist-a

Argitaratu aurretik:

```text
[ ] Beharrezko atakak bakarrik daude irekita

[ ] Datu-basea ez da publikoa

[ ] Web zerbitzariak direktorio egokira apuntatzen du

[ ] Fitxategi sentikorrak ez dira eskuragarriak

[ ] Garapen-tresnak ezabatuta edo babestuta daude

[ ] Beharrezkoak ez diren zerbitzuak desaktibatuta daude

[ ] Security Groups berrikusita daude

[ ] Sare-arkitektura berrikusita dago
```

## Gako-ideia

> Hedapen segurua ez da zerbitzu guztiak irekitzea funtziona dezan, baizik eta aplikazioak funtzionatzeko beharrezko zerbitzuak bakarrik agerian uztea.
