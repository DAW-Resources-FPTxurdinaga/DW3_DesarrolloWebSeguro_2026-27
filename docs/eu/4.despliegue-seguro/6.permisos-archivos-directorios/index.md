# Fitxategien eta direktorioen baimenak

Fitxategi-sistemaren baimenek zehazten dute nork irakur, aldatu edo exekuta ditzakeen aplikazio baten fitxategiak.

Konfigurazio oker batek nahi ez diren aldaketak ahalbidetu ditzake edo informazio sentikorra agerian utzi.

Hedapen seguruaren helburua pribilegio minimoaren printzipioa aplikatzea da:

> Elementu bakoitzak funtzionatzeko behar dituen baimenak bakarrik izan behar ditu.

## Erabiltzaileak eta prozesuak

Linux zerbitzari batean, aplikazio bat ez da pertsona gisa zuzenean exekutatzen.

Normalean web zerbitzariarekin lotutako prozesu bat dago:

```text
Kanpoko erabiltzailea

        ↓

Web zerbitzaria

        ↓

Aplikazio-prozesua
```

Prozesu horrek sistemako erabiltzaile bat erabiltzen du, baimen jakin batzuekin.

Segurtasuna erabiltzaile horrek zer egin dezakeenaren mende dago.

## Jabea, taldea eta baimenak

Linuxek baimenak honela esleitzen ditu:

```text
Jabea

Taldea

Beste erabiltzaileak
```

Bakoitzak honelako baimenak izan ditzake:

```text
r  irakurketa

w  idazketa

x  exekuzioa
```

Adibidea:

```text
-rw-r-----
```

Kontzeptualki, honek esan nahi du:

```text
Jabea:
irakurketa + idazketa

Taldea:
irakurketa

Besteak:
sarbiderik gabe
```

## Gehiegizko baimenen arriskua

Ohiko baina ez-segurua den praktika bat hau da:

```bash
chmod -R 777 aplicacion/
```

Horrek hau ahalbidetzen du:

```text
denek irakur dezakete

denek idatz dezakete

denek exekuta dezakete
```

Arazkoa da sarbidea duen edozein erabiltzailek edo prozesuk aplikazioaren fitxategiak alda ditzakeela.

Baimenek espezifikoak izan behar dute.

## Kodea eta idazteko baimena duten direktorioak

Fitxategi guztiek ez dituzte baimen berak behar.

Aplikazio batek normalean honakoa du:

```text
Iturburu-kodea

        ↓

irakurketa bakarrik


Aldi baterako biltegiratzea

        ↓

irakurketa/idazketa
```

Adibidea:

```text
app/

irakurketa bakarrik


storage/

idazketa beharrezkoa
```

Proiektu osoari idazketa emateak arriskua handitzen du.

## Idazketa behar duten direktorioak

Aplikazio batzuek fitxategiak aldatu behar dituzte:

- logak;
- cacheak;
- erabiltzaileek igotako fitxategiak;
- gordetako saioak.

Direktorio horiek identifikatu egin behar dira.

Laravel adibidea:

```text
storage/

bootstrap/cache/
```

web prozesuak idazketa behar izan dezake horietan.

Gainerako aplikazioak ez luke beharrezkoa ez den idazketa-baimenik izan behar.

## Fitxategi sentikorrak

Fitxategi batzuek babes gehigarria behar dute:

```text
.env

konfigurazioa

gako pribatuak

segurtasun-kopiak

logak
```

Ez lirateke kanpoko erabiltzaileentzat irisgarri izan behar, ezta behar ez dituzten prozesuentzat ere.

## Aplikazioaren eta sortutako datuen arteko bereizketa

Jardunbide egoki bat:

```text
Aplikazioa

        ↓

Babestutako kodea


Sortutako datuak

        ↓

Kokapen kontrolatua
```

Adibidea:

```text
/var/www/txurdigest/

    app/

    public/

    storage/
```

Kodea egonkor mantentzen da.

Sortutako datuak kokapen espezifikoetan gordetzen dira.

## Erabiltzaileek igotako fitxategiak

Igotako fitxategiak gordetzen diren direktorioek arreta berezia behar dute.

Honakoa egin behar dute:

- behar denean idazketa baimendu;
- exekuzioa eragotzi;
- nork duen sarbidea kontrolatu.

Adibidea:

```text
storage/uploads/

irakurketa/idazketa kontrolatua

EZ

kodearen exekuzioa
```

## Web zerbitzariaren erabiltzailea

Web zerbitzaria normalean erabiltzaile espezifiko batekin exekutatzen da.

Ohiko adibideak:

```text
www-data

apache

nginx
```

Erabiltzaile horrek aplikazioa exekutatzeko gutxieneko baimenak behar ditu.

Konfigurazio okerra izango litzateke:

```text
Aplikazioa

jabea:
root

baimenak:
dena idazgarria
```

Aplikazioak ez luke gehiegizko baimenen menpe egon behar.

## Pribilegio minimoa aplikatzea

Galdera zuzena ez da:

```text
Funtzionatzeko zein baimen behar dira?
```

baizik eta:

```text
Benetan zein baimen behar ditu?
```

Adibidea:

Aplikazioak hau behar du:

```text
PHP kodea irakurri

logak idatzi

igotako fitxategiak gorde
```

Ez du hau behar:

```text
proiektuko fitxategi guztiak aldatu
```

## Baimenak eta hedapena

Hedapen batean honakoa berrikusi behar da:

```text
Kopiatutako fitxategiak

        ↓

Jabe zuzena

        ↓

Talde zuzena

        ↓

Baimen egokiak
```

Hedapen automatiko batek baimen ez-seguruak dituzten fitxategiak sortzea saihestu behar du.

## Adibide kontzeptuala

Konfigurazio egokia:

```text
Aplikazioaren kodea

erabiltzailea:
root/garatzailea

baimenak:
zerbitzariarentzako irakurketa


Storage

erabiltzailea:
web zerbitzaria

baimenak:
irakurketa/idazketa
```

Aplikazioak funtziona dezake proiektu osoaren kontrol osoa izan gabe.

## Beste kontrolekin lotura

Baimenak segurtasun-geruza bat gehiago dira.

Adibidez:

```text
Aplikazio-baliozkotzea

        +

Baimena

        +

Sistemako baimenak

        +

Web zerbitzariaren konfigurazioa
```

Geruza bakoitzak arazo mota desberdin bat mugatzen du.

## TxurdiGest-en adibidea

Egitura:

```text
/var/www/txurdigest

    app/

    config/

    public/

    storage/
```

Baimenak:

```text
app/

irakurketa


config/

irakurketa babestua


public/

irakurketa


storage/

irakurketa/idazketa
```

Web zerbitzariak lan egin dezake, baina ez proiektu osoa aldatu.

## Checklist-a

Argitaratu aurretik:

```text
[ ] Ez dago 777 baimenik

[ ] Web zerbitzariak beharrezko baimenak bakarrik ditu

[ ] Kodeak ez du idazketa-baimenik behar

[ ] Idazteko baimena duten direktorioak identifikatuta daude

[ ] Fitxategi sentikorrak babestuta daude

[ ] Igotako fitxategiak ez dira exekutatzen

[ ] Jabeak eta taldeak zuzenak dira
```

## Gako-ideia

> Sistemako baimenak aplikazioaren segurtasunaren parte dira: ondo programatutako aplikazio batek ere pribilegio egokiekin exekutatu behar du.
