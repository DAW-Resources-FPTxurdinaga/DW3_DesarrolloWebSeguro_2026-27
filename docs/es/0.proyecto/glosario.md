# Glosario

Este glosario recoge los términos principales utilizados en el módulo **Desarrollo Web Seguro**. Las definiciones están orientadas al desarrollo de aplicaciones web y al contexto de los retos del ciclo DAW.

## A

**API (Application Programming Interface)**  
Interfaz que permite que dos aplicaciones o componentes intercambien datos y operaciones. En aplicaciones web suele utilizar HTTP y formatos como JSON.

**Aplicación web**  
Software al que se accede normalmente mediante un navegador y que combina componentes de cliente, servidor y, habitualmente, una base de datos.

**Autenticación**  
Proceso mediante el que una aplicación comprueba la identidad de un usuario. Responde a la pregunta: **¿quién eres?**

**Autorización**  
Proceso mediante el que una aplicación decide qué acciones o recursos puede utilizar un usuario ya identificado. Responde a la pregunta: **¿qué puedes hacer?**

## B

**Backend**  
Parte de la aplicación que se ejecuta en el servidor. Gestiona lógica de negocio, validación, autenticación, autorización, acceso a datos y otras operaciones que no deben depender del navegador.

**Base de datos**  
Sistema utilizado para almacenar y consultar información persistente de la aplicación. Debe protegerse mediante credenciales adecuadas, mínimo privilegio y una exposición de red limitada.

**Burp Suite**  
Herramienta que permite observar, interceptar y modificar peticiones HTTP. En este módulo se utiliza para comprender y verificar el comportamiento de aplicaciones propias o laboratorios autorizados.

## C

**Cabecera HTTP**  
Información adicional incluida en una petición o respuesta HTTP. Puede describir el tipo de contenido, autenticación, cookies, origen, caché o políticas de seguridad.

**Cabecera de seguridad**  
Cabecera HTTP utilizada para indicar al navegador determinadas políticas de protección. Ejemplos habituales son `Content-Security-Policy`, `X-Content-Type-Options` o `Strict-Transport-Security`.

**Cadena de confianza**  
Relación mediante la que un navegador confía en un certificado digital porque ha sido emitido o validado por una Autoridad de Certificación reconocida.

**Certificado digital**  
Documento electrónico que vincula una identidad con una clave pública. En HTTPS permite autenticar al servidor y participar en el establecimiento de una comunicación cifrada.

**Checklist de seguridad**  
Lista de comprobaciones utilizada para revisar de forma sistemática los controles relevantes de una aplicación. Debe adaptarse al proyecto y no utilizarse como una lista mecánica de casillas.

**Código de estado HTTP**  
Número incluido en una respuesta HTTP que indica el resultado general de una petición. Algunos ejemplos son `200`, `400`, `401`, `403`, `404` o `500`.

**Configuración de producción**  
Conjunto de valores y decisiones utilizadas cuando la aplicación se ejecuta en el entorno real. Debe evitar opciones de depuración, secretos dentro del código y configuraciones propias del desarrollo.

**Content Security Policy (CSP)**  
Política enviada mediante la cabecera `Content-Security-Policy` que permite limitar qué recursos puede cargar o ejecutar el navegador.

**Cookie**  
Pequeño dato almacenado por el navegador y asociado a un sitio web. Puede utilizarse, entre otros fines, para mantener un identificador de sesión.

**CORS (Cross-Origin Resource Sharing)**  
Mecanismo basado en cabeceras HTTP que permite al servidor indicar qué orígenes pueden acceder a determinados recursos desde el navegador.

**Credencial**  
Dato utilizado para demostrar o comprobar una identidad, como un nombre de usuario, una contraseña, una clave o un token.

## D

**Datos de entrada**  
Información que una aplicación recibe desde formularios, URL, JSON, cabeceras, cookies, archivos u otras fuentes. Deben considerarse no confiables hasta que el servidor los valide.

