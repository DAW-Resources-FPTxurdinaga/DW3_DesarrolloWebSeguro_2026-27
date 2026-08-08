# Hedapen segurua

Aplikazio web bat ez da segurua izateari uzten garapena amaitzen denean.

Produkziora igarotzeak segurtasunean zuzenean eragina izan dezaketen erabaki berriak sartzen ditu:

- ingurunearen konfigurazioa;
- sekretuen kudeaketa;
- zerbitzuen esposizioa;
- ziurtagiriak eta komunikazioak;
- sistemaren baimenak;
- datu-baseetarako sarbidea;
- jardueraren erregistroa;
- zerbitzariaren konfigurazioa.

Ondo programatutako aplikazio bat ere arriskuan gera daiteke exekutatzen den ingurunea behar bezala konfiguratuta ez badago.

## Segurtasuna bizi-ziklo osoan

Segurtasuna ez da inplementazioan amaitzen.

Hedapena aplikazio baten bizi-zikloaren parte da:

```text
Analisia
   ↓
Diseinu segurua
   ↓
Inplementazio segurua
   ↓
Probak
   ↓
Hedapen segurua
   ↓
Mantentzea
```

Fase bakoitzean arriskua murriztu edo handitu dezaketen erabakiak sartzen dira.

## Garapena eta produkzioa

Garapenean ohikoa da lana errazteko pentsatutako konfigurazioak erabiltzea:

- errore-mezu xeheak;
- arazketa-tresnak;
- tokiko kredentzialak;
- zerbitzu osagarriak;
- aldi baterako konfigurazioak.

Aukera horiek ez dira zuzenean produkzio-ingurunera eraman behar.

Ingurune errealak lehentasuna eman behar dio honi:

- eskuragarritasuna;
- konfidentzialtasuna;
- osotasuna;
- sarbide-kontrola;
- trazabilitatea.

## Web garatzailearen rola

Hedapen segurua ez dagokio soilik sistema-administratzaileari.

Garatzaileak jakin behar du bere erabakiek ingurunean nola eragiten duten:

- non gordetzen diren sekretuak;
- aplikazioak zer zerbitzu behar dituen;
- zer baimen behar dituen;
- erabiltzaileari zer informazio erakusten zaion;
- erroreak nola erregistratzen diren;
- aplikazioa beste zerbitzu batzuekin nola komunikatzen den.

Helburua ez da azpiegitura osoa administratzea, baizik eta modu seguruan heda daitezkeen aplikazioak garatzea.

## DAW erronkekin lotura

Ikastaroan garatutako proiektuek erabaki horiek ingurune erreal batean aplikatu behar dituzte.

Adibidez:

```text
Garatutako aplikazioa
        ↓
Produkzio-konfigurazioa
        ↓
Web zerbitzaria
        ↓
Datu-basea
        ↓
Azken erabiltzaileak
```

Hedapenean berrikusiko da:

- aplikazioak HTTPS erabiltzen duela;
- sekretuak ez daudela kodean sartuta;
- datu-basea ez dagoela beharrezkoa ez den moduan agerian;
- baimenak egokiak direla;
- erroreek ez dutela barneko informazioa erakusten;
- zerbitzariak beharrezkoa dena bakarrik erakusten duela.

## SINF-ekin lotura

Hedapen seguruak garapenaren eta azpiegituraren arteko lankidetza eskatzen du.

Modulu honetan web garapenaren ikuspegitik landuko da:

- aplikazio batek zer behar duen;
- zer konfigurazio espero duen;
- gaizki hedatzen bada zer arrisku agertzen diren.

Sistema eragilearen, sareen edo zerbitzuen administrazio aurreratuarekin lotutako alderdiak beste modulu batzuetan lantzen dira.

## Blokearen ikuspegia

Bloke honetan landuko dira:

- inguruneen arteko konfigurazio bereizia;
- HTTPS eta ziurtagiriak;
- sekretuen kudeaketa segurua;
- zerbitzariaren esposizio-azalera;
- fitxategien baimenak;
- datu-basearen babesa;
- HTTP goiburuak;
- erroreen eta erregistroen kudeaketa.

Helburua da ulertzea aplikazio seguru batek ingurune segurua ere behar duela.

## Gako-ideia

> Aplikazio seguru bat ez dago soilik bere kodearen mende. Nola konfiguratzen, argitaratzen eta mantentzen den ere funtsezkoa da.
