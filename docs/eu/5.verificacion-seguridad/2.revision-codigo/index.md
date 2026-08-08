# Kodearen berrikuspena

Kodearen berrikuspenak erabaki ez-seguruak produkziora iritsi aurretik hautematea ahalbidetzen du.

Ez da proiektu osoa irizpiderik gabe lerroz lerro irakurtzea.

Berrikuspen erabilgarri batek funtzionalitate baten fluxuari jarraitzen dio.

```text
Sarrera

    ↓

Baliozkotzea

    ↓

Prozesamendua

    ↓

Datuetarako sarbidea

    ↓

Autentifikazioa / baimena

    ↓

Erantzuna
```

Galdera nagusia hau da:

> Non aplikatzen dira benetan fluxu hau babestu beharko luketen kontrolak?

## Kontrolak berrikusi, ez berriro inplementatu

Aurreko blokeetan segurtasun-mekanismo desberdinak nola aplikatu landu da.

Bloke honetan ez dira mekanismo horiek berriro azaltzen.

Berrikuspenean honako hauek aurkitzen ikasi behar da:

- falta diren kontrolak;
- leku desegokian aplikatutako kontrolak;
- bezeroaren mende bakarrik dauden kontrolak;
- inplementazio segurua ahuldu duten aldaketak;
- aurreikusitakoaren eta inplementatutakoaren arteko aldeak.

## Sarrerako datuak

Aplikazio batek informazioa hainbat iturritatik jaso dezake:

- formularioak;
- URL parametroak;
- JSON;
- cookieak;
- goiburuak;
- fitxategiak;
- APIak.

Berrikuspenean datu bakoitza non baliozkotzen den aurkitu behar dugu.

Adibidez:

```php
$edad = $_POST['edad'];
```

Berrikuspen-galderak:

```text
Jaso ondoren baliozkotzen da?

Datu mota egiaztatzen da?

Tartea egiaztatzen da?

Espero ez diren balioak baztertzen dira?

Egiaztapena zerbitzarian ere badago?
```

JavaScript bidezko baliozkotzeak erabiltzaile-esperientzia hobetu dezake, baina ez du kontrol bakarra izan behar.

## Irteera

Aplikazioak datuak erakusten dituenean, fidagarria ez den iturri batetik datozen identifikatu behar dugu.

Adibidez:

```php
echo $comentario;
```

Galderak:

```text
Datua erabiltzailearengandik dator?

HTMLn sartu aurretik tratatzen da?

Kode gisa interpreta liteke?
```

Berrikuspenak testuingururako egokia den irteera seguruko mekanismo bat erabiltzen den identifikatu behar du.

## Datuetarako sarbidea

Berrikuspenean bereziki bilatu behar dira jasotako datuak kateatuz eraikitako kontsultak.

Berrikusi beharreko eredua:

```php
$sql = "SELECT * FROM usuarios WHERE email = '" . $email . "'";
```

Mekanismo parametrizatu baten aurrean, adibidez:

```php
$stmt = $pdo->prepare(
    "SELECT * FROM usuarios WHERE email = ?"
);

$stmt->execute([$email]);
```

Helburua ez da sintaxi bat buruz ikastea.

Erabiltzailearen datuek kontsultaren egitura aldatzen ez dutela egiaztatzea da.

## Autentifikazioa

Berrikuspenak erabiltzailearen identitatea non egiaztatzen den eta saioa nola mantentzen den aurkitu behar du.

Egiaztatu:

```text
[ ] Pasahitzak mekanismo egokien bidez gordetzen dira

[ ] Kredentzialak zerbitzarian egiaztatzen dira

[ ] Saioa behar bezala hasten da

[ ] Saioa ixteak sarbidea baliogabetzen du

[ ] Erabiltzailea identifikatzeko ez da bezeroak kontrolatutako datuetan fidatzen
```

## Baimena

Baimena babestutako baliabide bakoitzaren gainean berrikusi behar da.

Adibidez:

```text
Autentifikatutako erabiltzailea

        ↓

/reservas/25/editar
```

Ez da nahikoa saio bat dagoela egiaztatzea.

Hau ere aurkitu behar dugu:

```text
Erreserba erabiltzailearena da?

Beharrezko rola edo baimena du?

Egiaztapena eragiketa egin aurretik exekutatzen da?
```

## Identifikatzaileak

Bezeroarengandik jasotako identifikatzaileak alda daitezke.

```text
/reservas/25

        ↓

/reservas/26
```

Berrikuspenak egiaztatu behar du zerbitzariak eskatutako baliabiderako baimena berriro egiaztatzen duela.

## Sekretuak

Kodean eta biltegian bilatu:

- pasahitzak;
- API gakoak;
- tokenak;
- datu-baseko kredentzialak;
- gako pribatuak;
- aplikazioaren sekretuak.

