# Irteera segurua inplementatzea

XSS-en aurkako babesak datu ez fidagarriak nabigatzailean kode gisa interpretatzen ez direla saihestea dakar.

Erregela orokorra sinplea da:

> **Datuak datu gisa tratatu behar dira, ez HTML edo JavaScript zati gisa.**

## Irteera segurua PHP-n

Inplementazio ez-seguru batek balio bat zuzenean inprimatu dezake:

```php
$comentario = $_POST['comentario'] ?? '';

echo $comentario;
```

Balio honek HTML edukia badu, nabigatzaileak interpretatu dezake.

Adibidez:

```html
<script>alert('XSS')</script>
```

Hori kode exekutagarri bihur daiteke orrian.

## HTML ihes egitea `htmlspecialchars()`-rekin

Datu bat HTML barruan testu gisa erakutsi behar denean, PHP-k `htmlspecialchars()` eskaintzen du.

```php
$comentario = $_POST['comentario'] ?? '';

echo htmlspecialchars(
    $comentario,
    ENT_QUOTES,
    'UTF-8'
);
```

Funtzio honek karaktere bereziak aldatzen ditu, nabigatzaileak testu gisa tratatzeko.

## Irteera sortzen den unean ihes egitea

Gomendatutako praktika da jatorrizko datua mantentzea eta HTML-era txertatzen den unean ihes egitea.

```php
$nombre = $usuario['nombre'];

echo '<p>' .
    htmlspecialchars($nombre, ENT_QUOTES, 'UTF-8') .
    '</p>';
```

## PHP plantillak adibidearekin

HTML barruan zuzenean erabili daiteke:

```php
<p>
    <?= htmlspecialchars(
        $usuario['nombre'],
        ENT_QUOTES,
        'UTF-8'
    ) ?>
</p>
```

## Ez erabili `strip_tags()` babes orokor gisa

Errazagoa izan daiteke HTML etiketak ezabatzea, baina ez du ordezkatzen testuinguruaren arabera ihes egitea.

## Testuinguru desberdinak

Ez dira berdin babesten orri baten leku guztiak.

Datu bat honetako batean erabil daiteke:

- HTML edukia;
- atributu bat;
- URL bat;
- JavaScript;
- CSS.

## JavaScript eta DOM

JavaScript-ek datuak orri batean hainbat modutan sartu ditzake.

Garrantzitsuena `innerHTML` eta `textContent` arteko aldea da.

### `innerHTML`

```js
const comentario = '<strong>Kaixo</strong>';

elemento.innerHTML = comentario;
```

Nabigatzaileak edukia HTML gisa interpretatzen du.

### `textContent`

```js
elemento.textContent = datoUsuario;
```

Datu hau testu gisa erakutsi nahi bada, hobesten da.

## Sortu elementuak modu seguruan

Kateen bidez HTML zatiak eraikitzea saihesteko, DOM-a erabiliz sortu daitezke elementuak:

```js
const li = document.createElement('li');

li.textContent = nombreUsuario;

lista.appendChild(li);
```

## TxurdiGest-en adibidea

Demagun irakasle batek ohar bat gordetzen duela. Aplikazioak testu hau gorde eta modu egokian erakutsi behar du.

PHP-n:

```php
<p>
    <?= htmlspecialchars(
        $observacion,
        ENT_QUOTES,
        'UTF-8'
    ) ?>
</p>
```

JavaScript-en:

```js
observacionElemento.textContent = observacion;
```

## `innerHTML` erabil daitekeen noiz?

`innerHTML` ez da berez ez-segurua. Erabili daiteke HTML edukia aplikazioak guztiz kontrolatzen duenean.

## Ez fidatu datu biltegiratuak

Errore arrunta da datu bat segurua dela pentsatzea datu-basean datorrenagatik.

## XSS reflejadoa eta gordea

Bi egoera arrunt bereiz daitezke.

### XSS reflejadoa

Datuak eskaera baten bidez iristen dira eta berehala itzultzen dira.

### XSS gordea

Datuak lehenengo gordetzen dira eta gero erakusten dira.

## Praktika onak

- Ihes egin datuak HTML-era txertatzen direnean.
- Erabili `htmlspecialchars()` PHP-n testua erakusteko.
- Erabili `textContent` JavaScript-en testua erakusteko.
- Saihestu datu ez fidagarriak kateekin konbinatzea.
- Erabili `createElement()` eta `createTextNode()` beharrezkoa denean.
- Ez uste datu bat segurua dela datu-basean dagoelako.
- Egokitu babesa erabiltzen den testuinguruaren arabera.

## Laburpena

- XSS agertzen da datu bat nabigatzailean kode gisa interpretatzen denean.
- PHP-n, `htmlspecialchars()` irteera segurua sortzen laguntzen du HTML testuinguruan.
- JavaScript-en, `textContent` edukia HTML gisa interpretatzea saihesten du.
- `innerHTML` arreta berezia behar du datu kanpotarrak parte hartzen dutenean.
