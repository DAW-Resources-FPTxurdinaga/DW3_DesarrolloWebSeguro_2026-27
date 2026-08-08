# Praktika: segurtasun-probak diseinatu eta exekutatzea

## Testuingurua

Segurtasun-proba batek egoera zehatz bat egiaztatu behar du eta lortutako emaitza espero den portaerarekin alderatu.

Praktika honetan talde bakoitzak proba-multzo txiki bat diseinatu eta exekutatuko du bere aplikazioko funtzionalitate baten gainean.

Ez da proiektu osoa probatzea bilatzen.

Helburua kasu adierazgarri batzuk hautatu eta modu ordenatuan exekutatzea da.

## Helburua

Honako hauekin lotutako probak diseinatu, exekutatu eta erregistratzea:

- baliozkotzea;
- autentifikazioa;
- baimena;
- erroreak;
- APIak edo formularioak;
- baliabideetarako sarbidea.

Proba bakoitzak argi adierazi behar du:

```text
Hasierako egoera

        ↓

Egindako ekintza

        ↓

Espero den emaitza

        ↓

Lortutako emaitza
```

## 1. urratsa. Funtzionalitate bat hautatu

Proba positiboak eta negatiboak egiteko aukera ematen duen funtzionalitate bat aukeratu.

Adibideak:

- erreserba bat editatu;
- eskaera bat kontsultatu;
- profil bat aldatu;
- fitxategi bat igo;
- eremu pribatu batera sartu;
- API baten endpoint bat kontsumitu.

## 2. urratsa. Kasu balioduna definitu

Egoera okerrak probatu aurretik, funtzionalitateak behar bezala funtzionatzen duela egiaztatu.

Adibidez:

```text
Autentifikatutako erabiltzailea

        ↓

Bere erreserba editatzen du

        ↓

Datu baliodunak

        ↓

Eguneratze zuzena
```

Erregistratu:

```text
Proba:
norberaren erreserba editatzea

Espero dena:
200 edo birbideratze zuzena

Lortutakoa:
________________

Egoera:
________________
```

## 3. urratsa. Sarrera baliogabe bat probatu

Sarrerako datu bat aldatu.

Adibideak:

```text
Ezinezko data

Zenbaki negatiboa

Testu luzeegia

Derrigorrezko eremu hutsa
```

Erregistratu:

```text
Proba:
________________

Aldatutako datua:
________________

Espero dena:
eskaera baztertzea

Lortutakoa:
________________

Egoera:
________________
```

Egiaztatu:

```text
[ ] Zerbitzariak balioa baztertzen du

[ ] Ez da barne-errorea sortzen

[ ] Erakutsitako mezua kontrolatua da
```

## 4. urratsa. Bezeroaren baliozkotzea saihestu

JavaScript bidezko baliozkotzea badago, egiaztatu zerbitzaria ez dela haren mende dagoen kontrol bakarra.

Erabil daitezke:

- DevTools;
- Burp Suite;
- eskaera zuzenean aldatzea.

Adibidez:

```text
Interfazeak

ez du onartzen:

personas = -2
```

Eskaera aldatu:

```text
personas = -2
```

Espero den emaitza:

```text
Zerbitzariak eskaera baztertzen du
```

Erregistratu emaitza.

## 5. urratsa. Autentifikazioa probatu

Babestutako funtzionalitate bat hautatu.

Egiaztatu:

```text
[ ] Saio baliodunarekin funtzionatzen du

[ ] Saiorik gabe baztertzen da

[ ] Saio baliogabearekin baztertzen da

[ ] Saioa itxi ondoren sarbidea ez da mantentzen
```

Erregistratu gutxienez ebidentzia bat.

## 6. urratsa. Baimena probatu

Ahal denean, bi erabiltzaile desberdin erabili.

Adibidez:

```text
A erabiltzailea

jabe da:

25. erreserbarena
```

```text
B erabiltzailea

jabe da:

26. erreserbarena
```

Proba:

```text
A erabiltzailea

        ↓

26. erreserbara sartzen saiatzen da
```

Espero den emaitza:

```text
403

edo

Sarbidea ukatuta
```

Erregistratu:

