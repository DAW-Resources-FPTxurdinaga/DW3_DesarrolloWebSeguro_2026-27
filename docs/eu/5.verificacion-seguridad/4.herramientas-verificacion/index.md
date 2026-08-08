# Egiaztapen-tresnak

Tresnek aplikazio batek benetan nola jokatzen duen behatzen laguntzen dute.

Ez dute garatzailearen ezagutza ordezkatzen.

Galdera zehatzei erantzuteko balio dute, adibidez:

```text
Zer eskaera bidali da?

Zer datu ditu?

Zer goiburu itzultzen ditu zerbitzariak?

Zer cookie erabiltzen ari dira?

Zer gertatzen da parametro bat aldatzen badugu?

Zer errore itzultzen du aplikazioak?
```

Modulu honetan, batez ere, dagoeneko ezagutzen diren tresnak erabiliko ditugu.

## Chrome DevTools

Chrome DevTools-ek nabigatzailearen eta HTTP eskaeren portaera behatzea ahalbidetzen du.

Egiaztapenerako atal erabilgarrienak hauek dira:

- Network;
- Application;
- Console.

## Network

Network fitxak aplikazioak egindako eskaerak berrikustea ahalbidetzen du.

Honako hauek erakuts ditzake:

- URLa;
- HTTP metodoa;
- egoera-kodea;
- goiburuak;
- parametroak;
- eskaeraren gorputza;
- erantzuna.

Adibidez:

```text
POST /login

Status: 200
```

Honelako egoerak ere hauteman daitezke:

```text
HTTP erabiltzea HTTPS ordez

4xx erroreak

5xx erroreak

espero ez diren eskaerak
```

## Headers

Eskaera baten barruan honako hauek berrikus daitezke:

```text
Request Headers

Response Headers
```

Horri esker, besteak beste, honako hauek egiazta daitezke:

- segurtasun-goiburuak;
- eduki mota;
- jatorria;
- cookieak;
- baimena.

## Payload

Payload fitxak bidalitako datuak behatzea ahalbidetzen du.

Adibidez:

```json
{
  "email": "usuario@ejemplo.com",
  "personas": 2
}
```

Zerbitzarira zehazki zer informazio iristen den egiaztatzeko erabilgarria da.

## Response

Erantzunari esker honako hauek egiazta daitezke:

- itzulitako datuak;
- errore-mezuak;
- agerian geratutako barne-informazioa;
- egoera-kodeak.

Aplikazio seguru batek beharrezkoa ez den informazioa itzultzea saihestu behar du.

## Application

Application atalak nabigatzailean gordetako informazioa behatzea ahalbidetzen du.

Bereziki:

- cookieak;
- local storage;
- session storage.

Modulu honetan bereziki interesgarria da cookieen atributuak egiaztatzea:

```text
Secure

HttpOnly

SameSite
```

## Console

Kontsolak honako hauek erakuts ditzake:

- JavaScript erroreak;
- ohartarazpenak;
- CSP arazoak;
- blokeatutako baliabideak.

Adibidez:

```text
Refused to load script because it violates Content-Security-Policy
```

Mezu mota honek CSP politika bat egiaztatzen lagun dezake.

## Burp Suite

Burp Suite-k HTTP eskaerak atzeman eta aldatzea ahalbidetzen du.

Modulu honetan behaketa- eta egiaztapen-tresna gisa erabiltzen da.

Ez da pentesting aurreratua egitea bilatzen.

Oinarrizko fluxua:

```text
Nabigatzailea

    ↓

Burp Proxy

    ↓

Zerbitzaria
```

Burp-ek eskaera zerbitzarira iritsi aurretik behatzea ahalbidetzen du.

## Eskaera bat atzematea

Adibidez:

```text
POST /reservas
```

Datuak:

```text
fecha=2026-08-10

personas=2
```

Burp-ek hau aldatzea ahalbidetzen du:

```text
personas=2
```

honela:

```text
personas=-5
```

eta zerbitzariak datua behar bezala baliozkotzen duen egiaztatzea.

## Repeater

Burp Repeater-ek eskaera bat hainbat aldiz berriro bidaltzea ahalbidetzen du, balio batzuk aldatuz.

Honako hauek egiaztatzeko erabilgarria da:

