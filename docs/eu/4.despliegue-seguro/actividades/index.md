# Jarduera: hedapen seguruaren auditoria

## Testuingurua

Erronkan garatutako aplikazioak garapen-ingurune batetik benetako erabiltzaileentzat prestatutako ingurune batera igaro behar du.

Jarduera honen helburua da hedapenak moduluan landutako segurtasun-erabakiak mantentzen dituela berrikustea.

Ez da aplikazioak funtzionatzen duela egiaztatzea bakarrik; modu seguruan konfiguratuta dagoela egiaztatzea ere bada.

## Helburua

Aplikazioaren hedapenaren berrikuspena egitea, segurtasun-egiaztapen zerrenda bat aplikatuz.

Taldeak honako hauek identifikatu behar ditu:

- konfigurazio zuzenak;
- arrisku posibleak;
- hartutako erabakiak;
- egindako berrikuspena frogatzen duten ebidentziak.

## Jardueraren faseak

```text
Konfigurazioa berrikusi

        ↓

Hedapena egiaztatu

        ↓

Arriskuak identifikatu

        ↓

Zuzenketak aplikatu

        ↓

Ebidentziak dokumentatu
```

# Berrikuspen-checklist-a

## 1. Ingurunearen konfigurazioa

Egiaztatu:

```text
[ ] Garapenaren eta produkzioaren arteko bereizketa dago

[ ] Konfigurazioa ez dago kodearekin nahastuta

[ ] Sekretuak biltegitik kanpo daude

[ ] DEBUG desaktibatuta dago produkzioan

[ ] Ingurune-aldagaiak behar bezala konfiguratuta daude
```

Balizko ebidentziak:

- konfigurazioaren pantaila-argazkia sekretuak erakutsi gabe;
- erabilitako aldagaien azalpena;
- proiektuaren egitura.

---

## 2. HTTPS eta komunikazioak

Egiaztatu:

```text
[ ] Aplikazioak HTTPS bidez funtzionatzen du

[ ] Ziurtagiria baliozkoa da

[ ] HTTPk HTTPSra birbideratzen du

[ ] Ez dago HTTP bidez kargatutako baliabiderik

[ ] Cookie sentikorrek konfigurazio egokia erabiltzen dute
```

Balizko ebidentziak:

- HTTPS erakusten duen nabigatzailearen pantaila-argazkia;
- ziurtagiriaren berrikuspena;
- DevTools bidezko egiaztapena.

---

## 3. Zerbitzaria eta esposizioa

Egiaztatu:

```text
[ ] Beharrezko zerbitzuak bakarrik daude eskuragarri

[ ] Aplikazioak ez ditu barne-fitxategiak agerian uzten

[ ] Direktorio publikoa zuzena da

[ ] Ez dago argitaratutako garapen-tresnarik

[ ] Arkitekturak osagai publikoak eta barnekoak bereizten ditu
```

Balizko ebidentziak:

- arkitektura-diagrama;
- zerbitzariaren konfigurazioa;
- sarbideen berrikuspena.

---

## 4. Datu-basea

Egiaztatu:

```text
[ ] Datu-basea ez dago Internetera zuzenean agerian

[ ] Aplikazioak erabiltzaile espezifiko bat erabiltzen du

[ ] Erabiltzailearen baimenak minimoak dira

[ ] Kredentzialak ez daude kodean

[ ] Babes-kopiak edo zehaztutako prozedura bat daude
```

Balizko ebidentziak:

- konexio-konfigurazioa sekreturik gabe;
- sarbide-diagrama;
- baimenen azalpena.

---

## 5. Fitxategien baimenak

Egiaztatu:

```text
[ ] Ez dago gehiegizko baimenik

[ ] Ez da chmod 777 erabiltzen irtenbide gisa

[ ] Idazteko moduko karpetak identifikatuta daude

[ ] Fitxategi sentikorrak babestuta daude

[ ] Igotako fitxategiak ezin dira exekutatu
```

Balizko ebidentziak:

- direktorioen egitura;
- baimen garrantzitsuak;
- erabakien azalpena.

---

## 6. Erroreak eta logak

Egiaztatu:

```text
[ ] Errore teknikoak ez zaizkio erabiltzaileari agertzen

[ ] Logak konfiguratuta daude

[ ] Logek ez dute sekreturik

[ ] Log-fitxategiak ez dira publikoki eskuragarriak

[ ] Arazoak ikertzeko informazio nahikoa dago
```

Balizko ebidentziak:

- erroreen kudeaketaren pantaila-argazkia;
- anonimizatutako log-adibidea.

---

## 7. Segurtasun-goiburuak

Egiaztatu:

```text
[ ] Goiburuak konfiguratuta daude

[ ] Konfigurazioa berrikusi da

[ ] CSPk ez ditu funtzionalitateak hausten

[ ] Nabigatzaileak espero diren politikak jasotzen ditu
```

Balizko ebidentziak:

- DevTools Network-en pantaila-argazkia;
- HTTP segurtasun-goiburuen zerrenda.

---

# Entregagaia

Taldeak honakoa entregatu behar du:

## 1. Osatutako checklist-a

Honakoa adieraziz:

- berrikusitako elementuak;
- egoera;
- hobekuntza posibleak.

## 2. Hedapen-diagrama

Hau erakutsi behar du:

```text
Erabiltzailea

    ↓ HTTPS

Web zerbitzaria

    ↓

Aplikazioa

    ↓

Datu-basea
```

Aplikatutako segurtasun-elementuak barne.

## 3. Ebidentziak

Honakoen pantaila-argazkiak edo azalpenak:

- HTTPS;
- konfigurazioa;
- arkitektura;
- aplikatutako kontrolak.

## 4. Amaierako hausnarketa

Erantzun:

- Zein segurtasun-erabaki aplikatu dira?
- Zein arrisku murriztu dira?
- Zein hobekuntza geratuko lirateke egiteko?

# Moduluarekiko lotura

Jarduera honek landutako edukiak integratzen ditu:

```text
Diseinu segurua

        ↓

Inplementazio segurua

        ↓

Hedapen segurua

        ↓

Erronkako aplikazioa
```

Helburua da segurtasuna aplikazioaren garapen osoaren parte izatea.

# Gako-ideia

> Aplikazio profesional batek ez du funtzionatu bakarrik behar: modu seguruan hedatu eta mantendu ahal izan behar da.
