# Autentifikazioa eta saioak

Autentifikazioak erabiltzaile baten identitatea egiaztatzen du aplikazioaren funtzio jakin batzuei sarbidea emateko.

Web aplikazio batean prozesu hau normalean honakoa izaten da:

- kredentzialak jasotzea;
- zerbitzarian egiaztatzea;
- saio bat sortzea;
- erabiltzailea petizio geroagokoetan identifikatzea;
- saioa itxi beharrezkoa ez denean.

Bloke honetan ez dugu aurrekoan ikusi genuen autentifikazioaren oinarrizko kontzeptu guztiak berriro garatuko. Helburua orain **PHP-n modu egokian inplementatzea** da.

## Oinarrizko autentifikazio fluxua

Saioa hasteko prozesua honela irudika daiteke:

```text
Erabiltzaileak kredentzialak sartzen ditu
        ↓
Eskaera zerbitzarira
        ↓
Datuen balidazioa
        ↓
Erabiltzailea bilatzea
        ↓
Pasahitza egiaztatzea
        ↓
Saioaren sorrera
        ↓
Autentikatutako sarbidea
```

Fase guztiak zerbitzarian egin behar dira.

Nabigatzaileak inprimakiak edo mezua erakutsi ditzake, baina ez du identitatea baliozkoa den erabaki behar.

## Pasahitzak

Pasahitzak ez dira testu lau gisa gorde behar.

Aplikazio batek funtzio espezifiko batekin eratorritako irudikapena gorde behar du.

PHP-n honako funtzioak erabiltzen dira:

```php
password_hash()
```

eta:

```php
password_verify()
```

Aplikazioak gordetako hash-a gorde eta gero sartutako pasahitza hash horrekin konparatzen du.

## Saioak

Autentikazio egokia egin ondoren, aplikazioak erabiltzailea petizio geroagokoetan ezagutu behar du.

PHP-k egoera hau saioen bidez kudeatzen du.

Kontzeptualki:

```text
Saioa ondo hasi da
        ↓
Zerbitzariak saio bat sortzen du
        ↓
Nabigatzaileak saio-identifikatzailea jasotzen du
        ↓
Geroagoko eskaerak
        ↓
Zerbitzariak saioa berreskuratzen du
```

Informazio sentikorra zerbitzarian geratzen da.

Nabigatzaileak soilik eskaera bakoitza saioarekin lotzeko beharrezkoa den identifikatzailea mantentzen du.

## Zer da saioan gorde daitekeen

Saio batek informazio hau eduki dezake:

```php
$_SESSION['usuario_id']
```

edo:

```php
$_SESSION['rol']
```

Adibidez:

```php
$_SESSION['usuario_id'] = $usuario['id'];
$_SESSION['rol'] = $usuario['rol'];
```

Ez da beharrezkoa erabiltzailearen datu guztiak gorde.

Gomendagarria da identifikatzeko eta eskaera kudeatzeko beharrezkoa den informazioa soilik mantentzea.

## Autentikazioa ez da baimenak

Erabiltzaile bat ondo hasi bada ere, ez du esan nahi eragiketa edozein egin dezakeela.

Adibidez:

```text
Erabiltzaile autentikatua
        ↓
kalifikazio bat aldatzea nahi du
        ↓
Baimea du?
```

Autentifikazioak erantzuten du:

> **Norbait da erabiltzailea?**

Baimenak erantzuten du:

> **Eragiketa hau egin dezake?**

Baimenak bloke honen hurrengo atalean aztertuko dira.

## Saio-cookie-ak

PHP-n saio-identifikatzailea normalean cookie baten bidez bidaltzen da.

Cookie hau behar bezala konfiguratu behar da.

Atributu garrantzitsuak hauek dira:

- `Secure`;
- `HttpOnly`;
- `SameSite`.

Atributu hauek jada kontzeptualki aztertu dira. Inplementazioan nola konfiguratu eta saioaren portaeran nola eragiten duten ikusiko da.

## Saio-identifikatzailea birsortu

Saioari lotutako konfiantza-maila aldatzen denean —adibidez, saioa ondo hasi ondoren—, gomendagarria da identifikatzaile berria sortzea.

PHP-n honela egin daiteke:

```php
session_regenerate_id(true);
```

Honek saioa autentikatu aurretik erabiltzen zen saio-identifikatzaile bera berrerabili ez dadin laguntzen du.

## Saioa ixtea

Saio bat ondo ixteak erabiltzaileari lotutako egoera ezabatzea dakar.

Ez da nahikoa interfazea ezkutatzea edo beste orrialde batera birbidaltzea.

Kontzeptualki:

```text
Erabiltzailea saioa ixtea eskatu du
        ↓
Zerbitzariak saioaren datuak ezabatzen ditu
        ↓
Saio aktiboa baliogabetzen du
        ↓
Erabiltzailea ez da gehiago autentikatua
```

## TxurdiGest-en adibidea

Demagun irakasle batek saioa hastean.

Fluxua honela izan daiteke:

```text
posta + pasahitza
        ↓
PHP-k datuak balidatzen ditu
        ↓
kontsulta prestatua erabiltzailea bilatzen du
        ↓
password_verify()
        ↓
session_regenerate_id()
        ↓
$_SESSION['usuario_id']
        ↓
erabiltzailea autentikatua
```

Orduztik, babestutako eragiketa bakoitzak baliozko saioaren existentzia egiaztatu behar du.

Adibidez:

```php
if (!isset($_SESSION['usuario_id'])) {
    http_response_code(401);
    exit;
}
```

Egiaztapen honek erabiltzaile autentikatua dagoela adierazten du.

Oraindik beharrezkoa izango da ondoren eragiketa hori egiteko baimenik duen egiaztatzea.

## Inplementazioa

[Inplementazioa](implementacion.md) atalean honakoak landuko ditugu:

- pasahitzen biltegiratze segurua;
- erabiltzaile-erregistroa;
- saio-cookie-ak konfiguratu;
- saioaren kudeaketa;
- saioa ixtea.
