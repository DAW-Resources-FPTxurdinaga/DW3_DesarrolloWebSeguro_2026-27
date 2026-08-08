# Kodearen berrikuspena

Kodearen berrikuspenak segurtasun-arazoak produkziora iritsi aurretik hautematea ahalbidetzen du.

Ez da proiektu osoa irizpiderik gabe lerroz lerro irakurtzea.

Berrikuspen erabilgarri batek erabaki zehatzetan jartzen du arreta:

```text
Sarrera

    ↓

Prozesamendua

    ↓

Datuetarako sarbidea

    ↓

Autentifikazioa eta baimena

    ↓

Erantzuna
```

Helburua da erabaki oker batek arriskua sor dezakeen puntuak identifikatzea.

## Zer berrikusi

Berrikuspenak moduluan landutako edukietan oinarritu behar du.

Alderdi nagusien artean:

- sarrerako datuen baliozkotzea;
- irteera segurua;
- datuetarako sarbidea;
- autentifikazioa;
- baimena;
- saioak;
- fitxategien igoera;
- APIak;
- sekretuak;
- erroreen kudeaketa.

## Datu-sarrera berrikustea

Aplikazio batek hainbat jatorritatik jasotzen du informazioa:

- formularioak;
- URL parametroak;
- JSON;
- cookieak;
- goiburuak;
- fitxategiak;
- APIak.

Galdera nagusia hau da:

> Non baliozkotzen da benetan informazioa?

JavaScript bidezko baliozkotzeak erabiltzailearen esperientzia hobetzen du, baina ez du zerbitzariko baliozkotzea ordezkatzen.

Berrikuspen-adibidea:

```php
$edad = $_POST['edad'];
```

Galdera ez da soilik aldagaia existitzen den.

Hau ere egiaztatu behar dugu:

```text
Baliozkotzen al da?

Mota egiaztatzen al da?

Tartea egiaztatzen al da?

Espero ez diren balioak baztertzen al dira?
```

## Irteera berrikustea

Orri batean erakusten diren datuak modu seguruan tratatu behar dira.

Adibidez:

```php
echo $comentario;
```

Berrikuspenean honako hau galdetu behar dugu:

```text
Datu hau erabiltzailearengandik dator?

Erakutsi aurretik ihes egiten al da?

HTML edo JavaScript gisa interpreta daiteke?
```

PHPn ohiko aukera bat:

```php
echo htmlspecialchars(
    $comentario,
    ENT_QUOTES,
    'UTF-8'
);
```

## Datuetarako sarbidea berrikustea

Berrikuspen batek kateatze bidez eraikitako kontsultak identifikatu behar ditu.

Adibide problematikoa:

```php
$sql = "SELECT * FROM usuarios WHERE email = '" . $email . "'";
```

Prestatutako kontsultak erabiltzen diren egiaztatu behar da.

```php
$stmt = $pdo->prepare(
    "SELECT * FROM usuarios WHERE email = ?"
);

$stmt->execute([$email]);
```

Berrikuspena ez da sintaxi zehatz bat buruz ikastea.

Injekzio-arriskua murrizten duten erabakiak ezagutzea da.

## Autentifikazioa berrikustea

Autentifikazioak honako galderari erantzuten dio:

> Nor da erabiltzailea?

Berrikuspenean, besteak beste, honako hauek egiazta daitezke:

- pasahitzak hash bidez gordetzen direla;
- pasahitzak modu seguruan alderatzen direla;
- saioak behar bezala hasten direla;
- saioa ixteko mekanismoa dagoela;
- behar denean saio-identifikatzailea birsortzen dela.

PHPko adibidea:

```php
password_verify(
    $password,
    $hash
);
```

## Baimena berrikustea

Baimenak honako galderari erantzuten dio:

> Zer egin dezake erabiltzaile honek?

Ohiko errore bat erabiltzailea autentifikatuta dagoela bakarrik egiaztatzea da.

Adibidez:

```text
Autentifikatutako erabiltzailea

        ↓

/reservas/25/editar
```

Berrikuspenak hau ere egiaztatu behar du:

```text
25. erreserba erabiltzailearena da?

Beharrezko rola du?

Ekintza exekutatu aurretik baimena egiaztatzen da?
```

## Identifikatzaileak berrikustea

URL edo eskaera batean jasotako identifikatzaileak ez dira fidagarritzat hartu behar.

