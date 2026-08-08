# Segurtasun-probak

Kodearen berrikuspenak arazo asko hautematea ahalbidetzen du, baina ez da nahikoa berez.

Aplikazioak espero ez diren datuak, ekintzak edo eskaerak jasotzen dituenean nola jokatzen duen ere egiaztatu behar da.

Segurtasun-probek portaera hori egiaztatzea ahalbidetzen dute.

```text
Egoera

    ↓

Proba-ekintza

    ↓

Aplikazioaren erantzuna

    ↓

Espero den emaitza
```

Helburua ez da aplikazioa “haustea”, baizik eta modu seguruan erantzuten duela egiaztatzea.

## Proba positiboak eta negatiboak

Proba positibo batek baliozko funtzionalitate batek behar bezala funtzionatzen duela egiaztatzen du.

Adibidez:

```text
Autentifikatutako erabiltzailea

        ↓

Bere erreserbak kontsultatzen ditu

        ↓

Erantzun zuzena
```

Proba negatibo batek baimendu gabeko ekintza bat behar bezala baztertzen dela egiaztatzen du.

Adibidez:

```text
Autentifikatutako erabiltzailea

        ↓

Beste erabiltzaile baten erreserba kontsultatzen saiatzen da

        ↓

Sarbidea ukatuta
```

Bi proba motak beharrezkoak dira.

## Zer proba daiteke

Segurtasun-probek honako hauek izan ditzakete ardatz:

- sarrerako datuen baliozkotzea;
- autentifikazioa;
- baimena;
- saioak;
- fitxategien igoera;
- datuetarako sarbidea;
- APIak;
- erroreak;
- produkzioko konfigurazioa.

Ez da beharrezkoa dena aldi berean probatzea.

Hobe da fluxu zehatzak hautatzea.

## Sarrera baliogabeak probatzea

Aplikazio batek definitutako arauak betetzen ez dituzten datuak baztertu behar ditu.

Adibideak:

```text
Adin negatiboa

Formatu baliogaberik duen posta elektronikoa

Ezinezko data

Testu luzeegia

Tartetik kanpoko balioa
```

Probak honako hau egiaztatu behar du:

```text
[ ] Eskaera baztertzen da

[ ] Zerbitzariak datua baliozkotzen du

[ ] Ez da barne-errorea sortzen

[ ] Erabiltzaileak mezu kontrolatu bat jasotzen du
```

## JavaScript kontrol bakarra ez dela probatzea

Bezeroaren baliozkotzea alda edo saihestu daiteke.

Beraz, proba erabilgarri bat da interfazeak onartuko ez lukeen balio batekin eskaera zuzenean zerbitzarira bidaltzea.

Adibidez:

```text
Formularioa

        ↓

JavaScript-ek age = -5 bidaltzea eragozten du
```

Baina probak hau ere egiaztatu behar du:

```text
Aldatutako eskaera

age = -5

        ↓

Zerbitzaria
```

Espero den emaitza da zerbitzariak balioa berdin baztertzea.

## Autentifikazioa probatzea

Oinarrizko egiaztapen batzuk:

```text
[ ] Kredentzial baliodunek saioa hastea ahalbidetzen dute

[ ] Kredentzial okerrak baztertzen dira

[ ] Ezin da babestutako baliabideetara saiorik gabe sartu

[ ] Saioa ixteak sarbidea baliogabetzen du

[ ] Saio baliogabe batek ez du jarraitzea ahalbidetzen
```

Probak benetako emaitza behatu behar du, ez interfazea bakarrik.

## Baimena probatzea

Baimena egiaztatu beharreko kontrol garrantzitsuenetako bat da.

Adibidez:

```text
A erabiltzailea

        ↓

/reservas/25 atzitzen du

        ↓

Erreserba A erabiltzailearena da
```

Emaitza:

```text
Sarbidea baimenduta
```

Ondoren:

```text
A erabiltzailea

        ↓

25 ordez 26 jartzen du

        ↓

Erreserba B erabiltzailearena da
```

Espero den emaitza:

```text
Sarbidea ukatuta
```

Probak erakusten du kontrola baliabidearen araberakoa dela, ez soilik saio bat egotearen araberakoa.

## Rolak probatzea

Rol desberdinak daudenean, haien mugak egiaztatu behar dira.

