# DVWA laborategia: XSS

Laborategi honetan **Cross-Site Scripting (XSS)**-ri aurre egiten dion inplementazio ahul bat aztertuko da, zein garapen-erabaki sortzen duen arazoa eta nola zuzendu behar den identifikatzeko.

Helburua ez da aplikazioak usteldu, baizik eta datu ez fidagarri batek nola bihur daitekeen kode exekutagarri irteera ez-seguru bat sortzen denean ulertzea.

## Eszenatokia

**DVWA (Damn Vulnerable Web Application)** erabiliko dugu lokalean eta ingurune kontrolatuan.

DVWA-ko XSS ariketetako bat landuko dugu.

## 1. Portaera normala behatu

Sartu lehenik balio arrunta XSS ariketan.

Adibidez:

```text
Ane
```

Ikusi nola agertzen den erantzunean.

## 2. Egiaztatu datua HTML gisa interpretatzen den

Sartu orain zati sinple bat:

```html
<strong>Proba</strong>
```

Ikusi emaitza.

## 3. JavaScript-en exekuzioa frogatu

DVWA-ko ingurune kontrolatuan proba minimo bat erabil daiteke:

```html
<script>alert('XSS')</script>
```

## 4. Arrazoia identifikatu

Arazoa ez da soilik `<` edo `>` karaktereak idazteko aukera izatea.

Arazoa aplikazioak irteera eraikitzen duen moduan dago.

## 5. Kode ahula berrikusi

Erabili DVWA-ko aukera kode-iturria ikusteko.

Bilatu non:

1. datua jasotzen den;
2. erantzunean sartzen den;
3. ez den escape egokirik aplikatzen.

## 6. Inplementazioa zuzendu

PHP-n irteera testu segurua sortzeko ohiko modua da:

```php
htmlspecialchars(
    $dato,
    ENT_QUOTES,
    'UTF-8'
);
```

Adibidez:

```php
$nombre = $_GET['name'] ?? '';

echo htmlspecialchars(
    $nombre,
    ENT_QUOTES,
    'UTF-8'
);
```

## 7. Proba errepikatu

Inplementazioa aztertu edo zuzendu ondoren:

1. berriro sartu testu normala;
2. probatu `<strong>Proba</strong>` zatia;
3. probatu XSS frogatzeko erabilitako zatia;
4. konparatu portaera.

## 8. JavaScript-era lotu

Printzipio bera nabigatzailean agertzen da JavaScript-ek DOM-a aldatzen duenean.

```js
elemento.innerHTML = datoUsuario;
```

Testua erakutsi nahi bada, hobesten da:

```js
elemento.textContent = datoUsuario;
```

## TxurdiGest-i aplikatzea

Demagun TxurdiGest-ek ikasleei buruzko oharriak sartzea onartzen duela.

Ohar normala izan daiteke:

```text
JavaScript programazio asincronikoa indartzea behar du.
```

Datu hau datu-basean gorde eta gero zuzenean inprimatzen bada:

```php
echo $observacion;
```

ohar manipulatua edozein erabiltzaileari eragin diezaioke.

## Zein gauza frogatu behar da

Laborategiaren amaieran argi egon behar da:

- XSS agertzen dela datu ez fidagarriak nabigatzailean kode gisa interpretatzen direnean;
- sarrera balidatzea ez dela irteera babestea ordezkatzen;
- arazoa inprimatu edo txertatu egiten den lerro bakar batean egon daitekeela;
- `htmlspecialchars()`-ek HTML testuinguru arrunt batean testua modu seguruan erakusteko aukera ematen duela;
- JavaScript-en, `textContent` hobesten dela `innerHTML`-ren ordez testua erakusteko;
- inplementazio bat zuzentu ondoren proba bera errepikatzea beharrezkoa dela.

