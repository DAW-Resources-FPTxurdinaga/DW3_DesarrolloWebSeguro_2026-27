# Balidazioa JavaScript-en

JavaScript bidezko balidazioak erroreak bidalketa baino lehen detektatzeko aukera ematen du.

Bere funtzio nagusia erabiltzailearen esperientzia hobetzea da:

- eremu hutsak jakinaraztea;
- formatuak egiaztatzea;
- barrutiak balioztatzea;
- mezuak berehala erakustea;
- eskaera ez-necessaryak saihestea.

Hala ere, **ez da bakarrik segurtasun-mekanismo gisa erabili behar**.

## HTML5 balidazioa

JavaScript idatzi baino lehen, HTMLk eskaintzen dituen balidazio aukerak aprobetxatu behar dira.

```html
<form id="formAlumno">
    <label for="email">Posta elektronikoa</label>
    <input
        type="email"
        id="email"
        name="email"
        required
    >

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

Formularioko nabigatzaileak honakoak egiaztatu ditzake:

- derrigorrezko eremuak beteta daudela;
- posta elektronikoa `type="email"`-rekin bateragarria dela;
- nota zenbakia dela;
- `0` eta `10` artean egon behar duela.

## JavaScript bidezko balidazio gehigarria

JavaScript-ek arau zehatzagoak ezartzeko aukera ematen du.

```js
const formulario = document.querySelector('#formAlumno');

formulario.addEventListener('submit', (event) => {
    const nota = Number(document.querySelector('#nota').value);

    if (nota < 0 || nota > 10) {
        event.preventDefault();
        alert('Notak 0 eta 10 artean egon behar du.');
    }
});
```

## Mezuak eremuan bertan erakutsi

Aplikazio erreal batean hobeto da errorea datuari gertuko tokian erakustea.

```html
<label for="email">Posta elektronikoa</label>
<input type="email" id="email" name="email">
<p id="errorEmail"></p>
```

```js
const email = document.querySelector('#email');
const errorEmail = document.querySelector('#errorEmail');

email.addEventListener('blur', () => {
    if (!email.value.includes('@')) {
        errorEmail.textContent = 'Sartu posta elektroniko baliagarri bat.';
        return;
    }

    errorEmail.textContent = '';
});
```

## Ez fidatu ezkutuko edo desgaitutako balioei

Errore arrunta da interfazean erabiltzaileak ezin dituela aldatu uste izatea.

```html
<input type="hidden" name="rol" value="ikaslea">
```

o:

```html
<input type="text" name="prezioa" value="25" disabled>
```

Balio hauek nabigatzaileak erakusten ditu, baina erabiltzaileak HTML-a aldatu, eskaera berria eraiki edo tresna ezberdinen bidez bidali dezake.

!!! warning "Ezkutuko eremua ez da datu babestua"

    `hidden`, `readonly` edo `disabled` interfazeari kontrolatzen diote, ez aplikazioaren segurtasunari.

## Laburpena

- JavaScript bidezko balidazioak erabiltzailearen esperientzia hobetzen du.
- Nabigatzailea erabiltzailearen kontrolpean dago.
- Edozein eskaera aldatu edo eraiki daiteke interfazeetatik kanpo.
- JavaScript-ek ez du inoiz zerbitzariaren balidazioa ordezkatzen.
