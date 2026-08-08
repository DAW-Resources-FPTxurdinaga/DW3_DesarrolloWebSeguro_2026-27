# Laboratorio DVWA: SQL Injection

En este laboratorio se analizará una implementación vulnerable a **SQL Injection** para identificar cómo una consulta construida mediante concatenación puede ser modificada por los datos recibidos.

El objetivo no es aprender técnicas de explotación, sino comprender una decisión básica de desarrollo seguro:

> **Los datos nunca deben formar parte de la estructura de una consulta SQL.**

## Escenario

Utilizaremos **DVWA (Damn Vulnerable Web Application)** en un entorno local y controlado.

Trabajaremos con el ejercicio de SQL Injection disponible en DVWA.

La secuencia será:

```text
Dato recibido
   ↓
Concatenación dentro de SQL
   ↓
Consulta modificada
   ↓
Comportamiento no previsto
```

## 1. Observar el comportamiento normal

Accede al ejercicio de SQL Injection e introduce primero un identificador válido.

Por ejemplo:

```text
1
```

Observa la respuesta obtenida.

La aplicación utiliza ese valor para construir una consulta a la base de datos.

Conceptualmente, puede estar ejecutando algo similar a:

```php
$id = $_GET['id'] ?? '';

$sql = "
    SELECT first_name, last_name
    FROM users
    WHERE user_id = '$id'
";
```

Con un valor normal, la consulta funciona aparentemente de forma correcta.

## 2. Analizar la construcción de la consulta

El problema está en esta operación:

```php
WHERE user_id = '$id'
```

El valor recibido se incorpora directamente dentro de la cadena SQL.

Esto mezcla:

```text
Instrucción SQL
+
Dato externo
```

La base de datos no recibe ambos elementos de forma separada.

Por tanto, determinados caracteres incluidos en el dato pueden alterar la estructura de la consulta.

## 3. Comprobar que la consulta puede alterarse

En el entorno controlado de DVWA puede utilizarse una entrada mínima que permita observar que el valor recibido no se trata únicamente como un dato.

Por ejemplo, en el ejercicio preparado para ello, puede comprobarse el comportamiento con una condición manipulada del tipo:

```text
1' OR '1'='1
```

No es necesario memorizar esta cadena.

Lo importante es comprender qué ocurre cuando se concatena dentro de una consulta:

```sql
SELECT first_name, last_name
FROM users
WHERE user_id = '1' OR '1'='1'
```

La segunda condición resulta verdadera, por lo que la consulta deja de representar la intención original de la aplicación.

!!! warning "Entorno controlado"

    Estas pruebas deben realizarse únicamente sobre DVWA u otras aplicaciones preparadas expresamente para prácticas de seguridad.

## 4. Identificar la causa real

La vulnerabilidad no aparece porque SQL sea inseguro.

Tampoco aparece simplemente porque el usuario haya introducido una comilla.

La causa está en la forma en que el código construye la consulta:

```php
$sql = "SELECT ... WHERE user_id = '$id'";
```

El programa permite que un dato externo se convierta en parte de la sintaxis SQL.

La decisión insegura puede resumirse así:

```text
Dato no confiable
        ↓
Concatenación
        ↓
Instrucción SQL
```

## 5. Revisar el código vulnerable

Utiliza la opción de DVWA para visualizar el código fuente del ejercicio.

Localiza:

1. dónde se obtiene el dato;
2. dónde se construye la consulta;
3. dónde se concatena el valor;
4. dónde se ejecuta la consulta.

No es necesario estudiar todo el código de DVWA.

La pregunta importante es:

> **¿Qué línea permite que un valor recibido modifique la consulta SQL?**

## 6. Corregir mediante una consulta preparada

Con PDO, una implementación segura puede escribirse de esta forma:

```php
$id = filter_input(
    INPUT_GET,
    'id',
    FILTER_VALIDATE_INT
);

if ($id === false || $id === null) {
    http_response_code(400);
    exit('Identificador no válido.');
}
```

Después se define la consulta utilizando un parámetro:

```php
$sql = "
    SELECT first_name, last_name
    FROM users
    WHERE user_id = :id
";
```

Se prepara:

```php
$stmt = $pdo->prepare($sql);
```

Y el dato se proporciona por separado:

```php
$stmt->execute([
    'id' => $id
]);
```

La estructura SQL ya no depende del contenido del valor recibido.

## 7. Comparar ambos modelos

### Implementación vulnerable

```php
$sql = "
    SELECT *
    FROM users
    WHERE user_id = '$id'
";
```

Flujo:

```text
Dato
  ↓
concatenación
  ↓
SQL
  ↓
el dato puede modificar la consulta
```

### Implementación segura

```php
$sql = "
    SELECT *
    FROM users
    WHERE user_id = :id
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'id' => $id
]);
```

Flujo:

```text
SQL definido
      ↓
prepare()
      ↓
dato enviado como parámetro
      ↓
execute()
```

Código y datos permanecen separados.

## 8. Validación y parametrización

Conviene observar que en el ejemplo seguro aparecen dos controles:

```php
$id = filter_input(
    INPUT_GET,
    'id',
    FILTER_VALIDATE_INT
);
```

y:

```php
$stmt->execute([
    'id' => $id
]);
```

Cumplen funciones diferentes.

La validación responde:

> ¿Es este identificador válido para la aplicación?

La consulta preparada responde:

> ¿Puede este valor modificar la estructura SQL?

Una medida no sustituye a la otra.

## 9. Repetir la prueba

Después de analizar o implementar la versión segura:

1. realiza una consulta con un identificador válido;
2. comprueba que sigue funcionando;
3. repite la entrada utilizada para observar la vulnerabilidad;
4. comprueba que ya no puede modificar la consulta.

El resultado esperado es:

```text
ANTES

Entrada
   ↓
concatenación
   ↓
SQL modificado
```

frente a:

```text
DESPUÉS

Entrada
   ↓
validación
   ↓
parámetro
   ↓
SQL intacto
```

## Aplicación a TxurdiGest

Supongamos que TxurdiGest consulta un alumno mediante:

```text
/alumnos.php?id=152
```

Una implementación incorrecta sería:

```php
$id = $_GET['id'];

$sql = "
    SELECT *
    FROM alumnos
    WHERE id = $id
";
```

La implementación debería validar primero el identificador:

```php
$id = filter_input(
    INPUT_GET,
    'id',
    FILTER_VALIDATE_INT
);
```

y utilizar después una consulta preparada:

```php
$sql = "
    SELECT *
    FROM alumnos
    WHERE id = :id
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    'id' => $id
]);
```

El mismo principio debe aplicarse a operaciones como:

- buscar alumnos;
- consultar grupos;
- insertar calificaciones;
- modificar datos;
- eliminar registros.

## Qué debe quedar demostrado

Al finalizar el laboratorio debe quedar claro que:

- SQL Injection aparece cuando los datos pueden modificar la estructura de una consulta;
- concatenar entradas dentro de SQL es una decisión de implementación insegura;
- validar un dato no sustituye a parametrizar la consulta;
- las consultas preparadas separan instrucciones y valores;
- `prepare()` y `execute()` deben utilizarse de forma sistemática;
- después de corregir una implementación hay que repetir la misma prueba para verificar el resultado.
