# Hedapenaren berrikuspena

Segurtasunaren egiaztapena ez da kodean amaitzen.

Aplikazio bat behar bezala inplementatuta egon daiteke eta, hala ere, produkzioko konfigurazio oker baten ondorioz arriskuan gera daiteke.

Horregatik, hedapenaren ondoren ingurunean hartutako erabakiak ere egiaztatu behar dira.

```text
Aplikazio segurua

        +

Konfigurazio segurua

        +

Azpiegitura egokia
```

Hedapenaren berrikuspenak egiaztatzen du aplikazioak aurreko blokeetan landutako neurriak produkzioan mantentzen dituela.

## Zer berrikusi behar da

Berrikuspenak honako hauek izan ditzake ardatz:

- HTTPS;
- produkzioko konfigurazioa;
- sekretuak;
- esposizio-azalera;
- baimenak;
- datu-basea;
- segurtasun-goiburuak;
- erroreak eta logak.

Ez da 4. blokea errepikatzea.

Hemen helburua da definitutako konfigurazioa benetan aplikatuta dagoela egiaztatzea.

## HTTPS

Egiaztatu:

```text
[ ] Aplikazioak HTTPS bidez funtzionatzen du

[ ] Ziurtagiria balioduna da

[ ] HTTP HTTPSra birbideratzen da

[ ] Ez dago HTTP bidez kargatutako baliabiderik

[ ] HSTS HTTPS behar bezala konfiguratuta badago soilik erabiltzen da
```

Egiaztapena honako hauekin egin daiteke:

- nabigatzailea;
- DevTools;
- `curl`.

## Produkzioko konfigurazioa

Egiaztatu produkzioko inguruneak ez dituela garapeneko konfigurazioak erabiltzen.

Adibideak:

```text
APP_ENV=production

APP_DEBUG=false
```

Hau ere egiaztatu behar da:

```text
[ ] Ez dira errore xeheak erakusten

[ ] Garapeneko mendekotasunak ez dira alferrik instalatzen

[ ] Konfigurazioa benetako inguruneari dagokio
```

## Sekretuak

Sekretuak kodetik eta biltegitik kanpo egon behar dira.

Egiaztatu:

```text
[ ] Ez dago kredentzialik kodean

[ ] .env ez dago argitaratuta

[ ] .env ez dago bertsio-kontrolean

[ ] Produkzioko sekretuak garapenekoetatik desberdinak dira

[ ] Konfigurazio-fitxategiaren baimenak egokiak dira
```

Sekretu bat argitaratu bada, biltegitik ezabatzea ez da nahikoa.

Baliogabetu edo biratu egin behar da.

## Esposizio-azalera

Berrikusi zer osagai dauden kanpotik eskuragarri.

Adibidez:

```text
Internet

    ↓

443

    ↓

Web zerbitzaria

    ↓

Aplikazioa

    ↓

Barneko datu-basea
```

Egiaztatu:

```text
[ ] Behar diren atakak bakarrik daude irekita

[ ] SSH mugatuta dago

[ ] Datu-basea ez dago zuzenean agerian

[ ] Ez dago garapen-panel eskuragarririk

[ ] Ezin dira barne-fitxategiak deskargatu
```

## Direktorio publikoa

Web zerbitzariak behar diren fitxategiak bakarrik argitaratu behar ditu.

Adibidez:

```text
Aplikazioa

├── app/
├── config/
├── storage/
├── vendor/
└── public/
```

`DocumentRoot`-ek hona apuntatu behar du:

```text
public/
```

Egiaztatu honako hauek ez direla eskuragarri:

- `.env`;
- `.git`;
- logak;
- segurtasun-kopiak;
- konfigurazio-fitxategiak;
- barneko kodea.

## Baimenak

Berrikuspenak egiaztatu behar du baimenak ez direla gehiegizkoak.

Adibideak:

```text
[ ] Kodeak ez du idazketa-baimen orokorrik behar

[ ] Behar diren karpetek bakarrik dute idazketa-baimena

[ ] Ez da chmod 777 erabiltzen irtenbide gisa

[ ] Fitxategi sentikorrak babestuta daude

[ ] Igoera-direktorioek ez dute exekuzioa baimentzen
```

