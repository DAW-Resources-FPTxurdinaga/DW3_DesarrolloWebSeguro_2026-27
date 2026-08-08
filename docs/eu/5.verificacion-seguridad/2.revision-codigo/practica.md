# Praktika: kodearen berrikuspen segurua

## Testuingurua

Kodearen berrikuspenak funtzionalitate batek aurreikusitako segurtasun-erabakiak behar bezala aplikatzen dituen egiaztatzea ahalbidetzen du.

Praktika honetan ez da proiektu osoa berrikusiko.

Talde bakoitzak funtzionalitate zehatz bat hautatuko du eta haren fluxu osoa jarraituko du.

Adibide egokiak:

- saioa hasi;
- erreserba bat sortu;
- profil bat editatu;
- eskaera bat aldatu;
- fitxategi bat igo;
- babestutako baliabide bat kontsultatu.

## Helburua

Aplikazioaren funtzionalitate bat berrikustea eta honako hauekin lotutako arazo posibleak hautematea:

- baliozkotzea;
- datuetarako sarbidea;
- autentifikazioa;
- baimena;
- irteera;
- sekretuak;
- erroreen kudeaketa.

Berrikuspenak erabaki batekin amaitu behar du:

```text
Zuzena

edo

Zuzendu behar da
```

## Antolaketa

Praktika honela egin daiteke:

- taldearen barruan;
- binaka;
- taldeen arteko berrikuspen gurutzatuaren bidez.

Ahal denean, gomendagarria da pertsona batek berak idatzi ez duen kodea berrikustea.

## 1. urratsa. Funtzionalitate bat hautatu

Fluxu argia duen funtzionalitate bat aukeratu.

Adibidez:

```text
Erreserba editatu
```

Identifikatu:

```text
Sarrera

    ↓

Kontrolatzailea edo logika

    ↓

Datuetarako sarbidea

    ↓

Baimenen egiaztapena

    ↓

Erantzuna
```

## 2. urratsa. Sarrerak identifikatu

Funtzionalitateak zer datu jasotzen dituen idatzi.

Adibidez:

```text
Erreserbaren IDa

data

pertsona kopurua

autentifikatutako erabiltzailea
```

Egiaztatu:

```text
[ ] Datuak zerbitzarian baliozkotzen dira

[ ] Datu mota egiaztatzen da

[ ] Tarteak edo formatuak egiaztatzen dira

[ ] Espero ez diren balioak baztertzen dira
```

## 3. urratsa. Datuetarako sarbidea berrikusi

Funtzionalitatearekin lotutako kontsultak aurkitu.

Egiaztatu:

```text
[ ] Prestatutako kontsultak edo baliokideak erabiltzen dira

[ ] Ez dira kontsultak eraikitzen erabiltzailearen datuak kateatuz

[ ] Datu-baseko erabiltzaileak baimen egokiak ditu
```

Adibide problematikoa:

```php
$sql = "SELECT * FROM reservas WHERE id = " . $_GET['id'];
```

Adibide seguruagoa:

```php
$stmt = $pdo->prepare(
    "SELECT * FROM reservas WHERE id = ?"
);

$stmt->execute([$id]);
```

## 4. urratsa. Autentifikazioa berrikusi

Funtzionalitateak autentifikatutako erabiltzailea behar badu, egiaztatu:

```text
[ ] Saio balioduna dagoela egiaztatzen da

[ ] Funtzionalitatea ezin da autentifikatu gabe exekutatu

[ ] Saioa ixtean saioa behar bezala baliogabetzen da
```

## 5. urratsa. Baimena berrikusi

Egiaztatu ez dela nahikoa autentifikatuta egotea.

Adibidez:

```text
A erabiltzailea

        ↓

/reservas/25/editar
```

Aplikazioak egiaztatu behar du erreserba erabiltzailearena den edo hura aldatzeko baimena duen.

Checklist:

