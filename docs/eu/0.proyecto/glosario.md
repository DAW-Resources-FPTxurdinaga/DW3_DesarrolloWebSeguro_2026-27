# Glosarioa

Glosario honek **Web Garapen Segurua** moduluan erabiltzen diren termino nagusiak biltzen ditu. Definizioak web-aplikazioen garapenera eta DAW zikloko erronken testuingurura bideratuta daude.

## A

**API (Application Programming Interface)**  
Bi aplikazio edo osagairen artean datuak eta eragiketak trukatzea ahalbidetzen duen interfazea. Web-aplikazioetan HTTP eta JSON bezalako formatuak erabili ohi ditu.

**Web-aplikazioa**  
Normalean nabigatzaile baten bidez erabiltzen den softwarea, bezeroaren, zerbitzariaren eta, ohikoa denez, datu-base baten osagaiak konbinatzen dituena.

**Autentifikazioa**  
Aplikazio batek erabiltzaile baten identitatea egiaztatzeko erabiltzen duen prozesua. Galdera honi erantzuten dio: **nor zara?**

**Baimena**  
Identifikatutako erabiltzaile batek zer ekintza edo baliabide erabil ditzakeen erabakitzeko prozesua. Galdera honi erantzuten dio: **zer egin dezakezu?**

## B

**Backend**  
Zerbitzarian exekutatzen den aplikazioaren zatia. Negozio-logika, baliozkotzea, autentifikazioa, baimena, datuetarako sarbidea eta nabigatzailearen mende egon behar ez duten beste eragiketa batzuk kudeatzen ditu.

**Datu-basea**  
Aplikazioaren informazio iraunkorra gordetzeko eta kontsultatzeko erabiltzen den sistema. Kredentzial egokien, pribilegio minimoaren eta sareko esposizio mugatuaren bidez babestu behar da.

**Burp Suite**  
HTTP eskaerak behatu, atzeman eta aldatzea ahalbidetzen duen tresna. Modulu honetan norberaren aplikazioen edo baimendutako laborategien portaera ulertzeko eta egiaztatzeko erabiltzen da.

## C

**HTTP goiburua**  
HTTP eskaera edo erantzun batean sartzen den informazio osagarria. Eduki mota, autentifikazioa, cookieak, jatorria, cachea edo segurtasun-politikak deskriba ditzake.

**Segurtasun-goiburua**  
Nabigatzaileari babes-politika jakin batzuk adierazteko erabiltzen den HTTP goiburua. Ohiko adibideak dira `Content-Security-Policy`, `X-Content-Type-Options` eta `Strict-Transport-Security`.

**Konfiantza-katea**  
Nabigatzaile batek ziurtagiri digital batean konfiantza izatea ahalbidetzen duen erlazioa, ziurtagiria aitortutako Ziurtapen Agintaritza batek jaulki edo baliozkotu duelako.

**Ziurtagiri digitala**  
Identitate bat gako publiko batekin lotzen duen dokumentu elektronikoa. HTTPSn zerbitzaria autentifikatzeko eta komunikazio zifratu bat ezartzen laguntzeko erabiltzen da.

**Segurtasun-checklista**  
Aplikazio baten kontrol garrantzitsuak sistematikoki berrikusteko erabiltzen den egiaztapen-zerrenda. Proiektura egokitu behar da eta ez da laukiak mekanikoki markatzeko zerrenda gisa erabili behar.

**HTTP egoera-kodea**  
HTTP erantzun batean sartzen den zenbakia, eskaeraren emaitza orokorra adierazten duena. Adibide batzuk dira `200`, `400`, `401`, `403`, `404` eta `500`.

**Produkzioko konfigurazioa**  
Aplikazioa benetako ingurunean exekutatzen denean erabiltzen diren balio eta erabakien multzoa. Arazketa-aukerak, kodearen barruko sekretuak eta garapeneko konfigurazioak saihestu behar ditu.

**Content Security Policy (CSP)**  
`Content-Security-Policy` goiburuaren bidez bidaltzen den politika, nabigatzaileak zer baliabide karga edo exekuta ditzakeen mugatzeko.

**Cookiea**  
Nabigatzaileak gordetzen duen eta webgune bati lotuta dagoen datu txikia. Besteak beste, saio-identifikatzaile bat mantentzeko erabil daiteke.

**CORS (Cross-Origin Resource Sharing)**  
HTTP goiburuetan oinarritutako mekanismoa, zerbitzariak nabigatzailetik zer jatorrik atzi ditzaketen baliabide jakin batzuk adierazteko.

**Kredentziala**  
Identitate bat frogatzeko edo egiaztatzeko erabiltzen den datua, hala nola erabiltzaile-izena, pasahitza, gakoa edo tokena.

## D

**Sarrerako datuak**  
Aplikazio batek formularioetatik, URLetatik, JSONetik, goiburuetatik, cookieetatik, fitxategietatik edo beste iturri batzuetatik jasotzen duen informazioa. Zerbitzariak baliozkotu arte ez-fidagarritzat hartu behar dira.

