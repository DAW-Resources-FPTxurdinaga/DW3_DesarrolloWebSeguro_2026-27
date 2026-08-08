# Segurtasunaren egiaztapena

Segurtasun-neurri bat ezin da baliozkotzat jo diseinatu edo inplementatu delako soilik.

Benetan funtzionatzen duela egiaztatu behar da.

```text
Diseinatu

    ↓

Inplementatu

    ↓

Hedatu

    ↓

Egiaztatu
```

Egiaztapenak aplikazioak egitea espero duguna eta benetan egiten duena alderatzeko aukera ematen du.

## Egiaztatzea ez da erasotzea

Modulu honetan egiaztapena garapen seguruaren ikuspegitik lantzen da.

Helburua ez da pentesting profesionala egitea edo besteen sistemak arriskuan jartzen saiatzea.

Galdera zehatzei erantzutea da helburua:

```text
Datuak benetan zerbitzarian baliozkotzen dira?

Erabiltzaile batek baimendutako baliabideetara bakarrik sar daiteke?

Datu-baseko kontsultak babestuta daude?

Sekretuak kodetik kanpo daude?

Produkzioko konfigurazioa egokia da?

Erroreek informazio sentikorra erakustea saihesten dute?
```

Egiaztapenak norberaren aplikazioetan, hezkuntza-inguruneetan edo berariaz baimendutako sistemetan bakarrik egingo dira.

## Zer egiaztatzen dugu

Berrikuspena hiru mailatan egin daiteke.

### Kodea

Inplementazio-erabakiak egiaztatzea:

- sarrerako datuen baliozkotzea;
- irteera segurua;
- datuetarako sarbidea;
- autentifikazioa;
- baimena;
- saioak;
- fitxategiak;
- APIak;
- sekretuak;
- erroreen kudeaketa.

### Portaera

Kasu baliodunen aurrean eta baztertu beharreko egoeren aurrean zer gertatzen den egiaztatzea.

Adibidez:

```text
Sarrera baliogabea

Autentifikaziorik gabeko sarbidea

Manipulatutako identifikatzailea

Beste erabiltzaile baten baliabidea

Baimendu gabeko fitxategia
```

### Hedapena

Segurtasun-erabakiak produkzioan mantentzen direla egiaztatzea:

- HTTPS;
- produkzioko konfigurazioa;
- sekretuak;
- esposizio-azalera;
- baimenak;
- datu-basea;
- goiburuak;
- erroreak eta logak.

## Egiaztapen-metodoa

Egiaztapen erabilgarri batek prozesu sinple bati jarraitzen dio:

```text
Espero den kontrola

        ↓

Proba

        ↓

Lortutako emaitza

        ↓

Alderaketa

        ↓

Ebidentzia
```

Emaitza ez badator bat espero zenarekin:

```text
Hauteman

    ↓

Zuzendu

    ↓

Proba errepikatu
```

Egiaztapena garapenaren parte da, ez soilik azken entregaren parte.

## Erronketan aplikatzea

Bloke honek berrikusteko metodoa eskaintzen du.

Egiaztapenak ikasturteko bi erronketan garatutako proiektuen gainean aplikatuko dira.

### 1. erronka — PHP, JavaScript eta CSS3

Egiaztapenak, besteak beste, honako hauek aztertzea ahalbidetuko du:

- JavaScript bidezko baliozkotzea erabiltzaile-esperientziaren laguntza gisa;
- benetako baliozkotzea PHPn;
- irteera segurua;
- datu-baserako sarbide segurua;
- autentifikazioa eta saioak;
- baimena;
- erroreen kudeaketa;
- sekretuak eta konfigurazioa;
- HTTPS bidezko hedapena.

### 2. erronka — Laravel, Vue 3 eta Tailwind

Egiaztapena honako alderdi hauetara egokituko da:

- Vue-ko baliozkotzea interfazearen laguntza gisa;
- Laravel-eko baliozkotzea zerbitzariko kontrol gisa;
- autentifikazioa eta baimena;
- baliabideen babesa;
- APIak eta HTTP erantzunak;
- CORS, dagokionean;
- ingurune-aldagaiak eta sekretuak;
- produkzioko konfigurazioa eta hedapena.

Ez da blokearen amaierako jarduera independente bat egingo.

Berrikuspena, probak eta ebidentziak erronketan bertan integratuko dira.

## Tresnak

Batez ere dagoeneko ezagutzen diren tresnak erabiliko dira:

- Chrome DevTools;
- Burp Suite;
- DVWA, laborategiko erreferentzia gisa;
- logak;
- `curl`, erabilgarria denean.

Tresna erantzun nahi dugun galderaren arabera aukeratzen da.

## Ebidentziak

Ebidentzia batek egiaztapen baten emaitza frogatzeko aukera ematen du.

Honako hau izan daiteke:

- eskaera bat eta haren erantzuna;
- DevTools-eko pantaila-argazki bat;
- HTTP goiburu bat;
- sekreturik gabeko konfigurazio-zati bat;
- proba baten emaitza;
- anonimizatutako log-zati bat;
- checklist bat.

Ebidentziak laburrak, garrantzitsuak eta seguruak izan behar dira.

## Blokearen edukiak

1. segurtasun-egiaztapenaren sarrera;
2. kodearen berrikuspena;
3. segurtasun-probak;
4. egiaztapen-tresnak;
5. hedapenaren berrikuspena;
6. segurtasun-checklista;
7. segurtasun-ebidentziak;
8. ondorioak.

## Ideia nagusia

> Segurtasuna ez da suposatu behar. Berrikuspen, proba eta ebidentzien bidez egiaztatu behar da.