```text
[ ] Jabea edo rola egiaztatzen da

[ ] Baimena datuak aldatu aurretik egiaztatzen da

[ ] Identifikatzailea aldatzeak ez du besteen baliabideetara sartzea ahalbidetzen
```

## 6. urratsa. Irteera berrikusi

Egiaztatu funtzionalitateak erabiltzaileak emandako informazioa erakusten duen.

Adibidez:

```php
echo $nombre;
```

Galderak:

```text
[ ] Datuak modu seguruan erakusten dira?

[ ] HTML gisa interpreta daitezke?

[ ] Erabiltzaile batek sartutako edukia izan dezakete?
```

## 7. urratsa. Erroreak berrikusi

Egiaztatu zer gertatzen den zerbaitek huts egiten badu.

Adibidez:

```text
Erreserba ez da existitzen

Datu-baseko errorea

Datu baliogabea
```

Aplikazioak saihestu behar du honako hauek erakustea:

- barneko ibilbideak;
- SQL kontsultak;
- salbuespen osoak;
- kredentzialak;
- arazketa-informazioa.

Checklist:

```text
[ ] Erabiltzaileak mezu kontrolatu bat jasotzen du

[ ] Errore teknikoa barnean erregistra daiteke

[ ] Ez da xehetasun sentikorrik erakusten
```

## 8. urratsa. Sekretuak berrikusi

Funtzionalitatearekin lotutako fitxategietan honako hauek bilatu:

```text
pasahitzak

tokenak

API gakoak

kredentzialak

gako pribatuak
```

Egiaztatu:

```text
[ ] Ez dago sekreturik zuzenean kodean idatzita

[ ] Konfigurazio sentikorra ingurunetik lortzen da
```

## 9. urratsa. Aurkikuntzak erregistratu

Ez da beharrezkoa txosten luze bat idaztea.

Aurkitutako arazo bakoitzerako nahikoa da honako hau adieraztea:

```text
Arazoa

Non agertzen den

Arriskua

Proposatutako zuzenketa
```

Adibidez:

```text
Arazoa:
ez da erreserbaren jabea egiaztatzen

Non:
edizio-kontrolatzailean

Arriskua:
erabiltzaile batek besteen erreserbak alda ditzake

Zuzenketa:
eguneratu aurretik jabea den erabiltzailea egiaztatu
```

## 10. urratsa. Zuzendu eta berriro berrikusi

Arazo bat hautematen bada:

```text
Hauteman

    ↓

Zuzendu

    ↓

Berriro berrikusi
```

Berrikuspena amaitzen da funtzionalitateak aurreikusitako kontrolak betetzen dituenean.

## Ebidentzia

Entregak honako hauek izan ditzake:

- berrikusitako funtzionalitatea;
- betetako checklist-a;
- aurkikuntza garrantzitsu bat edo bi;
- egindako zuzenketak;
- berrikuspena justifikatzeko behar diren kode-zatiak.

Ez da beharrezkoa kode kopuru handiak entregatzea.

## TxurdiGest-en aplikatzea

Funtzionalitate-adibidea:

```text
Erreserba bat editatu
```

Berrikusteko puntu posibleak:

```text
Jasotako IDa

        ↓

Baliozkotzea

        ↓

Kontsulta

        ↓

Jabearen egiaztapena

        ↓

Eguneratzea

        ↓

Erantzuna
```

Helburua fluxu osoa egiaztatzea da, ez lerro bakar bat.

## Azken checklist-a

```text
[ ] Sarrerak berrikusita

[ ] Kontsultak berrikusita

[ ] Autentifikazioa berrikusita

[ ] Baimena berrikusita

[ ] Irteera berrikusita

[ ] Erroreak berrikusita

[ ] Sekretuak berrikusita

[ ] Arazoak zuzendu edo dokumentatu dira
```

## Ideia nagusia

> Kodearen berrikuspen erabilgarri batek funtzionalitate baten fluxua jarraitzen du eta, puntuz puntu, segurtasun-kontrolak non aplikatzen diren egiaztatzen du.
