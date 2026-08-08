# Segurtasun-ebidentziak

Segurtasun-erabakiak frogatu ahal izan behar dira.

Proiektu batean ez da nahikoa neurri bat aplikatuta dagoela esatea.

Hori egiaztatzeko ebidentziaren bat egon behar da.

```text
Erabakia

    ↓

Inplementazioa

    ↓

Proba

    ↓

Ebidentzia
```

Ebidentziak baieztapen bat egiaztagarri bihurtzen du.

## Zer da ebidentzia bat?

Ebidentzia bat neurri batek benetan funtzionatzen duela egiaztatzeko aukera ematen duen elementua da.

Honako hau izan daiteke:

- pantaila-argazki bat;
- eskaera bat eta haren erantzuna;
- konfigurazio-zati bat;
- proba baten emaitza;
- kode-zati bat;
- checklist bat;
- anonimizatutako log bat;
- azalpen tekniko labur bat.

Erabaki guztiek ez dute ebidentzia mota bera behar.

## Ebidentzia erabilgarria

Ebidentzia batek honako ezaugarriak izan behar ditu:

- garrantzitsua;
- ulergarria;
- nahikoa;
- segurua.

Ez du behar den baino informazio gehiago izan behar.

Adibidez:

```text
Helburua:
baimena egiaztatu

Ebidentzia:
A erabiltzailearen eskaera B-ren baliabidearen gainean

Emaitza:
HTTP 403
```

Honek kontrola zuzenean frogatzen du.

## Pantaila-argazkiak

Pantaila-argazkiak erabilgarriak izan daitezke honako hauek erakusteko:

- HTTPS;
- ziurtagiria;
- goiburuak;
- cookieak;
- HTTP erantzuna;
- konfigurazio bisuala;
- errore kontrolatua.

Pantaila-argazki on batek behar dena bakarrik erakutsi behar du.

Saihestu pantaila osoaren argazkiak, zati txiki bat baino ez bada interesgarria.

## DevTools ebidentzia-iturri gisa

DevTools erabil daiteke honako hauen ebidentziak lortzeko:

- HTTP metodoa;
- egoera-kodea;
- goiburuak;
- payload-a;
- erantzuna;
- cookieak;
- CSP erroreak.

Adibidez:

```text
Network

GET /reservas/26

Status: 403
```

Ebidentzia honek baimenaren egiaztapena justifikatzeko balio du.

## Burp Suite ebidentzia-iturri gisa

Burp Suite-k eskaera bat aldatu dela frogatzea ahalbidetzen du.

Adibidez:

```text
Jatorrizko eskaera:

GET /reservas/25


Aldatutako eskaera:

GET /reservas/26
```

Emaitza:

```text
HTTP 403
```

Honek erakusten du erabiltzaileak eskaera manipulatzen duenean ere kontrola exekutatzen dela.

## Kodea ebidentzia gisa

Kode-zati batek kontrol bat nola inplementatu den erakuts dezake.

Adibidez:

```php
$stmt = $pdo->prepare(
    "SELECT * FROM reservas WHERE id = ?"
);

$stmt->execute([$id]);
```

Zati honek prestatutako kontsulten erabileraren ebidentzia babestu dezake.

Hala ere, kodea erakusteak ez du beti portaera zuzena dela frogatzen.

Ahal denean, proba batekin konbinatu behar da.

## Konfigurazioa ebidentzia gisa

Konfigurazio batek hedapen-erabakiak frogatu ditzake.

Adibidez:

```text
APP_DEBUG=false
```

edo:

```text
Content-Security-Policy: default-src 'self'
```

Ebidentziak honako hauek erakustea saihestu behar du:

```text
APP_KEY

DB_PASSWORD

API_KEY

tokenak
```

## Logak ebidentzia gisa

Logek errore bat nola kudeatu den frogatu dezakete.

Adibidez:

```text
Data

Erabiltzailea

Eragiketa

Errore teknikoa
```

Log bat ebidentzia gisa erabili aurretik, informazio sentikorra kendu edo anonimizatu egin behar da.

## Diagramak ebidentzia gisa

Diagrama batek arkitektura-erabakiak justifikatzen lagun dezake.

Adibidez:

```text
Internet

    ↓

Web zerbitzaria

    ↓

Aplikazioa

    ↓

Datu-base pribatua
```

Diagramak ez du berez frogatzen konfigurazioa aplikatuta dagoela.

Behar denean, beste egiaztapen batzuekin osatu behar da.

## Checklistak ebidentzia gisa