Adibidez:

```text
/reservas/25
```

Erabiltzaileak hau alda dezakeela suposatu behar da:

```text
25 → 26
```

Beraz, aplikazioak eskatutako baliabidearen gaineko baimena egiaztatu behar du.

## Sekretuak berrikustea

Kodearen berrikuspenak honako hauek bilatu behar ditu:

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

Konfigurazio sentikorra kodetik eta biltegitik kanpo egon behar da.

## Fitxategien igoera berrikustea

Fitxategiak igotzeko funtzionalitate batek hainbat egiaztapen behar ditu.

Berrikuspenak honako galderak egin ditzake:

```text
Tamaina mugatzen al da?

Mota baliozkotzen al da?

Izen segurua sortzen al da?

Fitxategia exekutagarriak ez diren eremuetan gordetzen al da?

Erabiltzaile batek fitxategiak gainidatz ditzake?
```

Ez da nabigatzaileak bidalitako izenean edo luzapenean bakarrik fidatu behar.

## APIak berrikustea

API batean segurtasun-erabaki berak berrikusi behar dira.

Adibidez:

- jasotako JSONaren baliozkotzea;
- autentifikazioa;
- baimena;
- egoera-kodeak;
- itzulitako informazioa;
- CORS, dagokionean.

API bat ez da segurua interfaze grafikorik ez duelako soilik.

## Erroreak berrikustea

Berrikuspenean kodeak barne-xehetasunak erakusten dituen egiaztatu behar da.

Adibide problematikoa:

```php
catch (Exception $e) {

    echo $e->getMessage();

}
```

Produkzioan hobe da xehetasuna logetan erregistratzea eta mezu kontrolatu bat erakustea.

## Aldaketak berrikustea, ez soilik aplikazio osoak

Ingurune profesional batean ez da beti proiektu osoa berrikusten.

Ohikoa da honako hau berrikustea:

```text
Egindako aldaketa

        ↓

Eragindako kodea

        ↓

Sartutako arriskua

        ↓

Egiaztapena
```

Horrek berrikuspena eguneroko lanean integratzea ahalbidetzen du.

## Berdinen arteko berrikuspena

Ikaskideen arteko berrikuspenak prozedura sinple bat jarrai dezake.

### Egilea

Azaltzen du:

- zer funtzionalitate garatu duen;
- zer datu jasotzen dituen;
- zer segurtasun-erabaki aplikatu dituen.

### Berrikuslea

Egiaztatzen du:

- sarrerak;
- datuetarako sarbidea;
- autentifikazioa;
- baimena;
- irteera;
- lotutako konfigurazioa.

### Taldea

Erabakitzen du:

```text
Zuzena

edo

Zuzendu behar da
```

Berrikuspenak kodean eta erabaki teknikoetan jarri behar du arreta, ez garatu duen pertsonan.

## Berrikuspen-galderak

Zerrenda labur batek gida gisa balio dezake:

```text
[ ] Jasotako datuak zerbitzarian baliozkotzen dira?

[ ] Sortutako irteera segurua da?

[ ] Kontsultek parametroak erabiltzen dituzte?

[ ] Autentifikazioa behar bezala inplementatuta dago?

[ ] Babestutako baliabide bakoitzean baimena egiaztatzen da?

[ ] Sekretuak kodetik kanpo daude?

[ ] Fitxategien igoerak kontrolatuta daude?

[ ] Erroreak modu seguruan kudeatzen dira?
```

## TxurdiGest-en aplikatzea

TxurdiGest-en berrikuspen batek funtzionalitate zehatz bat hauta dezake.

Adibidez:

```text
Erreserba editatu
```

Taldeak honako hauek berrikusiko lituzke:

1. identifikatzailea nola jasotzen duen;
2. datuak nola baliozkotzen dituen;
3. erreserba nola lortzen duen;
4. jabetza nola egiaztatzen duen;
5. datu-basea nola eguneratzen duen;
6. errore baten aurrean zer erantzun ematen duen.

Berrikuspen honek funtzionalitatearen benetako fluxua jarraitzen du.

## Ideia nagusia

> Kodea segurtasunaren ikuspegitik berrikustea ez da erroreak ausaz bilatzea. Aplikazioaren fluxu bakoitza babesten duten erabakiak sistematikoki egiaztatzea da.
