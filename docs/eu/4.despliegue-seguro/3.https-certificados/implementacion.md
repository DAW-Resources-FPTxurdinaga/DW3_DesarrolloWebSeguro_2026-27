# HTTPS eta ziurtagirien inplementazioa

Produkzioan HTTPS aktibatzeak zerbitzaria behar bezala konfiguratzea, ziurtagiri baliozko bat instalatzea eta aplikazio osoak komunikazio seguruak erabiltzen dituela egiaztatzea dakar.

Helburua ez da bakarrik nabigatzailean giltzarrapoa agertzea, baizik eta honakoa bermatzea:

- domeinua behar bezala identifikatuta dagoela;
- komunikazioa zifratuta dagoela;
- cookie sentikorrak babestuta bidaiatzen dutela;
- HTTP bidezko sarbide ez-segururik ez dagoela.

## Ziurtagiria eta gako pribatua

TLS ziurtagiri bat zerbitzaria identifikatzen duen informazio publikoz osatuta dago.

Lotutako gako pribatuak konexioan zehar zerbitzariaren identitatea frogatzeko aukera ematen du.

Harremana honakoa da:

```text
Ziurtagiri publikoa
        +
Gako pribatua
        ↓
HTTPS komunikazio segurua
```

Gako pribatua bereziki babestu behar da.

Inoiz ez da:

- biltegian sartu behar;
- kodean kopiatu behar;
- beharrik gabe partekatu behar.

## Ziurtagiriaren instalazioa

Hedapeneko ohiko prozesua hau da:

```text
Ziurtagiria lortu

        ↓

Ziurtagiria web zerbitzarian instalatu

        ↓

HTTPS gunea konfiguratu

        ↓

Zerbitzaria berrabiarazi edo birkargatu

        ↓

Funtzionamendua egiaztatu
```

Konfigurazio zehatza erabilitako zerbitzariaren araberakoa da.

## Adibide kontzeptuala Apacherekin

Apache zerbitzari batek HTTPS gune bat konfiguratuta izan behar du.

Kontzeptualki:

```text
<VirtualHost *:443>

    ServerName txurdigest.ejemplo

    SSLEngine on

    SSLCertificateFile certificado.crt

    SSLCertificateKeyFile clave-privada.key

</VirtualHost>
```

Izen eta bide zehatzak instalazioaren araberakoak dira.

Garrantzitsuena ulertzea da:

- ziurtagiria publikoa dela;
- gako pribatua babestuta egon behar dela;
- zerbitzariak biak erabiltzen dituela HTTPS ezartzeko.

## HTTPtik HTTPSra birbideratzea

HTTPS aktibatu ondoren, HTTP bidezko sarbide ez-seguruek ez lukete mantendu behar.

Ohiko konfigurazio bat:

```text
80 ataka
    ↓
301 birbideratzea
    ↓
443 ataka
```

Erabiltzailea beti HTTPS erabiltzera iristen da.

Adibidea:

```text
http://txurdigest.ejemplo

        ↓

https://txurdigest.ejemplo
```

## Eduki mistoa saihestea

HTTPS aplikazio batek bere babesaren parte bat gal dezake baliabideak HTTP bidez kargatzen baditu.

Adibide okerra:

```html
<script src="http://ejemplo.com/app.js"></script>
```

Orrialde nagusiak HTTPS erabili arren, baliabide hori babesik gabe eskatzen da.

Hau erabili behar da:

```html
<script src="https://ejemplo.com/app.js"></script>
```

edo bide erlatiboak:

```html
<script src="/app.js"></script>
```

## Egiaztapena nabigatzailetik

Nabigatzailearen tresnek honakoa egiaztatzeko aukera ematen dute:

- erabilitako ziurtagiria;
- HTTPS eskaerak;
- kargatutako baliabideak;
- bidalitako cookieak.

Adibidez, DevTools-en:

```text
Network

        ↓

HTTPS protokoloa egiaztatu
```

Honakoa ere berrikus daiteke:

```text
Application

        ↓

Cookies

        ↓

Secure atributua
```

## Saioko cookieak eta HTTPS

Saioak dituen aplikazio batek cookieak babestu beharko lituzke.

Adibidea:

```http
Set-Cookie:
session_id=abc123;
Secure;
HttpOnly;
SameSite=Lax
```

Atributuak:

```text
Secure
```

cookiea HTTP konexioen bidez bidaltzea saihesten du.

HTTPSk eta cookieen konfigurazio egokiak batera egiten dute lan.

## Berritze automatikoa

Ziurtagiriek iraupen mugatua dute.

Hedapen profesional batek honakoa aurreikusi behar du:

```text
Ziurtagiri baliozkoa
        ↓
Iraungitze-data
        ↓
Berritzea
        ↓
Egiaztapen berria
```

Berritze automatikoak ziurtagiri iraungien ondoriozko etenaldien arriskua murrizten du.

## HTTPS AWS-en

AWSeko ohiko hedapenetan aukera desberdinak egon daitezke:

```text
Erabiltzailea

    ↓ HTTPS

Karga-banatzailea / web zerbitzaria

    ↓

Aplikazioa

    ↓

Datu-base pribatua
```

edo:

```text
Erabiltzailea

    ↓ HTTPS

Apache/Nginx web zerbitzaria

    ↓

PHP/Laravel aplikazioa
```

Arkitektura zehatza egindako hedapenaren araberakoa izango da.

Erabaki garrantzitsua da kanpo-komunikazioa babestuta egotea eta barne-zerbitzuak beharrezkoa ez den moduan agerian ez egotea.

## Hedapenaren egiaztapena

HTTPS amaitutzat jo aurretik:

```text
[ ] Domeinuak HTTPS erabiltzen du

[ ] Ziurtagiria baliozkoa da

[ ] HTTP HTTPS-ra birbideratzen da

[ ] Ez dago HTTP baliabide nahasirik

[ ] Gako pribatua babestuta dago

[ ] Cookieek Secure erabiltzen dute dagokienean

[ ] Ziurtagiriak aurreikusitako berritzea du
```

## TxurdiGest-en adibidea

Hedapen zuzena:

```text
Nabigatzailea

https://txurdigest.ejemplo

        ↓

Apache/Nginx

        ↓

Laravel/PHP

        ↓

Barneko datu-basea
```

Erabiltzailea ez da inoiz zuzenean sartzen barne-zerbitzuetara.

Komunikazio publikoak HTTPS erabiltzen du.

## Gako-ideia

> HTTPS behar bezala konfiguratzea hedapen seguruaren parte da: ez da nahikoa ziurtagiri bat instalatzea, aplikazioaren komunikazio-fluxu osoa berrikusi behar da.