Adibide okerra:

```php
$password = "mi-password-produccion";
```

Berrikuspenaren helburua da konfigurazio sentikorra kodetik eta biltegitik kanpo dagoela egiaztatzea.

## Fitxategien igoera

Funtzionalitate hau dagoenean, egiaztatu:

```text
[ ] Tamaina mugatzen da

[ ] Fitxategi mota baliozkotzen da

[ ] Izena kontrolatzen da

[ ] Biltegiratzea kokapen egokian egiten da

[ ] Igotako fitxategiak ezin dira exekutatu

[ ] Ezin dira fitxategiak arbitrarioki gainidatzi
```

## APIak

API bat aplikazioaren beste edozein sarrera bezala berrikusi behar da.

Egiaztatu:

- JSON datuen baliozkotzea;
- autentifikazioa;
- baliabide bakoitzeko baimena;
- HTTP egoera-kodeak;
- itzulitako informazioa;
- CORS, dagokionean.

## Erroreak

Salbuespen edo xehetasun tekniko bat erabiltzaileari zuzenean bidal dakiokeen puntuak bilatu.

Berrikusi beharreko adibidea:

```php
catch (Exception $e) {
    echo $e->getMessage();
}
```

Produkzioan, xehetasun teknikoa barne-erregistroan geratu behar da eta erabiltzaileak erantzun kontrolatu bat jaso behar du.

## Aldaketa zehatzak berrikustea

Ez da beti beharrezkoa aplikazio osoa berrikustea.

Estrategia erabilgarri bat:

```text
Egindako aldaketa

        ↓

Eragindako kodea

        ↓

Lotutako kontrolak

        ↓

Egiaztapena
```

Horri esker, segurtasuna taldearen ohiko lanean integra daiteke.

## Berdinen arteko berrikuspena

Ikaskideen arteko berrikuspena modu sinplean antola daiteke.

### Egilea

Azaltzen du:

- zer funtzionalitate garatu duen;
- zer datu jasotzen dituen;
- zer kontrol aplikatu beharko liratekeen.

### Berrikuslea

Honako hauek aurkitzen ditu:

- baliozkotzea;
- datuetarako sarbidea;
- autentifikazioa;
- baimena;
- irteera;
- sekretuak;
- erroreak.

### Taldea

Erabakitzen du:

```text
Zuzena

edo

Zuzendu behar da
```

Berrikuspena kodean eta erabaki teknikoetan zentratzen da, ez kodea garatu duen pertsonan.

## 1. erronkan aplikatzea

PHP, JavaScript eta CSS3 proiektuan argi bereizi behar da:

```text
JavaScript

→ interfazearen eta erabiltzaile-esperientziaren laguntza


PHP

→ zerbitzariko benetako kontrolak
```

Berrikuspenak bereziki egiaztatu behar du segurtasuna ez dagoela JavaScript-en mende bakarrik.

## 2. erronkan aplikatzea

Laravel, Vue 3 eta Tailwind erabilita irizpide bera aplikatzen da:

```text
Vue

→ interfazea eta erabiltzaile-esperientzia


Laravel

→ baliozkotzea, autentifikazioa, baimena eta datuetarako sarbidea
```

Babestutako ibilbide eta baliabideak, APIaren erantzunak eta zerbitzariari eragiten dion konfigurazioa ere berrikusi behar dira.

## Berrikuspenerako gida laburra

```text
[ ] Jasotako datuak zerbitzarian baliozkotzen dira?

[ ] Irteera modu seguruan sortzen da?

[ ] Datuetarako sarbideak mekanismo parametrizatuak erabiltzen ditu?

[ ] Autentifikazioa zerbitzarian egiaztatzen da?

[ ] Baimena babestutako baliabide bakoitzean aplikatzen da?

[ ] Sekretuak kodetik kanpo daude?

[ ] Fitxategien igoerak kontrolatuta daude, halakorik badago?

[ ] APIek kontrol berak aplikatzen dituzte?

[ ] Erroreak modu seguruan kudeatzen dira?
```

## TxurdiGest-en aplikatzea

Funtzionalitate zehatz bat hauta daiteke:

```text
Erreserba editatu
```

eta haren fluxuari jarraitu:

1. identifikatzailea nola jasotzen duen;
2. datuak nola baliozkotzen dituen;
3. erreserba nola lortzen duen;
4. jabea nola egiaztatzen duen;
5. datu-basea nola eguneratzen duen;
6. zer erantzun itzultzen duen.

## Ideia nagusia

> Kodea segurtasunaren ikuspegitik berrikustea fluxu bat babestu beharko luketen kontrolak aurkitzea eta dagokien lekuan benetan daudela egiaztatzea da.