- identifikatzaileak;
- parametroak;
- goiburuak;
- autentifikazioa;
- baimena;
- baliozkotzea.

Adibidez:

```text
GET /reservas/25
```

Aldatu:

```text
25 → 26
```

eta emaitza behatu.

## DVWA

DVWA nahita ahula den aplikazio bat da.

Moduluan laborategi kontrolatu gisa erabiltzen da inplementazio-errore jakin batzuk ulertzeko.

Bereziki erabili da honako hauek lantzeko:

- XSS;
- SQL Injection;
- fitxategien igoera ez-segurua.

DVWA ez da produkzioan hedatu behar den aplikazio baten eredua.

Bere funtzioa honako hau behatzea da:

```text
Inplementazio ahula

        ↓

Portaera

        ↓

Zuzenketa
```

## Logak

Logak ere egiaztapen-tresna dira.

Zerbitzarian zer gertatu den egiaztatzea ahalbidetzen dute, nahiz eta erabiltzaileak mezu generiko bat jaso.

Adibidez:

```text
Erabiltzailea

Ezin izan da eragiketa osatu
```

Bitartean:

```text
Barneko loga

data

erabiltzailea

eragiketa

errore teknikoa
```

Berrikuspenean sekretuak agerian uzten dituzten logak erabiltzea saihestu behar da.

## Komando-lerroko tresnak

Egiaztapen sinple batzuk `curl` bezalako tresnekin egin daitezke.

Adibidez:

```bash
curl -I https://txurdigest.ejemplo
```

HTTP goiburuak berrikusteko erabil daiteke.

Eskaera bat ere bidal daiteke:

```bash
curl https://txurdigest.ejemplo/api/reservas
```

Ez da beharrezkoa `curl`-en aukera guztiak menderatzea.

Helburua da ulertzea aplikazio bat bere interfaze grafikoaren mende egon gabe ere egiazta daitekeela.

## Tresna galderaren arabera aukeratzea

Tresna guztiek ez dute helburu bera.

| Beharra | Tresna |
|---|---|
| Eskaerak behatu | DevTools Network |
| Cookieak berrikusi | DevTools Application |
| JavaScript edo CSP erroreak berrikusi | DevTools Console |
| Eskaera bat aldatu | Burp Suite |
| Eskaera bat errepikatu | Burp Repeater |
| Laborategian ahultasunak aztertu | DVWA |
| Barne-erroreak berrikusi | Logak |
| Goiburuak azkar kontsultatu | curl |

Tresna zer egiaztatu nahi den definitu ondoren aukeratu behar da.

## Tresna eta helburua ez nahastea

Hurbilketa desegokia izango litzateke:

```text
Burp ireki

        ↓

Gauzak probatu
```

Hurbilketa erabilgarriagoa:

```text
Helburua:

baimena egiaztatu

        ↓

Tresna:

Burp Repeater

        ↓

Proba:

baliabidearen IDa aldatu

        ↓

Espero den emaitza:

403
```

Tresna probaren zerbitzura dago.

## Ebidentziak

Tresnek ebidentziak lortzeko ere balio dute.

Adibidez:

- Network-eko pantaila-argazkia;
- 403 erantzuna;
- HTTP goiburuak;
- cookie segurua;
- aldatutako eskaera;
- anonimizatutako log-zatia.

Ebidentziek beharrezkoa den informazioa bakarrik erakutsi behar dute.

Ez dute honako hauek jaso behar:

- pasahitzak;
- token osoak;
- saio-cookie osoak;
- API gakoak;
- sekretuak.

## TxurdiGest-en aplikatzea

Erreserben funtzionalitate batean honako hauek erabil daitezke:

```text
DevTools

→ eskaera behatu


Burp Suite

→ IDa edo datuak aldatu


Zerbitzaria

→ erantzun


DevTools/Burp

→ egoera-kodea egiaztatu


Logak

→ behar izanez gero barne-errorea egiaztatu
```

Helburua kontrolak funtzionatzen duela frogatzen duen ebidentzia argia lortzea da.

## Ideia nagusia

> Segurtasun-tresna bat erabilgarria da galdera zehatz bati erantzuten dionean. Lehenik zer egiaztatu nahi dugun definitzen da, eta ondoren tresna egokia aukeratzen da.