```text
Proba:
A erabiltzailea B-ren baliabidera sartzen da

Espero dena:
________________

Lortutakoa:
________________

Egoera:
________________
```

## 7. urratsa. Identifikatzaile bat manipulatu

Identifikatzaile bat duen eskaera bat aurkitu.

Adibidez:

```text
GET /reservas/25
```

Aldatu:

```text
25 → 26
```

Egiaztatu aplikazioak baimena berriro egiaztatzen duen.

```text
[ ] IDa aldatzeak ez du besteen baliabideetara sartzea ahalbidetzen
```

## 8. urratsa. Erroreak probatu

Egoera kontrolatu bat eragin.

Adibideak:

- existitzen ez den baliabidea;
- datu baliogabea;
- baimendu gabeko eragiketa.

Egiaztatu:

```text
[ ] Ez dira barneko ibilbideak erakusten

[ ] Ez dira SQL kontsultak erakusten

[ ] Ez da traza osoa agertzen

[ ] Ez dira kredentzialak erakusten

[ ] Erabiltzaileak mezu egokia jasotzen du
```

## 9. urratsa. HTTP erantzuna berrikusi

DevTools edo Burp Suite erabili honako hauek behatzeko:

- egoera-kodea;
- goiburuak;
- erantzunaren gorputza.

Adibidez:

```text
Beste erabiltzaile baten baliabide-eskaera

        ↓

HTTP 403
```

Interfazeak mezu bat erakuts dezake, baina probak benetako HTTP erantzuna ere egiaztatu behar du.

## 10. urratsa. Probak erregistratu

Erabili taula edo antzeko formatu bat:

| Proba | Espero den emaitza | Lortutako emaitza | Egoera |
|---|---|---|---|
| Kasu balioduna | Zuzena | | |
| Sarrera baliogabea | Baztertuta | | |
| Autentifikatu gabe | Sarbidea ukatuta | | |
| Beste baten baliabidea | Sarbidea ukatuta | | |
| Errore kontrolatua | Informazio sentikorrik gabe | | |

Ez da beharrezkoa proba kopuru handia egitea.

Hobe da ondo definitutako proba gutxi egitea.

## Zuzenketa

Proba batek huts egiten badu:

```text
Proba

    ↓

Emaitza okerra

    ↓

Kausa aurkitu

    ↓

Zuzendu

    ↓

Proba errepikatu
```

Huts egindako proba batek ez du prozesua amaitzen.

Beharrezko hobekuntza bat aurkitzeko balio du.

## Ebidentziak

Entregak honako hauek izan ditzake:

- proben taula;
- DevTools edo Burp Suite-ko pantaila-argazkiak;
- aldatutako eskaera;
- HTTP erantzuna;
- egindako zuzenketa baten azalpen laburra.

Ez dira sartu behar:

- pasahitzak;
- tokenak;
- saio-cookie osoak;
- sekretuak;
- beharrezkoak ez diren datu pertsonalak.

## TxurdiGest-en aplikatzea

Gutxieneko proba-multzoaren adibidea:

```text
[ ] Erreserba baliodun bat sortu

[ ] Data baliogabea bidali

[ ] JavaScript saihestuz personas = -2 bidali

[ ] Erreserbetara autentifikatu gabe sartu

[ ] Norberaren erreserba kontsultatu

[ ] IDa aldatu beste baten erreserba eskatzeko

[ ] Existitzen ez den erreserba eskatu
```

Proba bakoitzak espero den emaitza aldez aurretik definituta izan behar du.

## Azken checklist-a

```text
[ ] Gutxienez kasu baliodun bat dago

[ ] Gutxienez sarrera baliogabe bat dago

[ ] Autentifikazioa probatu da

[ ] Baimena probatu da

[ ] Dagokionean, identifikatzaile bat manipulatu da

[ ] HTTP erantzun bat berrikusi da

[ ] Errore kontrolatu bat probatu da

[ ] Probek espero den emaitza dute

[ ] Aurkitutako hutsegiteak zuzendu edo dokumentatu dira
```

## Ideia nagusia

> Segurtasuna probatzea aplikazioak zer eragotzi behar duen definitzea, benetan egiaztatzea eta zuzenketa bakoitzaren ondoren proba errepikatzea da.
