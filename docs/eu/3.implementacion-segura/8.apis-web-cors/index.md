# Web APIak eta CORS

Aplikazio modernoak sarritan bezeroa eta zerbitzaria APIen bidez bereizten dituzte.

JavaScript, Vue, Axios edo `fetch()`-ek HTTP eskaerak bidal ditzakete endpoint batzuetara, JSON bezalako formatuetan datuak itzuliz.

Segurtasunari begira, API batek edozein aplikazio osatzen duten printzipio berberak aplikatu behar ditu:

- sarrerak balidatu;
- erabiltzaileak autentikatu;
- eragiketak baimendu;
- datuen sarbidea babestu;
- esposatutako informazioa mugatu;
- baimendutako jatorriak behar bezala kudeatu.

## API batek ez du bere bezeroari fidatzen

Errore arrunta da eskaera fidagarria dela pentsatzea gure JavaScript edo Vue aplikazioaren bidez sortu delako.

Zerbitzaria ez du jakin eskaera zehazki kode horren bidez sortu den.

Baliteke:

- aldatuta egotea;
- eskuz eraikitzea;
- beste tresna batetik bidaltzea;
- beste bezero batetik bidaltzea.

Beraz, endpoint-ak berriro aplikatu behar ditu beharrezko egiaztapen guztiak.

## Segurtasuna endpoint bakoitzean

Endpoint bakoitzak honakoak erabaki behar ditu:

```text
Nor da eskaera egiten duena?
        ↓
Autentikatua dago?
        ↓
Eragiketa hau egin dezake?
        ↓
Datuak baliozkoak dira?
        ↓
Baliabide honetara sarbidea du?
        ↓
Eragiketa exekutatu
```

Adibidez:

```text
PATCH /api/alumnos/152/nota
```

ezkutuan ez luke datu-basea zuzenean aldatu behar:

```json
{
    "nota": 8.5
}
```

Zerbitzariak identitatea eta baimenak ere egiaztatu behar ditu.

## Ez ezagutu beharrezkoa baino datu gehiago

API batek bezeroari soilik beharrezkoa den informazioa itzuli behar dio.

Adibidez, erantzuna honela izan liteke:

```json
{
    "id": 152,
    "nombre": "Ane",
    "email": "ane@example.com"
}
```

Ez luke gabe beharrezko barne-eremuak erabili behar, esaterako:

```json
{
    "password_hash": "...",
    "token_interno": "...",
    "ruta_servidor": "/var/www/app/..."
}
```

Nahiz eta bezeroak datu horiek pantailan ez erakutsi, HTTP erantzunean daude.

> **Interfazean datu bat ezkutatzeak ez du esan nahi nabigatzaileak ez duela jasotzen.**

## HTTP kodeak

API batek operazioaren emaitzarekin bat datozen HTTP kodeak erabili behar ditu.

| Kodea | Ehuneko esanahia |
|---|---|
| `200` | Eragiketa zuzena |
| `201` | Baliabidea sortua |
| `400` | Eskaera okerra |
| `401` | Erabiltzailea ez da autentikatua |
| `403` | Erabiltzailea autentikatua baina ez du baimenik |
| `404` | Baliabidea ez da aurkitu |
| `422` | Jasotako datuak ez dira baliozkoak |
| `500` | Zerbitzariaren barne-errorea |

Erantzun-kodea bezeroaren eta zerbitzariaren arteko interfeisaren parte da.

## Zer da CORS

**CORS (Cross-Origin Resource Sharing)** nabigatzaileek erabiltzen duten mekanismoa da jatorri ezberdinetako eskaerak kontrolatzeko.

Jatorri bat honako konbinazioaren bidez definitzen da:

```text
protokoloa + ostalaria + ataka
```

Adibidez:

```text
https://app.ejemplo.com
```

eta:

```text
https://api.ejemplo.com
```

jatorri ezberdinak dira, ostalaria ez delako bera.

## Laburpena

- API segurua balidazioa, autentifikazioa eta baimenak zerbitzarian aplikatzen ditu.
- Frontend-ek ez du eskaeraren legitimotasuna frogatzen.
- Erantzunak informazio esposeduna mugatu behar dute.
- CORS-ek zein jatorritako nabigatzaileak erantzuna erabil dezakeen definitzen du.
- Kredentzialekin, jatorria esplizituki konfiguratu behar da.
- Endpoint-aren segurtasuna CORS-ek ez du determinatzen.