Laravel-en bereziki berrikusi behar dira:

```text
storage/

bootstrap/cache/
```

## Datu-basea

Aplikazioak kontu espezifiko bat erabili behar du.

Egiaztatu:

```text
[ ] Aplikazioak ez du root erabiltzen

[ ] Erabiltzaileak behar diren baimenak bakarrik ditu

[ ] Kredentzialak kodetik kanpo daude

[ ] Datu-basea ez da publikoa

[ ] Segurtasun-kopiak daude

[ ] Leheneratzea kontuan hartu da
```

AWSn ohiko arkitektura bat izan daiteke:

```text
EC2

    ↓

Security Group

    ↓

RDS pribatua
```

Datu-baseak baimendutako osagaietatik datozen konexioak bakarrik onartu behar ditu.

## Segurtasun-goiburuak

Egiaztatu DevTools edo `curl` erabiliz aplikaziorako definitutako goiburuak.

Adibidez:

```text
Content-Security-Policy

X-Content-Type-Options

Strict-Transport-Security

Referrer-Policy

Permissions-Policy
```

Ez da zerrenda estandar bat kopiatzea.

Egiaztatu behar da hautatutako goiburuak:

- agertzen direla;
- balio zuzenak dituztela;
- ez dutela funtzionalitate legitimoa hausten.

## Erroreak

Egoera kontrolatu bat eragin.

Adibidez:

```text
Existitzen ez den baliabidea

Datu baliogabea

Baimendu gabeko eragiketa
```

Egiaztatu erabiltzaileak ez duela honakorik jasotzen:

- barneko ibilbideak;
- SQL kontsultak;
- trazak;
- sekretuak;
- arazketa-informazioa.

## Logak

Errore bat eragin ondoren, egiaztatu:

```text
[ ] Barne-erregistroa dago

[ ] Erregistroak ikertzea ahalbidetzen du

[ ] Ez du sekreturik

[ ] Ez dago webetik eskuragarri

[ ] Errotazioa aurreikusita dago
```

## Kanpotik berrikustea

Egiaztapen erabilgarri bat da aplikazioa kanpoko erabiltzaile batek ikusiko lukeen moduan behatzea.

Galderak:

```text
Zer zerbitzu dira ikusgai?

Zer informazio itzultzen du zerbitzariak?

Zer gertatzen da barne-ibilbide batera sartzen banaiz?

Publikoak izan behar ez duten fitxategiak deskarga ditzaket?

Zer egoera-kode jasotzen dut?
```

Berrikuspena norberaren sistemetan edo berariaz baimendutako sistemetan bakarrik egin behar da.

## Ebidentziak

Hedapenaren berrikuspena honako hauen bidez justifika daiteke:

- HTTPSren pantaila-argazkia;
- ziurtagiria;
- goiburuak;
- sekreturik gabeko konfigurazioa;
- arkitektura-diagrama;
- baimenak;
- errore baten aurreko erantzuna;
- anonimizatutako log-zatia.

Ebidentziak kontrola frogatu behar du informazio sentikorra agerian utzi gabe.

## TxurdiGest-en aplikatzea

Azken berrikuspen batek honako hauek egiazta ditzake:

```text
[ ] HTTPS aktibo

[ ] HTTP HTTPSra birbideratzen da

[ ] APP_DEBUG=false

[ ] Sekretuak kodetik kanpo

[ ] .env ez dago eskuragarri

[ ] Behar diren atakak bakarrik

[ ] Barneko datu-basea

[ ] Baimen egokiak

[ ] Goiburuak egiaztatuta

[ ] Errore kontrolatuak

[ ] Logak babestuta
```

## 4. blokearekin lotura

4. blokean modu seguruan nola hedatu erabaki zen.

Bloke honetan hau egiaztatzen da:

```text
Erabakia

    ↓

Aplikatutako konfigurazioa

    ↓

Proba

    ↓

Ebidentzia
```

Aldea garrantzitsua da.

Aurreikusitako konfigurazio bat ez da egiaztatutako konfigurazio baten baliokidea.

## Ideia nagusia

> Hedapen segurua ez da suposatzen: produkziotik berrikusi eta egiaztapen behagarrien bidez frogatu behar da.
