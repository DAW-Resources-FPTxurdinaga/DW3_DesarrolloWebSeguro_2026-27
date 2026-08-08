# HTTPS eta ziurtagiriak

HTTPS nabigatzailearen eta zerbitzariaren arteko komunikazioa zifratze eta autentikazio bidez babesteko mekanismoa da.

1. blokean HTTPSren funtzionamendu kontzeptuala eta ziurtagirien konfiantza-katea aztertu ziren.

Kapitulu honetan, hedapenean duen aplikazioan jarriko dugu arreta:

- produkzioan HTTPS aktibatzea;
- zerbitzaria behar bezala konfiguratzea;
- ziurtagiri baliozkoak erabiltzea;
- trafiko ez-segurua birbideratzea;
- aplikazioak HTTPS gainean ondo funtzionatzen duela egiaztatzea.

## HTTPtik HTTPSra

HTTP bidez argitaratutako aplikazio batek komunikazioak babes kriptografikorik gabe transmititzen ditu.

```text
Bezeroa
   |
   | HTTP
   |
Zerbitzaria
```

Horrek komunikazioan zehar informazioa behatu edo aldatu ahal izatea ekar dezake.

HTTPSk babes-geruza bat gehitzen du:

```text
Bezeroa
   |
   | HTTPS
   |
Zerbitzaria
```

Komunikazioa TLS bidez babestuta geratzen da.

## HTTPS produkzioan

Garapenean ohikoa da hau erabiltzea:

```text
http://localhost
```

edo probako ziurtagiriak.

Hala ere, benetako erabiltzaileentzat eskuragarri dagoen aplikazio batek hau erabili behar du:

```text
https://dominio-ejemplo.com
```

Hedapenak honakoa jaso behar du:

- ziurtagiri baliozkoa;
- web zerbitzariaren konfigurazioa;
- ziurtagiriaren berritzea;
- HTTP trafikoaren birbideratzea.

## Ziurtagiri digitalak

Ziurtagiri batek identitate digital bat zerbitzari batekin lotzeko aukera ematen du.

Kontzeptualki:

```text
Zerbitzaria
    ↓
Ziurtagiri digitala
    ↓
Ziurtapen-agintaritza
    ↓
Nabigatzailearen konfiantza
```

Nabigatzaileak egiaztatzen du:

- ziurtagiria baliozkoa dela;
- eskatutako domeinuari dagokiola;
- aitortutako agintaritza batek sinatua dagoela;
- ez dela iraungi.

## Ziurtagiria lortzea

Ingurune erreal batean, ziurtagiriak normalean ziurtapen-agintaritza baten bidez lortzen dira.

Aukera ohiko bat honako hauek emandako ziurtagiriak erabiltzea da:

```text
Let's Encrypt
```

Ziurtagiri horiek nabigatzaile modernoek aitortzen dituzte eta berritzea automatizatzeko aukera ematen dute.

Prozesu orokorra:

```text
Ziurtagiriaren eskaera

        ↓

Domeinuaren baliozkotzea

        ↓

Zerbitzarian instalatzea

        ↓

HTTPS konfigurazioa

        ↓

Aldizkako berritzea
```

## Web zerbitzariaren konfigurazioa

Zerbitzariak honakoa ezagutu behar du:

- ziurtagiri publikoa;
- lotutako gako pribatua;
- HTTPS gunearen konfigurazioa.

Gako pribatua babestuta mantendu behar da.

Inoiz ez da:

- Gitera igo behar;
- hirugarrenei bidali behar;
- aplikazioaren kodean sartu behar.

## HTTPtik HTTPSra birbideratzea

Ohiko praktika bat da bi bertsio irisgarri egotea saihestea:

```text
http://ejemplo.com

https://ejemplo.com
```

Gomendatutako konfigurazioa:

```text
HTTP
  ↓
birbideratze iraunkorra
  ↓
HTTPS
```

Horrela, erabiltzaileak komunikazio babestua erabiltzera behartzen dira.

## Adibide kontzeptuala

Hasierako eskaera:

```text
Erabiltzailea

http://txurdigest.ejemplo
```

Zerbitzaria:

```text
301 Redirect

https://txurdigest.ejemplo
```

Eskaera berria:

```text
Erabiltzailea

https://txurdigest.ejemplo
```

Komunikazioak HTTPS erabiltzen jarraitzen du.

## Ziurtagirien berritzea

Ziurtagiriek iraungitze-data dute.

Beraz, hedapenak honakoa aurreikusi behar du:

- aldizkako berrikuspena;
- berritze automatikoa, ahal denean;
- ondorengo egiaztapena.

Iraungitako ziurtagiri batek segurtasun-abisuak eragiten ditu nabigatzaileetan.

## HTTPS eta cookieak

Aplikazio batek cookieen bidez saioak erabiltzen dituenean, HTTPSk segurtasun-atributu osagarriak erabiltzea ahalbidetzen du.

Adibidez:

```text
Secure
HttpOnly
SameSite
```

Atributuak:

```text
Secure
```

cookiea HTTPS bidez bakarrik bidali behar dela adierazten du.

Adibide kontzeptuala:

```http
Set-Cookie:
session=abc123;
Secure;
HttpOnly;
SameSite=Lax
```

## HTTPS eta APIak

Frontend eta backend bereizita dituzten arkitekturetan, bi osagaiek HTTPS erabili behar dute.

Adibidea:

```text
Frontend Vue

https://txurdigest.ejemplo

        ↓

API PHP

https://api.txurdigest.ejemplo
```

HTTPS eta HTTP nahasteak honakoa eragin dezake:

- nabigatzailearen abisuak;
- cookieekin arazoak;
- informazioaren esposizioa;
- nabigatzailearen politiken ondoriozko blokeoak.

## HTTPSn bakarrik ez fidatzea

HTTPSk komunikazioa babesten du, baina ez ditu beste kontrol batzuk ordezkatzen.

Aplikazio batek oraindik behar ditu:

- autentikazioa;
- baimena;
- baliozkotzea;
- datuen babesa;
- konfigurazio segurua.

HTTPSk kanala babesten du.

Ez du erabakitzen nork erabil dezakeen aplikazioa.

## Argitaratu aurreko egiaztapenak

Hedapena egin aurretik:

```text
[ ] Ziurtagiri baliozkoa instalatuta

[ ] Domeinu zuzena

[ ] HTTP-k HTTPS-ra birbideratzen du

[ ] Gako pribatua babestuta

[ ] Cookie sentikorrek Secure erabiltzen dute

[ ] Ez dago HTTP baliabide nahasirik

[ ] Berritzea konfiguratuta
```

## TxurdiGest-en adibidea

Hedapen zuzen bat hau litzateke:

```text
Erabiltzailea

https://txurdigest.ejemplo

        ↓

Web zerbitzaria

        ↓

PHP/Laravel aplikazioa

        ↓

Barneko datu-basea
```

Aplikazioa ez litzateke HTTP bidez erabilgarri egon behar.

Erabiltzailearen saioa konexio babestu baten bidez bakarrik transmititu behar da.

## Gako-ideia

> HTTPS ez da produkzioan aukerazko hobekuntza bat: beharrezko baldintza da erabiltzaileen eta aplikazioaren arteko komunikazioa babesteko.
