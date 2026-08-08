# Web zerbitzariaren eta esposizio-azaleraren inplementazioa

Web zerbitzariaren segurtasuna diseinuan definitutako arkitektura behar bezala aplikatzearen mende dago.

Helburua ez da osagai guztiak eskuragarri egitea, baizik eta beharrezko komunikazioak bakarrik baimentzea.

## Web aplikazio baten egitura gomendatua

Aplikazio batek ez lituzke bere fitxategi guztiak direktorio publikoaren barruan kokatu behar.

Adibidea:

```text
Aplicacion

├── app/
├── config/
├── storage/
├── vendor/
└── public/
    ├── index.php
    ├── css/
    └── js/
```

Web zerbitzariak honetara bakarrik apuntatu beharko luke:

```text
public/
```

Gainerako karpetek nabigatzaile bidezko sarbide zuzenetik kanpo egon behar dute.

## Aplikazio osoa argitaratzearen arriskua

Konfigurazio oker batek:

```text
Web zerbitzaria

    ↓

/var/www/txurdigest/
```

barneko fitxategiak eskuragarri utz ditzake:

```text
.env

config/

logs/

vendor/

segurtasun-kopiak
```

Konfigurazio egoki batek:

```text
Web zerbitzaria

    ↓

/var/www/txurdigest/public/
```

esposizioa mugatzen du.

## Web zerbitzariaren konfigurazioa

Web zerbitzariak honakoa ezagutu behar du:

- domeinua;
- erro direktorio publikoa;
- HTTPS ziurtagiriak;
- beharrezko baimenak;
- sarbide-arauak.

Kontzeptualki:

```text
HTTP eskaera

        ↓

Web zerbitzaria

        ↓

Direktorio publikoa

        ↓

Aplikazioa
```

Web zerbitzariak ez luke barneko fitxategietara zuzenean sartzea baimendu behar.

## Fitxategi sentikorrak

Fitxategi batzuek nabigatzailearen irismenetik kanpo egon behar dute:

```text
.env

.git/

barneko konfigurazioa

logs

segurtasun-kopiak

aldi baterako fitxategiak
```

Egiaztapen erraz bat da URL bidez sartzen saiatzea:

```text
https://dominio/.env
```

Erantzun zuzenak ez luke edukia erakutsi behar.

## Apache konfigurazioa

Apachen, aplikazio bat Virtual Host baten bidez konfigura daiteke.

Adibide kontzeptuala:

```apache
<VirtualHost *:443>

    ServerName txurdigest.ejemplo

    DocumentRoot /var/www/txurdigest/public

</VirtualHost>
```

Erabaki garrantzitsua hau da:

```text
DocumentRoot

        ↓

public/

```

eta ez proiektuaren karpeta osoa.

## Nginx konfigurazioa

Kontzeptua baliokidea da:

```nginx
server {

    server_name txurdigest.ejemplo;

    root /var/www/txurdigest/public;

}
```

Web zerbitzariak definitutako sarrera-puntua bakarrik argitaratzen du.

## Oinarrizko baimenak

Baimenek printzipio hau jarraitu behar dute:

```text
beharrezko gutxieneko baimenak
```

Aplikazioak hau egiteko gai izan behar du:

- beharrezko fitxategiak irakurri;
- beharrezkoa den tokian bakarrik idatzi.

Adibidea:

```text
Iturburu-kodea

irakurketa

↓

Web zerbitzaria


uploads karpeta

irakurketa/idazketa

↓

Web zerbitzaria
```

Ez litzateke hau erabili behar:

```bash
chmod 777
```

irtenbide orokor gisa.

Gehiegizko baimenek arazo posible baten inpaktua handitzen dute.

## Idazketa behar duten karpetak

Aplikazio batzuek datuak idatzi behar dituzte:

- igotako fitxategiak;
- cacheak;
- logak.

Karpeta horiek argi identifikatu behar dira.

Adibidea:

```text
storage/

    idazketa beharrezkoa

app/

    irakurketa bakarrik
```

Proiektu osoak ez ditu idazteko baimenak behar.

## AWS Security Groups

AWSen, Security Groupsek baliabide bakoitzera iristen den trafikoa kontrolatzeko aukera ematen dute.

Adibidea:

Web zerbitzaria:

```text
Sarrera baimendua:

443 HTTPS
```

Administrazioa:

```text
22 SSH

baimendutako IPtik bakarrik
```

Datu-basea:

```text
3306 MySQL

web zerbitzaritik bakarrik
```

Datu-baseak ez du Internetetik konexioak onartu behar.

## Arkitektura publikoa eta pribatua

Ohiko arkitektura bat:

```text
Internet

    ↓

Web zerbitzaria
(azpisare publikoa)

    ↓

Aplikazioa

    ↓

Datu-basea
(azpisare pribatua)
```

Bereizketak esposizioa murrizten du.

## Kanpotik egindako egiaztapenak

Hedapena egin ondoren, komeni da kanpoko erabiltzaile batek zer ikusten duen egiaztatzea.

Adibideak:

```text
HTTPS dabil

↓

Barneko fitxategiak ez dira eskuragarriak

↓

Panelak ez daude argitaratuta

↓

Erroreak kontrolatuta daude
```

Galdera garrantzitsua:

> Behar dudana bakarrik ari naiz argitaratzen?

## Garapen-tresnak

Produkzioaren aurretik aldi baterako elementuak berrikusi behar dira:

- probako orriak;
- adibideko datuak;
- arazketa-tresnak;
- tokiko konfigurazioak.

Adibidea:

```text
development-tools/

        ↓

ezabatu edo babestu
```

Garapena errazten duenak arrisku argitaratu bihur daiteke.

## TxurdiGest-en adibidea

Gomendatutako egitura:

```text
Zerbitzaria

/var/www/txurdigest

    app/

    storage/

    vendor/

    public/

        index.php
```

Konfigurazioa:

```text
Apache/Nginx

        ↓

public/

        ↓

Laravel/PHP

        ↓

Datu-base pribatua
```

Sarbideak:

```text
Kanpoko erabiltzailea

HTTPS

Web zerbitzaria

Aplikazioa

Barneko datu-basea
```

## Hedapen-checklist-a

```text
[ ] DocumentRoot public/ direktoriora apuntatzen du

[ ] Fitxategi sentikorrak sarbide publikotik kanpo daude

[ ] Baimenak berrikusita

[ ] Ez dago beharrezkoak ez diren 777 baimenik

[ ] Idazketa behar duten karpetak identifikatuta

[ ] Security Groups berrikusita

[ ] Datu-basea ez da Internetetik irisgarria

[ ] Garapen-tresnak ezabatuta

[ ] Beharrezko atakak bakarrik daude irekita
```

## Gako-ideia

> Web zerbitzari segurua ez da sarbide gehien uzten duena, baizik eta aplikazioak funtzionatzeko beharrezko sarbideak bakarrik baimentzen dituena.
