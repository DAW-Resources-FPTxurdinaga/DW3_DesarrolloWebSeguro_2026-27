# Fitxategien eta direktorioen baimenen inplementazioa

Baimenen konfigurazioa hedapen-prozesuaren parte gisa egin behar da.

Helburua da aplikazioak funtzionatzeko behar dituen baimenak zehazki izatea, baina gehiago ez.

## Egitura berrikusi baimenak esleitu aurretik

Baimenak aldatu aurretik, komeni da honakoa identifikatzea:

- aplikazioaren kodea;
- konfigurazio-fitxategiak;
- sortutako datuak dituzten direktorioak;
- erabiltzaileek igotako fitxategiak;
- erregistroak.

Adibidea:

```text
/var/www/txurdigest

├── app/
├── config/
├── public/
├── storage/
└── vendor/
```

Eremu bakoitzak behar desberdinak ditu.

## Fitxategien jabea

Ohiko praktika bat da kodea hedapen-erabiltzaile baten jabetzakoa izatea eta web zerbitzariak irakurketa-sarbidea izatea.

Adibide kontzeptuala:

```text
Kodea

jabea:
hedapen-erabiltzailea

web zerbitzariaren sarbidea:
irakurketa
```

Web zerbitzariak ez ditu fitxategi guztiak aldatu behar.

## Jabea eta taldea esleitzea

Linuxek jabea eta taldea aldatzeko aukera ematen du honen bidez:

```bash
chown
```

Adibidea:

```bash
sudo chown -R usuario:grupo /var/www/txurdigest
```

Aukera zehatza zerbitzariaren arkitekturaren araberakoa da.

Garrantzitsuena da jabetzak aplikazioaren funtzionamenduarekin koherenteak izatea.

## Irakurketa- eta idazketa-baimenak

Baimenek behar funtzional bati erantzun behar diote.

Adibidea:

```text
PHP kodea

irakurketa


Logak

irakurketa/idazketa


Uploads

irakurketa/idazketa
```

Ez da idazketa aplikazio osoari modu globalean aplikatu behar.

## Gehiegizko baimenak saihestea

Praktika okerra:

```bash
chmod -R 777 /var/www/txurdigest
```

Baimen-arazoak azkar konpon ditzakeen arren, arrisku bat sortzen du:

- edozein erabiltzailek fitxategiak alda ditzake;
- konprometitutako prozesu batek aplikazioa alda lezake;
- ahultasun baten inpaktua handitzen du.

Gutxieneko konfigurazio beharrezkoa bilatu behar da.

## Baimenen adibidea

Konfigurazio posible bat:

```text
Aplikazio-fitxategiak:

644


Direktorioak:

755
```

Idazketa behar duten direktorioak:

```text
storage/

775
```

Balio horiek ohiko adibideak dira, baina benetako zerbitzarira egokitu behar dira.

## Baimenak Laravel-en

Laravelrek idazketa behar duten direktorio jakin batzuk erabiltzen ditu.

Normalean:

```text
storage/

bootstrap/cache/
```

Adibidea:

```bash
chmod -R 775 storage bootstrap/cache
```

Web prozesuak horietan idatzi ahal izan behar du.

Proiektuaren gainerakoak ez du idazketa-baimenik behar.

## Erabiltzaileek igotako fitxategiak

Igoeren direktorioek arreta berezia behar dute.

Adibidea:

```text
storage/uploads/
```

Honakoa baimendu behar du:

```text
fitxategiak gordetzea

baimendutako fitxategiak irakurtzea
```

baina ez du baimendu behar:

```text
kodea exekutatzea
```

Babesak honakoa konbinatu behar du:

- baimenak;
- kokapen egokia;
- web zerbitzariaren konfigurazioa;
- aplikazioaren baliozkotzea.

## Fitxategi sentikorrak babestea

Honelako fitxategiek:

```text
.env

gako pribatuak

logak

barneko konfigurazioa
```

baimen murriztaileak izan behar dituzte.

Adibide kontzeptuala:

```text
Aplikazioa

irakur dezake


Kanpoko erabiltzaileak

sarbiderik gabe
```

Gainera, ez dira inoiz web zerbitzariaren bidez argitaratuta egon behar.

## Baimenak egiaztatzea

Baimenak berrikusteko:

```bash
ls -la
```

Adibidea:

```text
-rw-r----- 1 usuario grupo archivo.env
```

Honakoa egiaztatzeko balio du:

- jabea;
- taldea;
- uneko baimenak.

## Gehiegi irekitako baimenak bilatzea

Gehiegizko baimenak dituzten fitxategiak badauden berrikus daiteke:

```bash
find /var/www/txurdigest -perm -o+w
```

Berrikuspenak edozein erabiltzailek aldatu ditzakeen elementuak lokalizatzeko aukera ematen du.

## Hedapen automatikoa

Ingurune profesionaletan, hedapen-prozesuek baimenak behar bezala ezarri behar lituzkete.

Hedapen bat ez litzateke honen mende egon behar:

```text
"chmod exekutatu funtzionatu arte"
```

Konfigurazio ezagun eta errepikagarri bat egon behar da.

Adibidea:

```text
Aplikazioa deskargatu

        ↓

Jabea esleitu

        ↓

Baimenak konfiguratu

        ↓

Zerbitzuak berrabiarazi

        ↓

Funtzionamendua egiaztatu
```

## Baimenak eta segurtasun-kopiak

Segurtasun-kopiek ere babesa behar dute.

Honelako kopia batek:

```text
backup.sql
```

honakoa eduki dezake:

- datu pertsonalak;
- barneko informazioa;
- kredentzialak.

Aplikazio nagusiaren segurtasun berarekin tratatu behar da.

## TxurdiGest-en adibidea

Konfigurazioa:

```text
/var/www/txurdigest

app/

irakurketa


config/

irakurketa murriztua


public/

irakurketa


storage/

irakurketa/idazketa
```

Web zerbitzariak aplikazioa exekuta dezake eta beharrezko datuak gorde.

Ezin du proiektu osoa arbitrarioki aldatu.

## Checklist-a

```text
[ ] Jabeak berrikusita

[ ] Talde zuzena esleituta

[ ] Ez dago 777 baimenik

[ ] Kodeak ez du beharrezkoa ez den idazketarik

[ ] Idazteko baimena duten direktorioak identifikatuta

[ ] .env babestuta

[ ] Uploads babestuta

[ ] Backups babestuta

[ ] Baimenak berrikusita hedapenaren ondoren
```

## Gako-ideia

> Baimen zuzenek aplikazioak funtzionatzea ahalbidetzen dute, web zerbitzariari edo beste erabiltzaile batzuei beharrezkoak ez diren gaitasunak eman gabe.
