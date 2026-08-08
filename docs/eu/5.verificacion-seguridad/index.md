# Segurtasunaren egiaztapena

Aplikazio bat ezin da segurutzat jo diseinuan, inplementazioan edo hedapenean segurtasun-neurriak aplikatu direlako soilik.

Neurri horiek benetan funtzionatzen dutela egiaztatu behar da.

```text
Diseinatu

    ↓

Inplementatu

    ↓

Hedatu

    ↓

Egiaztatu
```

Egiaztapenari esker, erroreak erabiltzaileengana iritsi aurretik hauteman daitezke, eta garapenean hartutako erabakiak azken produktuan mantentzen direla egiaztatu.

## Egiaztatzea ez da erasotzea

Modulu honetan, segurtasunaren egiaztapena garapenaren ikuspegitik lantzen da.

Helburua ez da pentesting profesionala egitea, ezta besteen sistemak arriskuan jartzen saiatzea ere.

Helburua honelako galderak egiaztatzea da:

```text
Sarrerako datuak benetan baliozkotzen al dira?

Erabiltzaile batek bere baliabideetara soilik sar al dezake?

Datu-baseko kontsultak babestuta al daude?

Sekretuak kodetik kanpo al daude?

Aplikazioak HTTPS bidez soilik funtzionatzen al du?

Erroreek informazio sentikorra erakusten al dute?
```

Egiaztatzea definitutako kontrolek egoera errealetan behar bezala funtzionatzen dutela frogatzea da.

## Zer egiaztatu behar dugu?

Aplikazio baten berrikuspena hainbat mailatan egin daiteke.

### Kodea

Inplementazioko erabakiak egiaztatu:

- sarrerako datuen baliozkotzea;
- irteera segurua;
- prestatutako kontsultak;
- autentifikazioa;
- baimena;
- saioen kudeaketa;
- fitxategien igoera;
- erroreen kudeaketa.

### Portaera

Erabiltzaileak espero ez diren ekintzak egiten dituenean zer gertatzen den egiaztatu.

Adibidez:

```text
Datu baliogabe bat bidali

Autentifikatu gabe sartzen saiatu

Identifikatzaile bat aldatu

Beste erabiltzaile baten baliabidea eskatu

Baimendu gabeko fitxategi bat bidali
```

Aplikazio seguru batek modu kontrolatuan erantzun behar du.

### Hedapena

Produkzioko konfigurazioak segurtasun-neurriak mantentzen dituela egiaztatu:

- HTTPS;
- sekretuak kodetik kanpo;
- arazketa desgaituta;
- baimen egokiak;
- datu-base babestua;
- segurtasun-goiburuak;
- logak konfiguratuta.

## Proba positiboak eta negatiboak

Ohiko proba funtzionalek eragiketa batek behar bezala funtzionatzen duela egiaztatzen dute.

Adibidez:

```text
Erabiltzaile balioduna

        ↓

Saio-hasiera zuzena
```

Segurtasunaren egiaztapenak baztertu beharko liratekeen egoerak ere probatu behar ditu.

```text
Autentifikatu gabeko erabiltzailea

        ↓

Babestutako baliabiderako sarbidea

        ↓

Sarbidea ukatuta
```

Proba horiei esker, aplikazioak aurreikusi gabeko sarrera edo ekintzen aurrean duen portaera egiazta daiteke.

## Laguntza-tresnak

Moduluan zehar aplikazio baten portaera behatu eta egiaztatzeko tresnak erabili dira.

Besteak beste:

- Chrome DevTools;
- Burp Suite;
- DVWA;
- nabigatzailearen tresnak;
- aplikazioaren eta zerbitzariaren logak.

Bloke honetan ez da tresna berri asko ikastea bilatzen.

Helburua ezagutzen diren tresnak erabiltzea da segurtasun-erabaki zehatzak egiaztatzeko.

## Kodearen berrikuspena

Ahultasun asko kodea hedatu aurretik berrikusiz hauteman daitezke.

Berrikuspen batean, adibidez, honako hauek egiazta daitezke:

```text
Jasotako datuetan zuzenean konfiantza jartzen al da?

SQL kontsultak balioak kateatuz eraikitzen al dira?

Baliabide batera sartu aurretik baimena egiaztatzen al da?

Sekretuak kodean idatzita al daude?

Salbuespenak zuzenean erakusten al zaizkio erabiltzaileari?
```

Berrikuspena honako hauek egin dezakete:

- garatzaileak berak;
- taldeko beste kide batek;
- beste talde batek.

Berdinen arteko berrikuspenak kodearen egileak ikusi ez dituen arazoak hautematen laguntzen du.

## Ebidentziak

Proiektu profesional batean ez da nahikoa honako hau esatea:

> Aplikazioa segurua da.

Egiaztatu dena frogatu ahal izan behar da.

Ebidentzia bat izan daiteke:

- DevTools-eko pantaila-argazki bat;
- eskaera bat eta haren erantzuna;
- konfigurazio-zati bat;
- proba baten emaitza;
- betetako checklist bat;
- egindako zuzenketa baten azalpen laburra.

Ebidentziak erabakia justifikatzeko nahikoa izan behar du, baina ez du txosten luze bihurtu behar.

## ETHAZI erronketan integratzea

Egiaztapenak erronkaren garapenaren parte izan behar du.

Ez litzateke amaieran bakarrik egin behar.

```text
Funtzionalitatea inplementatu

        ↓

Berrikusi

        ↓

Probatu

        ↓

Zuzendu

        ↓

Garapenarekin jarraitu
```

Horrela, segurtasuna taldearen ohiko lan-zikloan txertatzen da.

## Blokearen edukiak

Bloke honetan honako hauek landuko dira:

1. kodearen berrikuspena;
2. segurtasun-probak;
3. egiaztapen-tresnak;
4. hedapenaren berrikuspena;
5. segurtasun-checklista;
6. segurtasun-ebidentziak;
7. proiektuaren azken berrikuspena.

Azken helburua da ikasleak gai izatea web-aplikazio bat berrikusteko eta segurtasun-erabaki nagusiak egiaztatu direla justifikatzeko.

## Ideia nagusia

> Segurtasuna ez da suposatu behar. Berrikuspenen, proben eta ebidentzien bidez egiaztatu behar da.
