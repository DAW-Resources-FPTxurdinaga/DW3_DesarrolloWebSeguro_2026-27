# Praktika: tresnekin egiaztatzea

## Testuingurua

Egiaztapen-tresnek eskaerak behatzea, datuak aldatzea eta aplikazioak benetan nola erantzuten duen egiaztatzea ahalbidetzen dute.

Praktika honetan moduluan zehar landutako tresnak erabiliko dira.

Helburua ez da aplikazioa irizpiderik gabe arakatzea.

Tresna bakoitza galdera zehatz bati erantzuteko erabili behar da.

## Helburua

Aplikazioaren funtzionalitate baten gainean hainbat egiaztapen egitea honako hauek erabiliz:

- Chrome DevTools;
- Burp Suite;
- logak;
- `curl`, erabilgarria denean.

Egiaztapen bakoitzak eskema hau jarraitu behar du:

```text
Galdera

    ↓

Tresna

    ↓

Proba

    ↓

Emaitza

    ↓

Ebidentzia
```

## 1. urratsa. Funtzionalitate bat hautatu

HTTP eskaerak sortzen dituen funtzionalitate bat aukeratu.

Adibideak:

- saioa hasi;
- erreserbak kontsultatu;
- baliabide bat editatu;
- formulario bat bidali;
- API bat kontsumitu.

Adibidez:

```text
Erreserba bat editatu
```

## 2. urratsa. Eskaera DevTools-ekin behatu

Ireki:

```text
DevTools

    ↓

Network
```

Exekutatu funtzionalitatea.

Hautatu dagokion eskaera.

Erregistratu:

- URLa;
- HTTP metodoa;
- egoera-kodea;
- parametroak;
- eskaeraren gorputza;
- erantzuna.

Adibidez:

```text
PUT /api/reservas/25

Status: 200
```

## 3. urratsa. Headers berrikusi

Eskaeraren barruan berrikusi:

```text
Request Headers

Response Headers
```

Egiaztatu:

```text
[ ] Eskaerak HTTPS erabiltzen du

[ ] Eduki mota zuzena da

[ ] Espero diren segurtasun-goiburuak daude

[ ] Ez da beharrezkoa ez den informaziorik agerian uzten
```

Funtzionalitateak cookieak erabiltzen baditu, berrikusi haien atributuak ere.

## 4. urratsa. Cookieak berrikusi

Ireki:

```text
DevTools

    ↓

Application

    ↓

Cookies
```

Hautatu saio-cookiea.

Dagokionean, egiaztatu:

```text
[ ] Secure

[ ] HttpOnly

[ ] SameSite
```

Ez sartu cookiearen balio osoa ebidentzietan.

## 5. urratsa. Eskaera bat Burp Suite-rekin aldatu

Atzeman funtzionalitatearekin lotutako eskaera bat.

Adibidez:

```text
POST /reservas

fecha=2026-08-10
personas=2
```

Aldatu balio bat.

Adibidez:

```text
personas=-5
```

Bidali eskaera.

Espero den emaitza:

```text
Zerbitzariak datua baztertzen du
```

Erregistratu:

```text
Egoera-kodea:
________________

Erantzuna:
________________

Emaitza:
________________
```

## 6. urratsa. Repeater erabili

Bidali eskaera bat Burp Repeater-era.

Hautatu parametro edo identifikatzaile bat.

Adibidez:

```text
GET /reservas/25
```

Aldatu:

```text
25 → 26
```

Bidali berriro.

Egiaztatu:

```text
[ ] Baimena berriro ebaluatzen da

[ ] Ez da besteen baliabideetara sartzen

[ ] Egoera-kodea koherentea da
```

## 7. urratsa. Errore-erantzun bat berrikusi

Errore kontrolatu bat eragin.

Adibidez:

- existitzen ez den baliabidea;
- identifikatzaile baliogabea;
- datu okerra.