Checklist batek berrikuspen sistematikoa egin dela frogatzen laguntzen du.

Adibidez:

```text
[x] HTTPS

[x] DEBUG desgaituta

[x] Sekretuak kodetik kanpo

[x] Datu-base pribatua

[x] Logak babestuta
```

Checklistak proiektuaren benetako egoerari dagokio.

Ez da adierazpen soil gisa erabili behar.

## Gutxieneko ebidentzia nahikoa

Ez da beharrezkoa txosten handiak sortzea.

Erabaki baterako nahikoa izan daiteke:

```text
Erabakia:
jabeak bakarrik edita dezake erreserba bat

Proba:
A erabiltzaileak B-ren baliabidea editatzea eskatzen du

Emaitza:
403

Ebidentzia:
eskaeraren eta erantzunaren pantaila-argazkia
```

Hau erabilgarriagoa da asmoa azaltzen duten hainbat orrialde baino.

## Kontrolaren eta ebidentziaren arteko lotura

Ebidentzia bakoitzak galdera bati erantzun behar dio.

Adibideak:

| Kontrola | Ebidentzia posiblea |
|---|---|
| HTTPS | Nabigatzailea edo `curl` |
| Cookie segurua | DevTools Application |
| Baimena | Eskaera eta 403 erantzuna |
| Zerbitzariko baliozkotzea | Aldatutako eskaera |
| Prestatutako kontsulta | Kode-zatia |
| Sekretuak | Balio sentikorrik gabeko konfigurazioa |
| Goiburuak | DevTools edo `curl` |
| Erroreak | Erantzuna + anonimizatutako loga |

## Ebidentzia desegokiak

Ez dira ebidentzia onak:

- testuingururik gabeko pantaila-argazkia;
- zer egiaztatzen den adierazi gabe kode-bloke handiak;
- probarik gabeko checklist bat;
- emaitzarik gabeko baieztapen bat;
- sekretuak ikusgai dituen konfigurazioa.

Ebidentziak azkar ulertzeko aukera eman behar du:

```text
Zer egiaztatu nahi zen

Zer egin zen

Zer gertatu zen
```

## Informazio sentikorra babestea

Ebidentziak proiektuaren parte dira eta honako leku hauetan amaitu daitezke:

- biltegiak;
- entregak;
- aurkezpenak;
- dokumentazioa.

Beraz, ez dute honako hauek jaso behar:

```text
Pasahitzak

Token osoak

Saio-cookie osoak

API gakoak

Gako pribatuak

Datu-baseko kredentzialak

Beharrezkoa ez den informazio pertsonala
```

## Anonimizazioa

Ebidentzia batek garrantzitsua ez den informazioa badu, ezkutatu egin behar da.

Adibidez:

```text
Erabiltzailea:

alumno23
```

honela ordezka daiteke:

```text
A erabiltzailea
```

identitate zehatzak probari ezer gehitzen ez badio.

## ETHAZI erronketako ebidentziak

Ebidentziak erronkaren garapenean integratu behar dira.

Ez da beharrezkoa amaierara arte itxarotea.

Adibidez:

```text
Baimena inplementatu

        ↓

Probatu

        ↓

Ebidentzia jaso

        ↓

Garapenarekin jarraitu
```

Honek amaierako lana murrizten du eta arazoak lehenago hautematea ahalbidetzen du.

## TxurdiGest-en aplikatzea

Ebidentzia-multzo baten adibidea:

```text
Baliozkotzea

→ datu baliogabeko eskaera baztertuta


Baimena

→ A erabiltzaileak 403 jasotzen du B-ren baliabidean


HTTPS

→ ziurtagiri balioduna


Sekretuak

→ ingurune-aldagaien bidezko konfigurazioa


Goiburuak

→ Response Headers


Erroreak

→ mezu kontrolatua + barneko loga
```

Ez da beharrezkoa ebidentzia guztiek formatu bera izatea.

## Gutxieneko txantiloia

Ebidentzia bat dokumentatzeko honako hau erabil daiteke:

```text
Kontrola:
____________________________

Egindako egiaztapena:
____________________________

Espero den emaitza:
____________________________

Lortutako emaitza:
____________________________

Ebidentzia:
____________________________
```

Txantiloi hau kontrol garrantzitsuetarako bakarrik erabil daiteke.

## Ideia nagusia

> Segurtasun-ebidentzia batek labur eta modu objektiboan frogatu behar du kontrol bat existitzen dela eta funtzionatzen duela, informazio sentikorra agerian utzi gabe.
