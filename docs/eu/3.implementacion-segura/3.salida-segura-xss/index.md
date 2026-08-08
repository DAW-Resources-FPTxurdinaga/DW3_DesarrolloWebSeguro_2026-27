# Irteera segurua eta XSS

Datuen sarrera behar bezala balidatzea ez da aplikazio bat segurua den ziurtatzen.

Datu bat aurreikusitako arau guztiak bete ditzake eta hala ere arriskutsua izan daiteke orrialde HTML batean sartzen bada, nabigatzaileak kode gisa interpretatzeko.

Arazo hau bereziki agertzen da aplikazio batek hurrengo iturrietatik datoak erakusten dituenean:

- formularioak;
- iruzkinak;
- erabiltzaile-profilak;
- URL parametroak;
- datu-baseak;
- APIak.

## Arazoa irteeran dago

Demagun aplikazio batek ikasle baten izena gorde ahal duela.

Jasotako datua izan daiteke:

```text
Ane
```

eta ondoren orrialde batean erakutsi:

```html
<p>Ane</p>
```

Ez dago arazoa.

Baina aplikazioak zuzenean HTML etiketa edo JavaScript kodea daukan balioa txertatzen badu, nabigatzaileak dokumentuaren parte gisa interpretatu ahal izango du.

Adibidez:

```html
<script>alert('XSS')</script>
```

Eduki hori tratatu gabe HTML sortuan sartzen bada, testu gisa ez bada ere, kode gisa exekutatu daiteke.

Arazo honen familiari **Cross-Site Scripting (XSS)** deritzo.

## Balidazioa eta ihes egitea ez dira eragiketa berdinak

Balidazioak galdera bati erantzuten dio:

> **Datu hau aplikazioaren arauak betetzen al ditu?**

Irteera segurua beste galdera bati erantzuten dio:

> **Nola sartu behar da datu hau dokumentuan informazio gisa interpretatzeko eta ez kode gisa?**

Adibidez, iruzkin batek karaktere hauek onartu ditzake:

```text
< >
" '
&
```

izan ere, testu baliozkoak dira.

Ez litzateke zuzena automatikoki karaktere horiek ezabatzea XSS saihesteko.

Soluzioa da **irteera kodetu edo ihes egin, erabiliko den testuinguruaren arabera**.

## Adibide kontzeptuala

Demagun erabiltzaile batek hau sartzen duela:

```text
<script>alert('Kaixo')</script>
```

Inplementazio ez-seguru batek honela sor lezake:

```html
<p>
    <script>alert('Kaixo')</script>
</p>
```

Nabigatzaileak `<script>` etiketa kode gisa interpretatzen du.

Irteera segurua lortu behar da edukia testu gisa tratatzea:

```text
<script>alert('Kaixo')</script>
```

exekutatu gabe.

## Non ager daitekeen

XSS ager daiteke datu ez fidagarriak honetarako erabiltzen direnean:

- HTML edukia;
- HTML atributuak;
- JavaScript kodea;
- URLak;
- DOM elementuak.

Babes-mekanismoa testuinguruaren araberakoa da.

Bloke honetan bereziki bi egoera arrunt landuko ditugu DAW-n:

- PHP-tik HTML sortzea;
- JavaScript-ek DOM-a aldatzea.

## PHP eta JavaScript

PHP-n garrantzitsua da datu ez fidagarriak zuzenean inprimatzea saihestea.

Adibidez:

```php
echo $comentario;
```

arriskutsua izan daiteke `$comentario`-k nabigatzaileak interpretatu dezakeen edukia badu.

JavaScript-en ere garrantzitsua da datu bat DOM-era nola sartzen den.

Ez da berdina erabiltzea:

```js
elemento.innerHTML = dato;
```

eta:

```js
elemento.textContent = dato;
```

Bi kasuetan arazo bera dago:

> **datu bat datu gisa jarraitzea behar da eta ez daiteke akzidentalki kode exekutagarri bihurtu.**

## TxurdiGest-en adibidea

Demagun TxurdiGest-ek irakasle bati ikasleari buruzko ohar bat idazteko aukera ematen dion.

```text
JavaScript-a indartzea behar du.
```

Aplikazioak informazio hori gordetzen du eta gero erakusten du.

Eduki hori zuzenean HTML gisa txertatzen bada, manipulatutako balio batek orria aldatu edo beste erabiltzaile baten nabigatzailean kodea exekutatu ahal izango du.

Babesa aplikazioak irteera sortzen den unean ezarri behar da.

## Atalak

Gai honetan honakoak landuko ditugu:

- [Inplementazioa](implementacion.md): irteera segurua PHP-n eta DOM-a modu seguruan manipulatzea JavaScript-ekin.
- [DVWA laborategia](laboratorio-dvwa.md): inplementazio ahul baten behaketa, arrazoiaren identifikazioa eta arazoaren zuzenketa.

## Laburpena

- Sarrera balidatzea eta irteera babestea ez dira lan berdinak.
- XSS agertzen da datu ez fidagarriak nabigatzailean kode gisa interpretatzen direnean.
- Babesa erabiliko den testuinguruaren arabera egokitu behar da.
- PHP eta JavaScript-ek datuak eta kodea bereizteko mekanismoak eskaintzen dituzte.