**Arazketa (debug)**  
Garapena eta erroreen diagnostikoa errazteko erabiltzen den modua edo informazioa. Produkzioan ez ditu trazak, ibilbideak, kontsultak, sekretuak edo bestelako barne-xehetasunak agerian utzi behar.

**DevTools**  
Nabigatzailean integratutako garapen-tresnak. HTTP eskaerak, erantzunak, goiburuak, cookieak, biltegiratzea, erroreak eta bezeroaren portaera behatzeko aukera ematen dute.

**DVWA (Damn Vulnerable Web Application)**  
Ikaskuntzarako eta laborategirako nahita ahula den web-aplikazioa. Moduluan ahultasunak behatzeko eta haien zuzenketa ingurune kontrolatu batean ulertzeko erabiltzen da.

## E

**Ingurunea**  
Aplikazioa exekutatzen den testuingurua, adibidez garapena, probak edo produkzioa. Aplikazio berak konfigurazio desberdinak erabil ditzake ingurunearen arabera.

**Errore kontrolatua**  
Erabiltzaileari beharrezkoa ez den xehetasun teknikorik erakutsi gabe informatzen dion aplikazioaren erantzun kudeatua. Arazoa diagnostikatzeko behar den xehetasuna barnean erregistra daiteke.

**Irteerako escape-a**  
Datu bat irteera-testuinguru batean, adibidez HTMLn, sartu aurretik aplikatzen den tratamendua, eduki gisa erakutsi behar denean kode gisa interpreta ez dadin.

**Segurtasun-ebidentzia**  
Kontrol bat aplikatu dela eta funtzionatzen duela frogatzen duen elementua. Eskaera eta haren erantzuna, pantaila-argazkia, sekreturik gabeko konfigurazioa, proba baten emaitza edo anonimizatutako loga izan daiteke.

**Esposizioa**  
Zerbitzu, baliabide edo osagai bat beste sistema batzuetatik zenbateraino atzi daitekeen adierazten duen maila. Benetan beharrezkoa den horretara mugatu behar da.

## F

**Frontend**  
Batez ere nabigatzailean exekutatzen den eta erabiltzailearekin elkarreragiten duen aplikazioaren zatia. Esperientzia hobetu eta interfazeko baliozkotzeak egin ditzake, baina ez ditu zerbitzariari dagozkion segurtasun-kontrolak bere gain hartu behar.

## H

**Pasahitzaren hash-a**  
Pasahitz bati modu ez-itzulgarrian gordetzeko diseinatutako funtzio bat aplikatzearen emaitza. Pasahitzak ez dira testu arruntean gorde behar.

**HttpOnly**  
JavaScript-ek cookie baten balioa zuzenean atzitzea eragozten duen cookie-atributua. Bereziki garrantzitsua da saio-cookieetan.

**HTTP (Hypertext Transfer Protocol)**  
Bezeroen eta web zerbitzarien artean eskaerak eta erantzunak trukatzeko erabiltzen den komunikazio-protokoloa.

**HTTPS**  
TLS bidez babestutako konexio baten gaineko HTTP erabilera. Konfidentzialtasuna, osotasuna eta zerbitzariaren autentifikazioa eskaintzen ditu ziurtagiri digitalen bidez.

**HSTS (HTTP Strict Transport Security)**  
`Strict-Transport-Security` goiburuaren bidez adierazten den politika, nabigatzaileari gunea denbora-tarte jakin batean HTTPS bidez soilik erabiltzeko agintzen diona.

## I

**Baliabidearen IDa**  
Aplikazioko objektu bat aurkitzeko erabiltzen den identifikatzailea, adibidez `/reservas/25`. Zerbitzariak ez du suposatu behar erabiltzaile bat baliabidera sartzeko baimenduta dagoela identifikatzailea ezagutu edo aldatu duelako soilik.

**SQL injekzioa (SQL Injection)**  
Fidagarriak ez diren datuek SQL kontsulta baten egitura alda dezaketenean sortzen den ahultasuna. Beste neurri batzuen artean, kontsulta parametrizatu edo prestatuen bidez prebenitzen da.

## J

**JSON (JavaScript Object Notation)**  
Web-aplikazio eta APIen artean datuak trukatzeko erabili ohi den testu-formatua.

## L

**Loga**  
Aplikazio edo zerbitzari batek sortutako gertaeren eta erroreen barne-erregistroa. Diagnostikoa erraztu behar du, sekretuak edo beharrezkoa ez den informazio sentikorra gorde gabe.

## M

**HTTP metodoa**  
HTTP eskaera batean adierazitako eragiketa. Ohiko metodo batzuk `GET`, `POST`, `PUT`, `PATCH` eta `DELETE` dira.

**Pribilegio minimoa**  
Erabiltzaile, prozesu edo zerbitzu batek bere funtzioa egiteko behar dituen baimenak bakarrik izan behar dituela dioen printzipioa.

## O