**Depuración (debug)**  
Modo o información destinada a facilitar el desarrollo y diagnóstico de errores. En producción no debe exponer trazas, rutas, consultas, secretos u otros detalles internos.

**DevTools**  
Herramientas de desarrollo integradas en el navegador. Permiten observar peticiones HTTP, respuestas, cabeceras, cookies, almacenamiento, errores y comportamiento del cliente.

**DVWA (Damn Vulnerable Web Application)**  
Aplicación web deliberadamente vulnerable diseñada para aprendizaje y laboratorio. En el módulo se utiliza para observar vulnerabilidades y comprender su corrección en un entorno controlado.

## E

**Entorno**  
Contexto en el que se ejecuta una aplicación, por ejemplo desarrollo, pruebas o producción. La misma aplicación puede utilizar configuraciones diferentes según el entorno.

**Error controlado**  
Respuesta gestionada por la aplicación que informa al usuario sin revelar detalles técnicos innecesarios. El detalle necesario para diagnosticar el problema puede registrarse internamente.

**Escape de salida**  
Tratamiento aplicado a un dato antes de incorporarlo a un contexto de salida, como HTML, para evitar que se interprete como código cuando debe mostrarse como contenido.

**Evidencia de seguridad**  
Elemento que demuestra que un control se ha aplicado y funciona. Puede ser una petición y su respuesta, una captura, una configuración sin secretos, un resultado de prueba o un log anonimizado.

**Exposición**  
Grado en el que un servicio, recurso o componente puede ser alcanzado desde otros sistemas. Debe limitarse a aquello que sea realmente necesario.

## F

**Frontend**  
Parte de la aplicación que se ejecuta principalmente en el navegador y con la que interactúa el usuario. Puede mejorar la experiencia y realizar validaciones de interfaz, pero no debe asumir controles de seguridad que correspondan al servidor.

## H

**Hash de contraseña**  
Resultado de aplicar a una contraseña una función diseñada para almacenarla de forma no reversible. Las contraseñas no deben guardarse en texto plano.

**HttpOnly**  
Atributo de cookie que impide que JavaScript acceda directamente a su valor. Es especialmente relevante para cookies de sesión.

**HTTP (Hypertext Transfer Protocol)**  
Protocolo de comunicación utilizado para intercambiar peticiones y respuestas entre clientes y servidores web.

**HTTPS**  
Uso de HTTP sobre una conexión protegida mediante TLS. Proporciona confidencialidad, integridad y autenticación del servidor mediante certificados digitales.

**HSTS (HTTP Strict Transport Security)**  
Política indicada mediante la cabecera `Strict-Transport-Security` que ordena al navegador utilizar HTTPS para acceder al sitio durante un periodo determinado.

## I

**ID de recurso**  
Identificador utilizado para localizar un objeto de la aplicación, como `/reservas/25`. El servidor no debe asumir que un usuario está autorizado a acceder al recurso únicamente porque conozca o modifique su identificador.

**Inyección SQL (SQL Injection)**  
Vulnerabilidad que aparece cuando datos no confiables pueden modificar la estructura de una consulta SQL. Se previene, entre otras medidas, mediante consultas parametrizadas o preparadas.

## J

**JSON (JavaScript Object Notation)**  
Formato textual utilizado habitualmente para intercambiar datos entre aplicaciones y APIs web.

## L

**Log**  
Registro interno de eventos y errores generado por una aplicación o servidor. Debe facilitar el diagnóstico sin almacenar secretos u otra información sensible innecesaria.

## M

**Método HTTP**  
Operación indicada en una petición HTTP. Algunos métodos habituales son `GET`, `POST`, `PUT`, `PATCH` y `DELETE`.

**Mínimo privilegio**  
Principio según el cual un usuario, proceso o servicio debe disponer únicamente de los permisos necesarios para realizar su función.

## O