Behatu erantzuna DevTools edo Burp erabiliz.

Egiaztatu:

```text
[ ] Ez dira barneko ibilbideak agertzen

[ ] Ez dira SQL kontsultak agertzen

[ ] Ez dira salbuespen osoak agertzen

[ ] Ez dira sekretuak agertzen

[ ] Mezua egokia da erabiltzailearentzat
```

## 8. urratsa. Logak berrikusi

Errorea eragin ondoren, egiaztatu aplikazioaren barneko erregistroa.

Logak arazoa ulertzeko aukera eman beharko luke, beharrezkoa ez den informazioa gorde gabe.

Adibidez:

```text
Data

Erabiltzailea

Eragiketa

Errore teknikoa
```

Egiaztatu:

```text
[ ] Errorea erregistratuta geratzen da

[ ] Ez dira pasahitzak agertzen

[ ] Ez dira token osoak agertzen

[ ] Ez dira sekretuak agertzen
```

## 9. urratsa. Goiburuak curl-ekin egiaztatu

Inguruneak aukera ematen duenean:

```bash
curl -I https://txurdigest.ejemplo
```

Behatu itzulitako goiburuak.

Egiaztatu hedapenean definitu direnak.

Adibidez:

```text
Content-Security-Policy

X-Content-Type-Options

Strict-Transport-Security

Referrer-Policy
```

Ez da beharrezkoa aplikazio guztiek konfigurazio bera izatea.

Probak proiekturako definitutako konfigurazioa egiaztatu behar du.

## 10. urratsa. Ebidentziak erregistratu

Egiaztapen bakoitzerako adierazi:

```text
Galdera

Erabilitako tresna

Espero den emaitza

Lortutako emaitza

Ebidentzia
```

Adibidez:

```text
Galdera:
erabiltzaile batek beste baten erreserbara sar daiteke?

Tresna:
Burp Repeater

Espero den emaitza:
403

Lortutako emaitza:
403

Ebidentzia:
eskaeraren eta erantzunaren pantaila-argazkia
```

## Ebidentzia baliodunak

Honako hauek erabil daitezke:

- DevTools Network-eko pantaila-argazkia;
- Application > Cookies pantaila-argazkia, balioa erakutsi gabe;
- Burp-en aldatutako eskaera;
- HTTP erantzuna;
- `curl` bidez lortutako goiburuak;
- anonimizatutako log-zatia.

## Entregatu behar ez den informazioa

Ez sartu pantaila-argazkietan:

```text
Pasahitzak

Token osoak

Saio-cookie osoak

API gakoak

Kredentzialak

Sekretuak
```

Informazio sentikorra agertzen bada, ezkutatu egin behar da ebidentzia entregatu aurretik.

## TxurdiGest-en aplikatzea

Ibilbide-adibidea:

```text
1. DevTools

PUT /api/reservas/25 behatu


2. Burp

25 → 26 aldatu


3. Zerbitzaria

Baimena egiaztatu


4. Erantzuna

403 espero


5. Logak

Barne-errorea sortzen ez dela egiaztatu
```

Ibilbide honek kontrol zehatz bat frogatzen du.

## Azken checklist-a

```text
[ ] Eskaera bat DevTools-ekin behatu da

[ ] Goiburuak berrikusi dira

[ ] Dagokionean, cookieak berrikusi dira

[ ] Eskaera bat Burp-ekin aldatu da

[ ] Repeater erabili da

[ ] Errore kontrolatu bat egiaztatu da

[ ] Logak berrikusi dira

[ ] Aplikagarria denean curl erabili da

[ ] Ebidentziek ez dute sekreturik

[ ] Tresna bakoitzak galdera zehatz bati erantzuten dio
```

## Ideia nagusia

> Tresnek ez dute proba ordezkatzen: aplikazioaren portaera modu objektiboan behatu, aldatu eta frogatzea ahalbidetzen dute.
