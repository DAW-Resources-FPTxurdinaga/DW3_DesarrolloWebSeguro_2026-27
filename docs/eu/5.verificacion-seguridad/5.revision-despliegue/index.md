# Hedapenaren berrikuspena

4. blokean aplikazio bat modu seguruan hedatzeko behar diren erabakiak landu ziren.

Bloke honetan konfigurazio horiek ez dira berriro azaltzen.

Helburua aldatu egiten da:

> aurreikusitako erabakiak produkzioan benetan aplikatuta daudela egiaztatzea.

```text
Aurreikusitako kontrola

        ↓

Aplikatutako konfigurazioa

        ↓

Egiaztapena

        ↓

Emaitza

        ↓

Ebidentzia
```

Dokumentazioan idatzitako konfigurazio bat ez da egiaztatutako konfigurazio baten baliokidea.

## Zer berrikusi

Hedapenaren berrikuspenak honako hauek izan ditzake ardatz:

- HTTPS;
- produkzioko konfigurazioa;
- sekretuak;
- esposizio-azalera;
- direktorio publikoa;
- baimenak;
- datu-basea;
- segurtasun-goiburuak;
- erroreak eta logak.

Galdera ez da soilik:

> Nola egon beharko luke konfiguratuta?

Orain hau galdetzen dugu:

> Nola egiazta dezaket benetan horrela konfiguratuta dagoela?

## Egiaztapenen mapa

| Kontrola | Nola egiaztatu | Ebidentzia posiblea |
|---|---|---|
| HTTPS | Nabigatzailea, DevTools edo `curl` | Ziurtagiria, birbideratzea, HTTPS erantzuna |
| Produkzioko konfigurazioa | Konfigurazioa berrikusi eta errore kontrolatu bat eragin | `DEBUG` desgaituta, mezu kontrolatua |
| Sekretuak | Kodea/biltegia eta web-esposizioa berrikusi | Balio sentikorrik gabeko konfigurazioa |
| Esposizio-azalera | Zerbitzuak eta inguruneko arauak berrikusi | Security Groups, diagrama edo konfigurazioa |
| Direktorio publikoa | Zer ibilbide eta fitxategi dauden eskuragarri egiaztatu | 403/404 erantzuna |
| Baimenak | Benetako baimenak berrikusi | Datu sentikorrik gabeko konfigurazioa edo zerrenda |
| Datu-basea | Arkitektura eta konexio-baimenak berrikusi | Diagrama, SG edo konfigurazioa |
| Goiburuak | DevTools edo `curl` | Response Headers |
| Erroreak | Egoera kontrolatu bat eragin | Barne-xehetasunik gabeko erantzuna |
| Logak | Sortutako erregistroa berrikusi | Anonimizatutako log-zatia |

## HTTPS

Hedatutako ingurunetik egiaztatu:

```text
[ ] Aplikazioak HTTPS erabiltzen du

[ ] Ziurtagiria balioduna da

[ ] HTTP HTTPSra birbideratzen da

[ ] Ez dago mixed content-ik

[ ] HSTS HTTPS konfigurazioa zuzena denean bakarrik erabiltzen da
```

Ebidentzia posibleak:

- nabigatzailea;
- Network fitxa;
- `curl -I` komandoaren irteera.

## Produkzioko konfigurazioa

Egiaztatu aplikazioak benetako inguruneari dagokion konfigurazioa erabiltzen duela.

Laravel-en, adibidez:

```text
APP_ENV=production

APP_DEBUG=false
```

Egiaztapen erabilgarri bat errore kontrolatu bat eragitea da.

Espero den emaitza:

```text
Erabiltzailea

→ mezu kontrolatua


Zerbitzaria

→ xehetasuna logean eskuragarri
```

Nabigatzailean traza oso bat agertzen bada, konfigurazioa berrikusi behar da.

## Sekretuak

Bi alderdi desberdin egiaztatu.

### Kodea eta biltegia

```text
[ ] Ez dago kredentzialik kodean idatzita

[ ] .env ez dago bertsio-kontrolean

[ ] Ez dago argitaratutako API gako edo tokenik
```

### Esposizioa

```text
[ ] .env ezin da webetik deskargatu

[ ] Konfigurazio-fitxategi sentikorrak ez dira publikoak

[ ] Logak ez daude nabigatzailetik eskuragarri
```

Sekretu bat argitaratu bada, fitxategia ezabatzea ez da nahikoa.

Sekretua baliogabetu edo biratu egin behar da.

## Esposizio-azalera

Aurreikusitako arkitektura benetako konfigurazioarekin alderatu.

Adibidez:

```text
Internet

    ↓

HTTPS / 443

    ↓

Web zerbitzaria

    ↓

Aplikazioa

    ↓

Barneko datu-basea
```

Egiaztatu:

```text
[ ] Behar diren zerbitzuak bakarrik daude agerian

[ ] SSH mugatuta dago, erabiltzen bada

[ ] Datu-basea ez dago zuzenean argitaratuta

[ ] Ez dago garapen-panel eskuragarririk
```

AWS ingurune batean egiaztapen hau VPC eta Security Groups berrikusiz lagundu daiteke.

Ez da beharrezkoa berrikuspen hau sistema-administrazioko praktika bihurtzea.

## Direktorio publikoa

