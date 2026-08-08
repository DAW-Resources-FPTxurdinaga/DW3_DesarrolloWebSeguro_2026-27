# Azken jarduera: erronkaren segurtasun-berrikuspena

## Testuingurua

Proiektuaren segurtasuna erronkan garatutako benetako aplikazioaren gainean egiaztatu ahal izan behar da.

Jarduera honek moduluan landutako edukiak biltzen ditu:

- kodearen berrikuspena;
- segurtasun-probak;
- egiaztapen-tresnak;
- hedapenaren berrikuspena;
- checklista;
- ebidentziak.

Ez da txosten luze bat sortzea bilatzen.

Helburua azken berrikuspen ordenatu bat egitea eta kontrol garrantzitsuenak justifikatzea da.

## Helburua

Proiektuaren segurtasun-egoera honako hauen bidez egiaztatzea:

```text
Berrikuspena

    ↓

Probak

    ↓

Zuzenketak

    ↓

Ebidentziak
```

Amaitzean, taldeak galdera honi erantzuteko gai izan behar du:

> Zer segurtasun-kontrol aplikatu ditugu eta nola froga dezakegu funtzionatzen dutela?

## Antolaketa

Jarduera bi fasetan egin daiteke:

### 1. fasea. Taldearen beraren berrikuspena

Talde bakoitzak bere aplikazioa berrikusten du blokeko checklista erabiliz.

### 2. fasea. Berrikuspen gurutzatua

Beste talde batek puntu zehatz batzuk berrikusten ditu.

Berrikuspen gurutzatuaren helburua ez da beste taldea kalifikatzea.

Konturatu gabe pasa daitezkeen alderdiak hautematea da.

## 1. Kontrol kritikoak hautatu

Ez da beharrezkoa puntu guztiak sakontasun berarekin berrikustea.

Talde bakoitzak bere proiekturako kontrol garrantzitsuenak hautatu behar ditu.

Gutxienez, honako hauek berrikusi:

```text
[ ] Baliozkotzea

[ ] Autentifikazioa

[ ] Baimena

[ ] Datuetarako sarbidea

[ ] Sekretuak

[ ] Produkzioko konfigurazioa

[ ] HTTPS

[ ] Erroreak eta logak
```

Aplikazioak erabiltzen dituenean beste kontrol batzuk gehitu:

```text
[ ] Fitxategien igoera

[ ] APIak

[ ] CORS

[ ] Segurtasun-goiburuak

[ ] Rolak

[ ] Cookieak
```

## 2. Funtzionalitate oso bat berrikusi

Funtzionalitate garrantzitsu bat hautatu.

Adibidez:

```text
Erreserba bat editatu
```

Jarraitu haren fluxua:

```text
Sarrera

    ↓

Baliozkotzea

    ↓

Autentifikazioa

    ↓

Baimena

    ↓

Datuetarako sarbidea

    ↓

Erantzuna
```

Egiaztatu kontrol bakoitza dagokion lekuan dagoela.

## 3. Probak exekutatu

Gutxienez honako hauek egin:

```text
[ ] Kasu baliodun bat

[ ] Sarrera baliogabe bat

[ ] Autentifikaziorik gabeko proba bat

[ ] Baimen-proba bat

[ ] Dagokionean identifikatzaile baten manipulazioa

[ ] Errore kontrolatu bat
```

Proba bakoitzak espero den emaitza aldez aurretik adierazi behar du.

## 4. Tresnak erabili

Aukeratu tresna egiaztapenaren arabera.

Adibideak:

| Egiaztapena | Tresna |
|---|---|
| HTTP eskaerak | DevTools |
| Cookieak | DevTools Application |
| Parametroak aldatu | Burp Suite |
| Eskaerak errepikatu | Burp Repeater |
| Goiburuak | DevTools / `curl` |
| Barne-erroreak | Logak |

Ez da beharrezkoa tresna guztiak erabiltzea informazio erabilgarririk ematen ez badute.

## 5. Hedapena berrikusi

Egiaztatu:

```text
[ ] HTTPS aktibo

[ ] DEBUG desgaituta

[ ] Sekretuak kodetik kanpo

[ ] .env babestuta

[ ] Datu-basea ez dago agerian

[ ] Baimen egokiak

[ ] Goiburuak berrikusita

[ ] Logak babestuta
```

## 6. Berrikuspen gurutzatua

Talde berrikusleak honako hauek jasotzen ditu:

- aplikaziorako sarbidea;
- funtzionalitatearen azalpen laburra;
- erabilitako checklista.

Hiru eta bost egiaztapen artean hautatu behar ditu.

Adibidez:

```text
Autentifikatu gabe sar daiteke?

ID bat alda dezake?

Manipulatutako sarrera baliozkotzen da?

Erroreek informazioa erakusten dute?

Erantzunak HTTPS erabiltzen du?
```

Talde berrikusleak honako hau bakarrik erregistratzen du:

```text
Zuzena

edo

Berrikusi
```

eta arazo bat hautematen duenean azalpen labur bat.

## 7. Zuzendu

Aurkitutako arazoak sailkatu behar dira.

```text
Kritikoa

Garrantzitsua

Hobekuntza
```

Ez da beharrezkoa arriskuen kudeaketarako metodologia formal bat erabiltzea.

Sailkapenak lehenik zer zuzendu erabakitzeko balio du.

Lehentasuna eman honako hauekin lotutako arazoei:

- baimena;
- datuetarako sarbidea;
- sekretuak;
- autentifikazioa;
- produkzioko esposizioa.

## 8. Probak errepikatu

Zuzenketa baten ondoren:

```text
Arazoa

    ↓

Zuzenketa

    ↓

Proba errepikatu

    ↓

Emaitza zuzena
```

Arazo bat ez da zuzendutzat jo behar kodea aldatu delako soilik.

Berriro egiaztatu behar da.

## 9. Ebidentziak prestatu

Hautatu behar diren ebidentziak bakarrik.

Erreferentzia gisa:

```text
4–6 ebidentzia
```

nahikoak izan daitezke ohiko proiektu baterako.

Adibideak:

- beste baten baliabidearen aurrean 403 erantzuna;
- zerbitzariko baliozkotzea;
- HTTPS aktibo;
- cookie segurua;
- sekretua kodetik kanpo;
- errore kontrolatua;
- HTTP goiburuak;
- produkzioko konfigurazioa.

## 10. Ebidentziak babestu

Entregatu aurretik, egiaztatu:

```text
[ ] Ez dira pasahitzak agertzen

[ ] Ez dira token osoak agertzen

[ ] Ez dira saio-cookie osoak agertzen

[ ] Ez dira API gakoak agertzen

[ ] Ez dira kredentzialak agertzen

[ ] Ez dira beharrezkoak ez diren datu pertsonalak agertzen
```

## Entregagaia

Entrega laburra izan behar da.

Sartu:

### 1. Azken checklista

Kontrol garrantzitsuak honela markatuta:

```text
Egiaztatuta

Zuzenduta

Justifikatutako egiteke

N/A
```

### 2. Egindako probak

Gomendatutako taula:

| Proba | Espero dena | Lortutakoa | Egoera |
|---|---|---|---|
| Kasu balioduna | Zuzena | | |
| Sarrera baliogabea | Baztertuta | | |
| Autentifikatu gabe | Ukatuta | | |
| Beste baten baliabidea | Ukatuta | | |
| Errore kontrolatua | Segurua | | |

### 3. Ebidentziak

Lau eta sei ebidentzia garrantzitsu artean.

### 4. Zuzenketak

Adierazi aurkitutako arazo esanguratsuak eta aplikatutako zuzenketa bakarrik.

Adibidez:

```text
Arazoa:
erabiltzaile batek beste baten erreserba kontsulta zezakeen

Zuzenketa:
baliabidea itzuli aurretik jabea egiaztatzea

Egiaztapena:
proba errepikatu ondoren HTTP 403
```

## TxurdiGest-en aplikatzea

Azken berrikuspenaren adibidea:

```text
1. A erabiltzaileak saioa hasten du

2. Bere erreserba kontsultatzen du

3. IDa aldatzen du

4. B-ren erreserba kontsultatzen saiatzen da

5. Zerbitzariak 403 itzultzen du

6. Ebidentzia gordetzen da
```

Beste egiaztapen bat:

```text
1. Formularioak personas = -2 eragozten du

2. Burp-ek eskaera aldatzen du

3. Zerbitzariak personas = -2 jasotzen du

4. Zerbitzariak eskaera baztertzen du

5. Ebidentzia gordetzen da
```

## Jardueraren amaiera

Amaitu aurretik, labur erantzun:

```text
Zein kontrol izan da garrantzitsuena?

Zer arazo hauteman da?

Zer zuzenketa egin da?

Zer geratzen da egiteke?
```

Ez da hausnarketa luzea bilatzen.

Helburua da taldeak bere aplikazioaren benetako segurtasun-egoera ezagutzea.

## Ideia nagusia

> Azken berrikuspena ez da proiektua segurua dela esatea, baizik eta kontrol garrantzitsuak hautatzea, probatzea eta haien benetako portaeraren ebidentziak ematea.
