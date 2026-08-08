# Laborategia: bezeroan egindako balidazioaren mugak aztertzea

Laborategi honetan bezeroan soilik egindako balidazioa saihestu daitekeela frogatuko da, eta zerbitzariak berriro egiaztatu behar duela erakutsiko da.

Ideia ez da aplikazioa usteldua izatea, baizik eta segurtasun-garapen oinarrizko erabakia egiaztatzea:

> **Bezeroak erabiltzaileari lagun dezake, baina zerbitzariak erabaki behar du datua baliozkoa den.**

## Eszenatokia

Formulario sinple bat erabiliko dugu nota bat sartzeko.

Nabigatzaileak balioa `0` eta `10` artean mugatuko du.

```html
<form method="post" action="guardar-nota.php">
    <label for="nota">Nota</label>

    <input
        type="number"
        id="nota"
        name="nota"
        min="0"
        max="10"
        step="0.1"
        required
    >

    <button type="submit">Gorde</button>
</form>
```

JavaScript-arekin egiaztapen bat ere gehi dezakegu:

```js
const formulario = document.querySelector('form');

formulario.addEventListener('submit', (event) => {
    const nota = Number(document.querySelector('#nota').value);

    if (nota < 0 || nota > 10) {
        event.preventDefault();
        alert('Notak 0 eta 10 artean egon behar du.');
    }
});
```

Inplementazio honekin interfazeak normalean ez du `25` bezalako nota bidaltzen uzten.

## Lehen egiaztapena

Probatu formularioa nabigatzailean.

Sartu balio desberdinak:

```text
8
9.5
-1
25
```

Ikusi zein onartzen dituen interfazea eta zein baztertu.

## Eskaera atzematea

Aktibatu Burp Suite nabigatzailearen proxy gisa eta atzitu nota baliozkoa bidaltzeko eskaera.

Adibidez:

```text
nota=8
```

Eskaerak antzeko lerro bat eduki dezake:

```http
POST /guardar-nota.php HTTP/1.1
Content-Type: application/x-www-form-urlencoded

nota=8
```

Eskaera berriro bidali aurretik, balioa alda dezakezu:

```text
nota=25
```

eta eskaera zerbitzarira jarraitzen utzi.

## Inplementazio ahula

Demagun `guardar-nota.php`-k zuzenean jasotako datua erabiltzen duela:

```php
$nota = $_POST['nota'];

guardarNota($nota);
```

Zerbitzariak nabigatzaileak balidatu duela fidatzen ari da.

Hori ez da zuzena.

## Inplementazioa zuzendu

Zerbitzariak berriro balidatu behar du datua.

```php
$nota = filter_input(
    INPUT_POST,
    'nota',
    FILTER_VALIDATE_FLOAT
);

if ($nota === false || $nota === null) {
    http_response_code(422);
    exit('Nota zenbaki bat izan behar da.');
}

if ($nota < 0 || $nota > 10) {
    http_response_code(422);
    exit('Notak 0 eta 10 artean egon behar du.');
}

guardarNota($nota);
```

Orain errepikatu proba berdina: nota baliogarri bat sartu, eskaera atzeman, balioa `25`-ra aldatu eta berriro bidali.

Zerbitzariak baztertu behar du.

## Laburpena

- HTML mugak saihestu daitezke.
- JavaScript aldatu edo ez exekutatu daiteke.
- HTTP eskaera aldatu daiteke zerbitzaria iritsi aurretik.
- Zerbitzaria ezin du bezeroak balidatu duela fidatu.
- PHPk arau beharrezkoak aplikatu behar ditu datuak prozesatu aurretik.