**Jatorria (origin)**  
Web-baliabide bat kargatzen den eskema, domeinua eta ataka konbinazioa. Jatorri bereko politikan eta CORSen funtsezko kontzeptua da.

## P

**Payload-a**  
Eskaera edo erantzun baten gorputzean garraiatzen diren datuak. DevTools-en termino hau zerbitzarira bidalitako datuak erakusteko erabiltzen da maiz.

**Baimena (permission)**  
Funtzionalitate edo baliabide baten gainean ekintza zehatz bat egiteko baimen konkretua.

**HTTP eskaera**  
Bezero batek zerbitzari bati eragiketa edo baliabide bat eskatzeko bidaltzen dion mezua. Besteak beste, metodoa, URLa, goiburuak eta, dagokionean, gorputza ditu.

**Proba negatiboa**  
Ekintza baliogabe edo baimendu gabe bat behar bezala baztertzen dela egiaztatzen duen proba. Adibidez, beste erabiltzaile baten baliabidera sartzen saiatzea.

**Proba positiboa**  
Baliozko eragiketa batek espero bezala funtzionatzen duela egiaztatzen duen proba.

**Proxya**  
Bezero baten eta zerbitzari baten arteko bitarteko osagaia. Burp Proxy nabigatzailearen eta aplikazioaren arteko HTTP trafikoa behatu eta atzemateko erabiltzen da.

## R

**Baliabidea**  
Eragiketa bat egiten zaion aplikazioko elementua, hala nola erabiltzaile bat, erreserba bat, eskaera bat, fitxategi bat edo endpoint bat.

**HTTP erantzuna**  
Zerbitzariak eskaera bat prozesatu ondoren itzultzen duen mezua. Egoera-kodea, goiburuak eta gorputza izan ditzake.

**Kodearen berrikuspena**  
Kodearen azterketa sistematikoa, espero diren kontrolak badaudela, leku egokian aplikatzen direla eta erabaki ez-seguruen mende ez daudela egiaztatzeko.

**Arriskua**  
Mehatxu batek ahultasun bat aprobetxatu eta aplikazioan, datuetan edo erabiltzaileengan kaltea eragiteko aukera.

**Rola**  
Aplikazio batean erabiltzaile mota edo erantzukizun bati lotutako baimenen multzoa.

## S

**SameSite**  
Beste gune batzuetatik hasitako eskaeretan cookie bat zer egoeratan bidaltzen den kontrolatzen duen atributua.

**Sanitizazioa**  
Baimendu gabeko edukia ezabatzeko edo aldatzeko datuei egiten zaien transformazioa. Ez da baliozkotzearekin nahastu behar, eta ez da irteerako escape-aren ordezko automatiko gisa erabili behar.

**Secure**  
Cookie bat HTTPS konexioen bidez bakarrik bidali behar dela adierazten duen atributua.

**Sekretua**  
Aplikazio batek funtzionatzeko behar duen informazio sentikorra, hala nola pasahitzak, API gakoak, gako pribatuak edo datu-baseko kredentzialak. Ez da iturburu-kodearen barruan gorde behar.

**Saioa**  
Erabiltzaile beraren eskaera desberdinen artean egoera mantentzeko erabiltzen den mekanismoa. Normalean zerbitzariak saioaren informazioa gordetzen du eta nabigatzaileak identifikatzaile bat mantentzen du.

**Esposizio-azalera**  
Konexioak, datuak edo interakzioak jaso ditzaketen aplikazio edo azpiegiturako puntuen multzoa; beraz, berrikusi eta babestu egin behar dira.

## T

**TLS (Transport Layer Security)**  
HTTPSk bezeroaren eta zerbitzariaren arteko komunikazioa babesteko erabiltzen duen protokolo kriptografikoa.

## V

**Sarrerako datuen baliozkotzea**  
Jasotako datuek espero diren mota, formatu, luzera, tarte edo eduki-arauak betetzen dituztela egiaztatzeko prozesua. Segurtasunerako baliozkotze eraginkorra zerbitzarian egin behar da.

**Ingurune-aldagaia**  
Aplikazioaren prozesuari exekuzio-ingurunetik ematen zaion balioa. Konfigurazioa eta sekretuak iturburu-kodetik bereiztea ahalbidetzen du.

**Ahultasuna**  
Aplikazioan portaera ez-segurua eragin dezakeen edo haren aurka erabil daitekeen diseinu-, inplementazio- edo konfigurazio-ahulezia.

## X

**XSS (Cross-Site Scripting)**  
Fidagarria ez den edukia nabigatzailean JavaScript kode gisa interpretatzea ahalbidetzen duen ahultasuna. Kontraneurri nagusietako bat irteera testuinguruaren arabera modu seguruan sortzea da.

## Ideia nagusia

> Glosarioa erreferentzia azkarra da. Terminoek esanahi osoa hartzen dute web-aplikazio baten diseinuan, inplementazioan, hedapenean eta egiaztapenean aplikatzen direnean.