Egiaztatu proiektuaren zer zatitan argitaratzen duen benetan web zerbitzariak.

Laravel-en puntu publikoa honakoa izan behar da:

```text
public/
```

Webetik ez lukete eskuragarri egon behar:

- `.env`;
- `.git`;
- logak;
- segurtasun-kopiak;
- konfigurazio-fitxategiak;
- barneko kodea.

Ebidentzia izan daiteke publikoa izan behar ez duen baliabide bat eskatzean jasotako 403 edo 404 erantzuna.

## Baimenak

Ez da beharrezkoa baimenen administrazioa berriro ikastea.

Berrikuspenak galdera zehatzei erantzun behar die:

```text
Behar diren karpetek bakarrik dute idazketa-baimena?

Fitxategi sentikorrak babestuta daude?

Saihestu da chmod 777 irtenbide orokor gisa erabiltzea?

Igoera-direktorioek exekuzioa eragozten dute?
```

Laravel-en bereziki berrikusi behar dira honako hauen idazketa-beharrak:

```text
storage/

bootstrap/cache/
```

## Datu-basea

Berrikuspenak egiaztatu behar du hedatutako arkitektura segurtasun-erabakiekin bat datorrela.

```text
[ ] Aplikazioak ez du root edo administratzaile bat erabiltzen

[ ] Erabiltzaileak behar dituen baimenak bakarrik ditu

[ ] Kredentzialak kodetik kanpo daude

[ ] Datu-basea ez dago zuzenean Internetera irekita

[ ] Segurtasun-kopiak aurreikusita daude
```

AWS ingurune batean egiazta daiteke datu-baseak baimendutako osagaietatik datozen konexioak bakarrik onartzen dituela.

## Segurtasun-goiburuak

DevTools edo `curl` erabili proiektuan definitutako goiburuak egiaztatzeko.

Adibidez:

```text
Content-Security-Policy

X-Content-Type-Options

Strict-Transport-Security

Referrer-Policy

Permissions-Policy
```

Berrikuspenak honako hauek egiaztatu behar ditu:

```text
[ ] Goiburua presente dago

[ ] Balioa aurreikusitako konfigurazioarekin bat dator

[ ] Ez ditu funtzionalitate legitimoak hausten
```

Ez da goiburuak zerrenda bat osatzeko soilik gehitzea.

## Erroreak eta logak

Egoera kontrolatu bat eragin:

```text
Existitzen ez den baliabidea

Datu baliogabea

Baimendu gabeko eragiketa
```

Egiaztatu erantzun publikoak:

```text
[ ] Ez ditu barneko ibilbideak erakusten

[ ] Ez du SQL erakusten

[ ] Ez ditu traza osoak erakusten

[ ] Ez ditu sekretuak erakusten
```

Ondoren, berrikusi barne-erregistroa:

```text
[ ] Errorea erregistratuta geratzen da

[ ] Logak ikertzea ahalbidetzen du

[ ] Ez du sekreturik

[ ] Ez dago publikoki eskuragarri
```

## 1. erronkan aplikatzea

PHP, JavaScript eta CSS3 proiektuan berrikuspenak bereziki honako hauek azter ditzake:

- HTTPS;
- produkzioko erroreen konfigurazioa;
- sekretuak kodetik kanpo;
- aplikazioaren datu-baserako sarbidea;
- behar diren baimenak;
- barne-fitxategien esposizioa;
- erroreen aurreko erantzuna.

## 2. erronkan aplikatzea

Laravel, Vue 3 eta Tailwind erabilita, aurreko kontrol aplikagarriez gain honako hauek egiaztatu behar dira:

- `APP_ENV`;
- `APP_DEBUG`;
- `.env`-ren babesa;
- `public/` direktorioaren argitalpen zuzena;
- `storage/` eta `bootstrap/cache/` direktorioen baimenak;
- APIaren erantzunak;
- goiburuak eta CORS, dagokionean;
- produkzioko logak.

## Gutxieneko ebidentziak

Ez da beharrezkoa egiaztapen bakoitza pantaila-argazki batekin dokumentatzea.

Kontrol garrantzitsuenak frogatzen dituzten ebidentziak hautatzea komeni da.

Adibidez:

| Kontrola | Ebidentzia |
|---|---|
| HTTPS | Ziurtagiria edo HTTPS erantzuna |
| DEBUG desgaituta | Errore kontrolatua |
| Sekretuak | Balio sentikorrik gabeko konfigurazioa |
| Barneko datu-basea | Arkitektura edo sarbide-araua |
| Goiburuak | Response Headers |
| Logak | Anonimizatutako log-zatia |

## TxurdiGest-en aplikatzea

Hedapenaren berrikuspen batek honako hauek hauta ditzake:

```text
HTTPS

APP_DEBUG=false

.env ez dago eskuragarri

Barneko datu-basea

Goiburuak

Errore kontrolatuak

Log babestuak
```

Puntu bakoitzerako:

```text
Kontrola

    ↓

Egiaztapena

    ↓

Emaitza

    ↓

Ebidentzia
```

## Ideia nagusia

> Hedapena berrikustea benetako ingurunetik aurreikusitako segurtasun-erabakiak aplikatu direla eta funtzionatzen jarraitzen dutela egiaztatzea da.
