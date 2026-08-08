# HTTP segurtasun-goiburuen inplementazioa

Segurtasun-goiburuak normalean aplikazioa entregatzen duen web zerbitzarian konfiguratzen dira.

Helburua da HTTP erantzun bakoitzak nabigatzailearentzako politika egokiak izatea.

Fluxua:

```text
Erabiltzailea

    ↓

Web zerbitzaria

    ↓

HTTP erantzuna

    ↓

Segurtasun-goiburuak

    ↓

Nabigatzaileak murrizketak aplikatzen ditu
```

## Apache-n konfigurazioa

Apachek konfigurazio-moduluen bidez goiburuak gehitzeko aukera ematen du.

Adibidea:

```apache
Header always set X-Content-Type-Options "nosniff"
```

Web zerbitzariaren erantzunak honakoa izango du:

```http
X-Content-Type-Options: nosniff
```

Nabigatzaileak politika hori aplikatuko du.

## Nginx-en konfigurazioa

Nginx-en goiburuak honen bidez gehi daitezke:

```nginx
add_header X-Content-Type-Options "nosniff";
```

Ideia bera da:

```text
Web zerbitzaria

        ↓

Goiburua gehitu

        ↓

Bezeroak politika jasotzen du
```

## Content-Security-Policy

CSP goibururik garrantzitsuenetako bat da, nabigatzaileak zein baliabide exekuta edo karga ditzakeen kontrolatzeko aukera ematen duelako.

Hasierako adibidea:

```http
Content-Security-Policy:
default-src 'self'
```

Honek esan nahi du:

```text
Lehenespenez

↓

Baliabideak jatorri propiotik bakarrik
```

## CSP eta aplikazioaren bilakaera

CSP politika bat benetako aplikaziora egokitu behar da.

Aplikazio batek behar izan ditzake:

- bere scriptak;
- estilo-orriak;
- irudiak;
- iturriak;
- kanpoko APIak.

Beraz, ez da politika gehiegi murriztailea aplikatu behar funtzionamendua egiaztatu gabe.

Adibidea:

```text
Aplikazioa

        ↓

Erabilitako baliabideak berrikusi

        ↓

Politika egokia definitu
```

## CSP konfigurazio ez-seguruak saihestea

Honelako konfigurazio batek:

```http
script-src 'unsafe-inline'
```

arazo jakin batzuen aurreko babesa murriztu dezake.

Behar zehatz bat dagoenean bakarrik erabili behar da, ondorioak ulertuta.

## HSTS

Goiburuak:

```http
Strict-Transport-Security
```

nabigatzaileari adierazten dio HTTPS erabili behar duela.

Adibidea:

```http
Strict-Transport-Security:
max-age=31536000
```

Aktibatu aurretik, honakoa egiaztatu behar da:

- HTTPSk behar bezala funtzionatzen duela;
- baliabide guztiak HTTPS bidez daudela eskuragarri;
- aplikazioaren atal batek ere ez duela HTTPren menpekotasunik.

## X-Content-Type-Options

Ohiko konfigurazioa:

```http
X-Content-Type-Options: nosniff
```

Nabigatzaileak deklaratutakoaz bestelako mota batekin baliabidea interpretatzen saiatzea saihesten du.

Bereziki erabilgarria da aplikazioak honakoak zerbitzatzen dituenean:

- fitxategiak;
- irudiak;
- dokumentuak;
- deskargatzeko baliabideak.

## Referrer-Policy

Adibidea:

```http
Referrer-Policy: strict-origin
```

Erabiltzailea beste gune batzuetara nabigatzen denean bidaltzen den informazioa kontrolatzeko aukera ematen du.

Aukeratutako politikak oreka hau izan behar du:

```text
Pribatutasuna

        +

Behar funtzionalak
```

## Permissions-Policy

Aplikazio batek erabiltzen ez dituen nabigatzaile-gaitasunak murriztu ditzake.

Adibide kontzeptuala:

```http
Permissions-Policy:
camera=(), microphone=()
```

Horrek adierazten du aplikazioak ez duela kamera edo mikrofono sarbiderik behar.

## Goiburuak DevTools-ekin egiaztatzea

Goiburuak nabigatzailetik berrikus daitezke:

```text
DevTools

    ↓

Network

    ↓

Eskaera hautatu

    ↓

Response Headers
```

Adibidea:

```http
Content-Security-Policy

X-Content-Type-Options

Strict-Transport-Security
```

Egiaztapenak web zerbitzariak espero den konfigurazioa benetan bidaltzen duela berresten du.

## Komando-lerrotik egiaztatzea

HTTP erantzunak honelako tresnekin ere berrikus daitezke:

```bash
curl -I https://txurdigest.ejemplo
```

Erantzunak web zerbitzariak bidalitako goiburuak erakutsiko ditu.

Adibidea:

```http
HTTP/2 200

content-type: text/html

strict-transport-security: ...

x-content-type-options: nosniff
```

## Laravel-en aplikazioa

Goiburuak honen bidez konfigura daitezke:

- web zerbitzaria;
- middleware;
- aplikazioaren konfigurazio espezifikoa.

Erabakia politika aplikatzeko toki egokienaren araberakoa da.

Segurtasun-goiburu orokorrak normalean azpiegitura-mailakoak izaten dira.

## TxurdiGest-en adibidea

Web zerbitzariaren erantzun batek honakoa izan dezake:

```http
Content-Security-Policy:
default-src 'self'

X-Content-Type-Options:
nosniff

Referrer-Policy:
strict-origin

Strict-Transport-Security:
max-age=31536000
```

Nabigatzaileak aplikazioa nola tratatu behar duenari buruzko jarraibideak jasotzen ditu.

## Goiburuak aplikatu ondoren berrikustea

Politikak gehitu ondoren, honakoa egiaztatu behar da:

```text
[ ] Aplikazioak ondo kargatzen jarraitzen du

[ ] Script-ek funtzionatzen dute

[ ] Estiloek funtzionatzen dute

[ ] Irudiek funtzionatzen dute

[ ] API eskaerek funtzionatzen dute

[ ] Ez da CSP errorerik agertzen kontsolan
```

Segurtasun-politika oker batek funtzionalitate legitimoak apur ditzake.

## Goiburuak ez erabiltzea garapen seguruaren ordezko gisa

Goiburuek laguntzen dute, baina ez dituzte programazio-erroreak konpontzen.

Adibidea:

```text
CSP

        +

XSSrekiko zaurgarria den kodea

```

oraindik arazoak dituen aplikazio bat da.

Irtenbide nagusia honakoa izaten jarraitzen du:

- baliozkotzea;
- irteera segurua;
- autentikazioa;
- baimena.

## Checklist-a

```text
[ ] HTTPS aktibo HSTS erabili aurretik

[ ] Goiburuak berrikusita

[ ] CSP aplikaziora egokituta

[ ] Ez dira politikak analisirik gabe kopiatu

[ ] DevTools-ek erantzunak egiaztatzea ahalbidetzen du

[ ] Ez da funtzionalitaterik hautsi

[ ] Konfigurazioa dokumentatuta dago
```

## Gako-ideia

> Segurtasun-goiburuei esker konfigura daiteke nabigatzaileak aplikazio bat nola interpretatu behar duen, baina haien eraginkortasuna gainerako segurtasun-neurriak behar bezala inplementatuta egotearen mende dago.
