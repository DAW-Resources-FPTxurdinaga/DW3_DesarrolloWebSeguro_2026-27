# Baimenak

Autentifikazioak jakiten du eskaera nor egiten duen.

Baimenek erabakitzen dute erabiltzaile horrek eskaturiko eragiketa egin ahal duen ala ez.

Desberdintasuna funtsezkoa da:

```text
Autentifikazioa
    ↓
Nor zara?

Baimenak
    ↓
Hau egin dezakezu?
```

Aplikazio batek erabiltzaile bat ondo identifikatu dezake eta hala ere ez du irizpide egokiak dituen funtzio edo baliabideetara sarbidea eman behar.

## Autentikatua ez da automatikoki baimendua

Demagun irakasle bat ondo saioa hasi duela.

Saioak honela izan dezake:

```php
$_SESSION['usuario_id'] = 12;
$_SESSION['rol'] = 'profesor';
```

Honek erabiltzaile autentikatua dagoela frogatzen du.

Baina ez du esan nahi honakoak egiteko baimena izan dezakeela:

- edozein kalifikazio aldatu;
- edozein talderi buruz kontsultatu;
- erabiltzaileak ezabatu;
- administrazio-funtzioetara sartu.

Eragiketa sentsible bakoitzak bere baimen-baldintzak egiaztatu behar ditu.

## Baimenak rolaren arabera

Baimenak emateko modu sinplea rolak erabilitzea da.

Adibidez:

```text
Administratzailea
    ↓
erabiltzaileak kudeatzen ditu

Irakaslea
    ↓
taldeak eta kalifikazioak kudeatzen ditu

Ikaslea
    ↓
beren datuak kontsultatzen ditu
```

PHP-n honela egiaztatu daiteke:

```php
if ($_SESSION['rol'] !== 'administrador') {
    http_response_code(403);
    exit('Ez du baimenik.');
}
```

## Rolak ez dira beti nahikoa

Aplikazio askotan rol bereko bi erabiltzaileek ez dute baliabide berdinera sarbidea eduki behar.

Adibidez, bi irakaslek rol bera izan dezakete:

```text
profesor
```

baina bakoitzak soilik bere esleitutako taldeetako kalifikazioak alda ditzake.

Beraz, honelako egiaztapen batek:

```php
if ($_SESSION['rol'] === 'profesor') {
    // baimendu
}
```

ez du nahikoa izan behar.

Baita ere egiaztatu behar da:

- erabiltzailea;
- baliabidea;
- eskaturiko ekintza.

arteko erlazioa.

## Baliabidearen gaineko baimenak

Demagun eskaera bat:

```text
POST /calificaciones/actualizar.php
```

honekin:

```text
alumno_id=152
nota=8.5
```

Zerbitzariak honakoak egiaztatu behar ditu:

1. erabiltzailea autentikatua dagoela;
2. rol egokia duela;
3. ikasle hori irakasle horren kudeatutako talde batean dagoela;
4. eskaturiko eragiketa baimenduta dagoela.

Kontzeptualki:

```text
Erabiltzaile autentikatua
        ↓
Rol egokia
        ↓
Baliabidera sarbidea
        ↓
Eragiketa baimendua
        ↓
Ekintza exekutatu
```

## Ez fidatu bezeroak bidalitako identifikatzaileei

Errore arrunta da identifikatzailea segurua dela uste izatea sareko esteka edo ezkutuko eremu batetik etortzen delako.

Adibidez:

```html
<input
    type="hidden"
    name="alumno_id"
    value="152"
>
```

Erabiltzaileak balio hau aldatu dezake eskaera bidali aurretik.

Beraz, zerbitzariak ez du `alumno_id=152` interpretatu behar erabiltzaileak baimena duela frogatutzat.

Aplikazioak kontrolatutako informazioaz egiaztatu behar du.

## Ezkutatu botoiak ez da baimenak

JavaScript-ek interfazean erabiltzailearen arabera aukera batzuk alda ditzake.

Adibidez:

```js
if (usuario.rol !== 'administrador') {
    botonEliminar.hidden = true;
}
```

Honek esperientzia hobetzen du, baina erabiltzaileak:

- JavaScript aldatu;
- botoia berriro erakutsi;
- eskaera eskuz eraiki;
- HTTP eskaera zuzenean bidali.

dezake.

Beraz:

> **Interfazean funtzio bat ezkutatzeak ez du exekutatzeko aukera kendu.**

Zerbitzariak beti egiaztatu behar du baimena.

## Erantzun kodeak

Erabiltzaile ez autentikatua denean normala da:

```text
401 Unauthorized
```

Erabiltzaile autentikatua bada baina eragiketarako baimena ez badu:

```text
403 Forbidden
```

## TxurdiGest-en adibidea

Demagun `12` identifikatzailea duen irakasle batek `152` ikaslearen nota aldatzea saiatzen dela.

Aplikazioak ez luke soilik honela egiaztatzen:

```php
$_SESSION['rol'] === 'profesor'
```

Baita ere honelako erlazio bat egiaztatu behar du:

```text
irakasle 12
    ↓
esleitutako taldea
    ↓
ikasle 152
```

Soilik erlazioa existitzen bada baimendu beharko litzateke kalifikazioa aldatzea.

## Baimenak eragiketa bakoitzean

Egiaztapenak babestutako eragiketa guztietan egin behar dira.

Adibidez:

```text
GET
↓
baliabidea kontsultatu
```

eta beste kasuetan:

```text
POST
↓
baliabidea aldatu
```

## Laburpena

- Baimenak erabilzailea identifikatu ondoren egiaztatzen dira eta ekintza exekutatu aurretik.
- Rolak ez dira beti nahikoa: eragiketa askok baliabide konkretuaren araberakoak dira.
- Autentikatutako identitatea saioaren barrutik lortu behar da.
- Bezeroak bidalitako datuak ez dute automatikoki baimenik frogatzen.
- Funtzio berrerabilgarriak baimenen politikak modu koherentean ezartzen laguntzen dute.