Adibidez:

```text
Erabiltzaile arrunta

        ↓

/administracion
```

Espero den emaitza:

```text
403

edo

Sarbidea ukatuta
```

Baimendutako rolak sarbidea duela ere egiaztatu behar da.

## Fitxategien igoera probatzea

Probak honako hauek izan ditzake:

- baimendutako fitxategia;
- baimendu gabeko luzapena;
- tamaina handiegia;
- izen arraroa;
- fitxategi hutsa;
- izen errepikatua duen fitxategia.

Adibidez:

```text
imagen.jpg
```

Emaitza:

```text
Onartuta
```

Adibidez:

```text
archivo.php
```

Espero den emaitza:

```text
Baztertuta
```

Portaera aplikazioak definitutako arauen araberakoa izango da.

## Erroreak probatzea

Proba batek aplikazioak nola huts egiten duen ere egiaztatu behar du.

Adibidez:

```text
Existitzen ez den baliabidea eskatu

Datu baliogabea bidali

Baimendu gabeko eragiketa bat eragin
```

Erantzunak ez lituzke honako hauek erakutsi behar:

- barneko ibilbideak;
- traza osoak;
- SQL kontsultak;
- kredentzialak;
- arazketa-informazioa.

## Egoera-kodeak probatzea

HTTP egoera-kodeek portaera egiaztatzen laguntzen dute.

Ohiko adibideak:

```text
200 → eragiketa zuzena

400 → eskaera okerra

401 → autentifikazioa behar da

403 → sarbidea ez dago baimenduta

404 → baliabidea ez da aurkitu

422 → datuak ez dira baliozkoak

500 → barne-errorea
```

Kode zehatza aplikazioaren eta framework-aren araberakoa izango da.

Garrantzitsuena da erantzuna egoerarekin koherentea izatea.

## APIak probatzea

API bat web-interfaze bat bezala egiaztatu behar da.

Honako hauek proba daitezke:

- JSON balioduna;
- JSON osatugabea;
- espero ez diren eremuak;
- autentifikatu gabeko erabiltzailea;
- besteen baliabidea;
- HTTP metodo okerra.

Adibidez:

```text
PUT /api/reservas/25
```

Probak hau alda dezake:

```text
25 → 26
```

eta baimenak funtzionatzen jarraitzen duen egiaztatu.

## Errepikagarritasuna

Proba erabilgarri bat errepikatu ahal izan beharko litzateke.

Adibidez:

```text
Hasierako egoera

        ↓

Eskaera

        ↓

Espero den emaitza
```

Horri esker, kodea aldatu ondoren egiaztapen bera berriro egin daiteke.

## Emaitza erregistratzea

Ez da beharrezkoa txosten luze bat sortzea.

Proba bakoitzerako nahikoa izan daiteke:

```text
Proba

Espero den emaitza

Lortutako emaitza

Egoera
```

Adibidez:

```text
Proba:
A erabiltzailea B-ren erreserba editatzen saiatzen da

Espero dena:
403

Lortutakoa:
403

Egoera:
zuzena
```

## Erronketan aplikatzea

DAW erronketan probak garapenean bertan integra daitezke.

Adibidez:

```text
Erreserben edizioa inplementatu

        ↓

Kasu balioduna probatu

        ↓

Manipulatutako IDa probatu

        ↓

Beharrezkoa bada zuzendu

        ↓

Jarraitu
```

Horrela, egiaztapena ez da amaierarako pilatzen.

## TxurdiGest-en aplikatzea

Erreserben kudeaketarako proba-multzo txiki batek honako hauek izan ditzake:

```text
[ ] Erreserba baliodun bat sortu

[ ] Data baliogabea bidali

[ ] Autentifikatu gabe sartu

[ ] Norberaren erreserba kontsultatu

[ ] Beste erabiltzaile baten erreserba kontsultatu

[ ] Eskaerako IDa aldatu

[ ] Errore kontrolatu bat eragin
```

Proba bakoitzak espero den emaitza izan behar du exekutatu aurretik.

## Ideia nagusia

> Segurtasun-proba erabilgarri batek ez ditu ausazko portaerak bilatzen: egoera bat, ekintza bat eta espero den emaitza segurua definitzen ditu.
