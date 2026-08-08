# Autentifikazioa eta saioak inplementatzea

Autentifikazioaren inplementazioak segurtasun-erabakiak zerbitzarian kontzentratzea behar du.

Nabigatzaileak kredentzialak bidaltzen ditu, baina PHP-k izan behar du:

1. jasotako datuak balidatzea;
2. erabiltzailea lokalizatzea;
3. pasahitza egiaztatzea;
4. saioa sortzea;
5. erabiltzailea petizio geroagokoetan identifikatzea;
6. saioa suntsitzea amaitzen denean.

## Erabiltzaile-erregistroa

Kontu bat sortzean, pasahitza ez da zuzenean gorde behar. Inplementazio oker batek pasahitza testu gisa gorde lezake, eta horrek eskuragarri jartzen du datu-basean.

## Hash bat sortu `password_hash()`-rekin

PHP-k `password_hash()` eskaintzen du pasahitzak gordetzeko forma egokia sortzeko.

```php
$password = $_POST['password'] ?? '';

$hash = password_hash(
    $password,
    PASSWORD_DEFAULT
);
```

Ondoren `$hash` gorde behar da:

```php
$sql = "
    INSERT INTO usuarios (email, password_hash)
    VALUES (:email, :password_hash)
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'email' => $email,
    'password_hash' => $hash
]);
```

## Saioa hasteko prozesua

Demagun inprimaki hau:

```html
<form method="post" action="login.php">
    <label for="email">Posta elektronikoa</label>
    <input
        type="email"
        id="email"
        name="email"
        required
    >

    <label for="password">Pasahitza</label>
    <input
        type="password"
        id="password"
        name="password"
        required
    >

    <button type="submit">Sartu</button>
</form>
```

PHP-k datuak jasotzen eta balidatzen ditu. Ondoren erabiltzailea bilatzen da, pasahitza egiaztatzen da eta saioa hasieratzen da.

```php
$email = trim($_POST['email'] ?? '');
$password = $_POST['password'] ?? '';

if (
    !filter_var($email, FILTER_VALIDATE_EMAIL) ||
    $password === ''
) {
    http_response_code(422);
    exit('Kredentzialak ez dira baliozkoak.');
}
```

## Erabiltzailea bilatu kontsulta prestatu baten bidez

```php
$sql = "
    SELECT id, email, password_hash, rol
    FROM usuarios
    WHERE email = :email
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'email' => $email
]);

$usuario = $stmt->fetch();
```

## Pasahitza egiaztatu

Ez da pasahitza hasharekin `===` bidez konparatzen. Erabili:

```php
password_verify(
    $password,
    $usuario['password_hash']
);
```

## Saio-cookie-a konfiguratu

Saioa hasi baino lehen, bere parametroak definitu behar dira.

```php
session_set_cookie_params([
    'httponly' => true,
    'secure' => true,
    'samesite' => 'Lax'
]);

session_start();
```

### `HttpOnly`

`HttpOnly`-k saioa JavaScript bidez ez duela atzitzeko aukera ematen du.

### `Secure`

`Secure`-k cookiea HTTPS bidez soilik bidali behar dela adierazten du.

### `SameSite`

`SameSite=Lax`-ek cookiearen bidalketa mugatzen du beste webgune batzuetan.

## Saioa sortu login-aren ondoren

Kredentzialak zuzenak direnean:

```php
session_regenerate_id(true);

$_SESSION['usuario_id'] = $usuario['id'];
$_SESSION['rol'] = $usuario['rol'];
```

## Zer gorde `$_SESSION`-ean

Soilik beharrezkoa den informazioa gorde behar da:

```php
$_SESSION['usuario_id'] = $usuario['id'];
```

eta beharrezkoa bada:

```php
$_SESSION['rol'] = $usuario['rol'];
```

## Orrialde babestu

Autentikazioa behar duen orrialde batean saioa egiaztatu daiteke.

```php
session_start();

if (!isset($_SESSION['usuario_id'])) {
    http_response_code(401);
    exit('Saioa hasi behar duzu.');
}
```

## Saioa ixtea

Saioa ixteko datuak ezabatu behar dira:

```php
$_SESSION = [];
```

Ondoren saio-cookie-a ezabatu eta amaieran saioa suntsitu:

```php
if (ini_get('session.use_cookies')) {
    $params = session_get_cookie_params();

    setcookie(
        session_name(),
        '',
        time() - 42000,
        $params['path'],
        $params['domain'],
        $params['secure'],
        $params['httponly']
    );
}

session_destroy();
```

## Ez erabili bezeroaren datuak identitatea erabakitzeko

Identitatea saioaren barrutik lortu behar da, ez nabigatzaileak bidalitako eremuetatik.

## Praktika onak

- Ez gordetu pasahitzik testu lauan.
- Erabili `password_hash()` hashak sortzeko.
- Erabili `password_verify()` pasahitzak egiaztatzeko.
- Konfiguratu behar bezala saio-cookie-a.
- Erabili HTTPS `Secure` erabiltzen denean.
- Birsortu saio-identifikatzailea erabiltzailea autentikatzen denean.
- Lortu identitatea `$_SESSION`-etik, ez bezeroak kontrolatutako datuetatik.
- Babestu zerbitzarian orrialde eta eragiketa guztiak.
- Suntsitu saioa logout-ean.
- Ez nahastu autentifikazioa baimenekin.

## Laburpena

- Kredentzialak beti zerbitzarian egiaztatzen dira.
- Pasahitzak hash espezifikoekin gordetzen dira.
- Saioak identitatea mantentzen du eskaeren artean.
- `session_regenerate_id(true)` erabili behar da saio autentikatua ezartzen denean.
- `Secure`, `HttpOnly` eta `SameSite` saio-cookie-a babesten laguntzen dute.
- Identitatea `$_SESSION`-etik lortu behar da, ez bezeroaren kontrolpeko datuetatik.
