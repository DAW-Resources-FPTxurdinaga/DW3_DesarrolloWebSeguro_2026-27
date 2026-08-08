# HTTP segurtasun-goiburuak

HTTP goiburuei esker, web zerbitzariak informazio osagarria eman diezaioke nabigatzaileari, erantzun bat nola kudeatu behar duen adierazteko.

Datuak garraiatzeaz gain, HTTPk segurtasun-politika jakin batzuk ezartzea ahalbidetzen du, web aplikazio baten exekuzioan arrisku batzuk murrizten laguntzeko.

Goiburu hauek hedapenaren konfigurazioaren parte dira.

## Web zerbitzaria politiken jatorri gisa

Web aplikazio batek ez du soilik eduki segurua sortu behar.

Nabigatzaileari ere adierazi behar dio zein portaera dauden baimenduta.

Kontzeptualki:

```text
Web zerbitzaria

    ↓

HTTP erantzuna

    ↓

Segurtasun-goiburuak

    ↓

Nabigatzaileak politikak aplikatzen ditu
```

Web zerbitzariak murrizketa jakin batzuk komunikatzen dizkio bezeroari.

## Goiburuak eta garapen segurua

Segurtasun-goiburuek aurretik landutako beste neurri batzuk osatzen dituzte:

```text
Sarreren baliozkotzea

        +

Irteera segurua

        +

Autentikazioa

        +

Web zerbitzariaren konfigurazioa

        +

HTTP goiburuak
```

Ez dute kode segurua ordezkatzen.

Babes-geruza osagarri bat dira.

## Content-Security-Policy (CSP)

Goiburuak:

```http
Content-Security-Policy
```

baliabide jakin batzuk zein jatorritatik karga daitezkeen definitzeko aukera ematen du.

Honelako elementuak kontrola ditzake:

- scriptak;
- estiloak;
- irudiak;
- iturriak;
- kanpoko konexioak.

Adibide kontzeptuala:

```http
Content-Security-Policy:
default-src 'self'
```

Horrek adierazten du, lehenespenez, baliabideak jatorri beretik etorri behar direla.

## XSS-rekin lotura

CSPk XSS eraso jakin batzuen inpaktua murrizten lagun dezake.

Adibidez, politika murriztaile batek zaildu dezake nabigatzaileak baimendu gabeko scriptak exekutatzea.

Hala ere:

```text
CSPk

ez du ordezkatzen

irteeraren ihesa + baliozkotzea
```

Aplikazioak eduki segurua sortzen jarraitu behar du.

## X-Content-Type-Options

Goiburuak:

```http
X-Content-Type-Options
```

nabigatzaileak deklaratutako motaz bestelako gisa baliabide bat interpretatzen saiatzea saihesteko balio du.

Adibidea:

```http
X-Content-Type-Options: nosniff
```

Edukiak interpretatzearekin lotutako ustekabeko portaera batzuk murrizten ditu.

## Strict-Transport-Security (HSTS)

Goiburuak:

```http
Strict-Transport-Security
```

nabigatzaileari adierazten dio HTTPS erabili behar duela denbora-tarte jakin batean.

Adibidea:

```http
Strict-Transport-Security:
max-age=31536000
```

Horrek HTTP bidezko ondorengo sarbideak saihesten laguntzen du.

HTTPS behar bezala konfiguratuta dagoenean bakarrik erabili behar da.

## Referrer-Policy

Nabigatzaile batek orri batetik bestera eskaera bat egiten duenean, jatorrizko orriari buruzko informazioa bidal dezake.

Goiburuak:

```http
Referrer-Policy
```

zein informazio partekatzen den kontrolatzeko aukera ematen du.

Adibidea:

```http
Referrer-Policy: strict-origin
```

Beste gune batzuetara bidalitako informazio kantitatea murrizten du.

## Permissions-Policy

Goiburuak:

```http
Permissions-Policy
```

nabigatzailearen gaitasun jakin batzuk kontrolatzeko aukera ematen du.

Adibideak:

- kamera;
- mikrofonoa;
- geolokalizazioa.

Gaitasun bat erabiltzen ez duen aplikazio batek murriztu egin dezake.

## Web zerbitzaritik konfigurazioa

Goiburu hauek normalean hemen konfiguratzen dira:

- Apache;
- Nginx;
- aplikazio-zerbitzariak;
- hedapen-plataformak.

Adibide kontzeptuala Apache-n:

```apache
Header always set X-Content-Type-Options "nosniff"
```

Kokapen zehatza erabilitako web zerbitzariaren araberakoa da.

## Goiburuak ulertu gabe ez gehitzea

Jardunbide txarra da goiburuen zerrenda bat kopiatzea haren efektua ezagutu gabe.

Politika bakoitzak behar bati erantzun behar dio:

```text
Zer babesten du?

Zer apur dezake?

Aplikazioak funtzionalitate hau behar du?
```

Gehiegi murriztailea den konfigurazio batek aplikazioak ondo funtzionatzea eragotz dezake.

## Nabigatzailean egiaztatzea

Goiburuak DevTools bidez berrikus daitezke:

```text
Network

    ↓

Eskaera hautatu

    ↓

Response Headers
```

HTTPS konfigurazioaren eta goiburuen analisi-tresna externoak ere erabil daitezke.

## TxurdiGest-en adibidea

HTTPS erantzun batek honakoa izan dezake:

```http
Content-Security-Policy: default-src 'self'

X-Content-Type-Options: nosniff

Referrer-Policy: strict-origin
```

Nabigatzaileak aplikazioa nola interpretatu behar duenari buruzko argibide osagarriak jasotzen ditu.

## Checklist-a

```text
[ ] HTTPS behar bezala konfiguratuta

[ ] Goiburuak berrikusita

[ ] CSP aplikaziora egokituta

[ ] Ez dira analisirik gabe kopiatutako politikak erabiltzen

[ ] DevTools-ek erantzunak egiaztatzea ahalbidetzen du

[ ] Politikak aplikatu ondoren aplikazioak funtzionatzen jarraitzen du
```

## Gako-ideia

> Segurtasun-goiburuek web zerbitzaritik politikak gehitzeko aukera ematen dute, baina geruza osagarri gisa funtzionatzen dute: ez dute garapen segurua ordezkatzen.