**Origen (origin)**  
Combinación de esquema, dominio y puerto desde la que se carga un recurso web. Es un concepto central en las políticas de mismo origen y en CORS.

## P

**Payload**  
Datos transportados en el cuerpo de una petición o respuesta. En DevTools se utiliza habitualmente este término para mostrar los datos enviados al servidor.

**Permiso**  
Autorización concreta para realizar una acción sobre una funcionalidad o recurso.

**Petición HTTP**  
Mensaje enviado por un cliente a un servidor para solicitar una operación o recurso. Contiene, entre otros elementos, método, URL, cabeceras y, cuando corresponde, un cuerpo.

**Prueba negativa**  
Prueba que comprueba que una acción inválida o no autorizada se rechaza correctamente. Por ejemplo, intentar acceder a un recurso de otro usuario.

**Prueba positiva**  
Prueba que comprueba que una operación válida funciona como se espera.

**Proxy**  
Componente intermedio entre un cliente y un servidor. Burp Proxy se utiliza para observar e interceptar tráfico HTTP entre el navegador y una aplicación.

## R

**Recurso**  
Elemento de la aplicación sobre el que se realiza una operación, como un usuario, una reserva, un pedido, un archivo o un endpoint.

**Respuesta HTTP**  
Mensaje que el servidor devuelve después de procesar una petición. Puede incluir código de estado, cabeceras y cuerpo.

**Revisión de código**  
Análisis sistemático del código para comprobar si los controles esperados están presentes, se aplican en el lugar correcto y no dependen de decisiones inseguras.

**Riesgo**  
Posibilidad de que una amenaza aproveche una debilidad y provoque un impacto sobre la aplicación, sus datos o sus usuarios.

**Rol**  
Agrupación de permisos asociada a un tipo de usuario o responsabilidad dentro de una aplicación.

## S

**SameSite**  
Atributo de cookie que controla en qué situaciones se envía una cookie en solicitudes iniciadas desde otros sitios.

**Sanitización**  
Transformación de datos para eliminar o modificar contenido no permitido. No debe confundirse con la validación ni utilizarse como sustituto automático del escape de salida.

**Secure**  
Atributo de cookie que indica que debe enviarse únicamente mediante conexiones HTTPS.

**Secreto**  
Información sensible necesaria para que una aplicación funcione, como contraseñas, claves API, claves privadas o credenciales de base de datos. No debe almacenarse dentro del código fuente.

**Sesión**  
Mecanismo utilizado para mantener estado entre distintas peticiones de un mismo usuario. Habitualmente el servidor conserva la información de sesión y el navegador mantiene un identificador.

**Superficie de exposición**  
Conjunto de puntos de una aplicación o infraestructura que pueden recibir conexiones, datos o interacciones y que, por tanto, deben ser revisados y protegidos.

## T

**TLS (Transport Layer Security)**  
Protocolo criptográfico utilizado por HTTPS para proteger la comunicación entre cliente y servidor.

## V

**Validación de entradas**  
Proceso que comprueba que los datos recibidos cumplen las reglas esperadas de tipo, formato, longitud, rango o contenido. La validación efectiva de seguridad debe realizarse en el servidor.

**Variable de entorno**  
Valor proporcionado al proceso de la aplicación desde su entorno de ejecución. Permite separar configuración y secretos del código fuente.

**Vulnerabilidad**  
Debilidad en el diseño, implementación o configuración que puede provocar un comportamiento inseguro o ser aprovechada para afectar a la aplicación.

## X

**XSS (Cross-Site Scripting)**  
Vulnerabilidad que permite que contenido no confiable termine interpretándose como código JavaScript en el navegador. Una contramedida fundamental es generar la salida de forma segura según su contexto.

## Idea clave

> El glosario sirve como referencia rápida. Los términos adquieren su significado completo cuando se aplican al diseño, implementación, despliegue y verificación de una aplicación web.
