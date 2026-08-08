# Segurtasun-checklista

Checklist batek moduluan landutako segurtasun-printzipioak berrikuspen praktiko eta errepikagarri bihurtzea ahalbidetzen du.

Ez du irizpide teknikoa ordezkatzen.

Aplikazio bat produkziorako prestatutzat jo aurretik zer alderdi egiaztatu behar diren gogorarazteko balio du.

```text
Berrikusi

    ↓

Egiaztatu

    ↓

Zuzendu

    ↓

Ebidentziatu
```

Zerrenda proiektura egokitu behar da, baina DAW erronketarako oinarri komun gisa erabil daiteke.

## Checklista nola erabili

Elementu bakoitza honela marka daiteke:

```text
[ ] Egiteke

[x] Egiaztatuta

[N/A] Ez dagokio
```

Puntu bat betetzen ez denean, zer zuzenketa behar den erregistratu behar da.

Ez da nahikoa laukiak markatzea benetako egiaztapenik egin gabe.

## 1. Sarrerako datuen baliozkotzea

```text
[ ] Jasotako datuak zerbitzarian baliozkotzen dira

[ ] JavaScript bidezko baliozkotzea ez da kontrol bakarra

[ ] Datu motak egiaztatzen dira

[ ] Tarteak eta formatuak egiaztatzen dira

[ ] Espero ez diren balioak baztertzen dira

[ ] Errore-mezuak egokiak dira
```

## 2. Irteera segurua

```text
[ ] Erabiltzailearengandik datozen datuak modu seguruan erakusten dira

[ ] Fidagarria ez den edukia HTML edo JavaScript gisa interpretatzea saihesten da

[ ] Dagokionean escape edo mekanismo baliokideak erabiltzen dira

[ ] Ez da beharrezkoa ez den informazio sentikorrik erakusten
```

## 3. Datuetarako sarbidea

```text
[ ] Kontsultek parametroak edo mekanismo baliokideak erabiltzen dituzte

[ ] Ez dira erabiltzailearen datuak zuzenean SQL kontsultetan kateatzen

[ ] Aplikazioak datu-baseko erabiltzaile espezifiko bat erabiltzen du

[ ] Datu-baseko erabiltzaileak behar diren baimenak bakarrik ditu
```

## 4. Autentifikazioa

```text
[ ] Pasahitzak hash seguru baten bidez gordetzen dira

[ ] Kredentzial okerrak baztertzen dira

[ ] Babestutako baliabideek autentifikazioa behar dute

[ ] Saioa ixteak sarbidea behar bezala baliogabetzen du

[ ] Saioa modu egokian kudeatzen da
```

## 5. Baimena

```text
[ ] Babestutako baliabide bakoitzak baimenak egiaztatzen ditu

[ ] Autentifikatuta egoteak ez du automatikoki sarbidea ematen

[ ] Dagokionean baliabidearen jabea egiaztatzen da

[ ] Rolek muga definituak dituzte

[ ] Identifikatzailea aldatzeak ez du besteen baliabideetara sartzea ahalbidetzen
```

## 6. Saioak eta cookieak

```text
[ ] Cookie sentikorrek Secure erabiltzen dute dagokionean

[ ] Saio-cookieek HttpOnly erabiltzen dute dagokionean

[ ] SameSite modu egokian konfiguratuta dago

[ ] Ez dira saio-identifikatzaileak alferrik agerian uzten

[ ] Saioa ixteak saioa baliogabetzen du
```

## 7. Fitxategien igoera

```text
[ ] Fitxategien tamaina mugatuta dago

[ ] Fitxategi mota baliozkotzen da

[ ] Fitxategiaren izena kontrolatzen da

[ ] Fitxategiak kokapen egokian gordetzen dira

[ ] Igotako fitxategiak ezin dira exekutatu

[ ] Erabiltzaile batek ezin ditu fitxategiak arbitrarioki gainidatzi
```

## 8. APIak

```text
[ ] Jasotako JSON datuak baliozkotzen dira

[ ] Babestutako endpoint-ek autentifikazioa behar dute

[ ] Baimena baliabide bakoitzerako egiaztatzen da

[ ] HTTP egoera-kodeak koherenteak dira

[ ] APIak ez du beharrezkoa ez den barne-informaziorik itzultzen

[ ] CORS benetako beharren arabera konfiguratuta dago
```

## 9. Sekretuak eta konfigurazioa

```text
[ ] Ez dago pasahitzik edo API gakok kodearen barruan

[ ] Sekretuak biltegitik kanpo daude

[ ] .env ez dago argitaratuta

[ ] .env ez dago bertsio-kontrolean

[ ] Garapenak eta produkzioak konfigurazio desberdinak erabiltzen dituzte

[ ] Produkzioko sekretuak babestuta daude
```

## 10. Produkzioko konfigurazioa

```text
[ ] Ingurunea produkzio gisa konfiguratuta dago

[ ] DEBUG desgaituta dago

[ ] Ez dira errore tekniko xeheak erakusten

[ ] Garapeneko mendekotasunak ez dira alferrik sartzen

[ ] Konfigurazioa hedatutako inguruneari dagokio
```

## 11. HTTPS

```text
[ ] Aplikazioak HTTPS bidez funtzionatzen du

[ ] Ziurtagiria balioduna da

[ ] HTTP HTTPSra birbideratzen da

[ ] Ez dago mixed content-ik

[ ] HSTS HTTPS konfigurazioak aukera ematen duenean soilik erabiltzen da
```

## 12. Zerbitzaria eta esposizio-azalera

```text
[ ] Behar diren zerbitzuak bakarrik daude irekita

[ ] SSH mugatuta dago, erabiltzen bada

[ ] Direktorio publikoa zuzena da

[ ] Ez dira barne-fitxategiak agerian uzten

[ ] Ez dago garapen-tresna edo panel eskuragarririk

[ ] Zerbitzariak behar den gutxieneko informazioa soilik erakusten du
```

## 13. Baimenak

```text
[ ] Fitxategiek baimen egokiak dituzte

[ ] Behar diren karpetek bakarrik dute idazketa-baimena

[ ] Ez da chmod 777 erabiltzen irtenbide orokor gisa

[ ] Fitxategi sentikorrak babestuta daude

[ ] Igoera-direktorioek ez dute exekuzioa baimentzen
```

## 14. Datu-basea

```text
[ ] Datu-basea ez dago zuzenean Internetera irekita

[ ] Aplikazioak ez du root edo administratzaile bat erabiltzen

[ ] Kredentzialak kodetik kanpo daude

[ ] Aplikazioaren erabiltzaileak pribilegio minimoa du

[ ] Segurtasun-kopiak daude

[ ] Leheneratzea kontuan hartu edo probatu da
```

## 15. Segurtasun-goiburuak

Proiektuari dagozkionak bakarrik egiaztatu.

```text
[ ] Content-Security-Policy konfiguratuta dago dagokionean

[ ] X-Content-Type-Options konfiguratuta dago

[ ] Strict-Transport-Security behar bezala erabiltzen da dagokionean

[ ] Referrer-Policy definituta dago

[ ] Permissions-Policy berrikusi da

[ ] Goiburuek ez dituzte funtzionalitate legitimoak hausten
```

## 16. Erroreak eta logak

```text
[ ] Errore teknikoak ez zaizkio erabiltzaileari erakusten

[ ] Errore garrantzitsuak erregistratuta geratzen dira

[ ] Logek ez dute pasahitzik

[ ] Logek ez dute token osorik

[ ] Logek ez dute sekreturik

[ ] Log-fitxategiak ez daude webetik eskuragarri

[ ] Logen errotazioa aurreikusita dago
```

## 17. Egiaztapena

```text
[ ] Gutxienez kasu baliodun bat probatu da

[ ] Sarrera baliogabeak probatu dira

[ ] Autentifikatu gabeko sarbidea probatu da

[ ] Baimena probatu da

[ ] Dagokionean identifikatzaileren bat manipulatu da

[ ] HTTP erantzunak berrikusi dira

[ ] Errore kontrolatu bat probatu da

[ ] Aurkitutako hutsegiteak zuzendu edo dokumentatu dira
```

## 18. Ebidentziak

```text
[ ] Erabaki garrantzitsu bakoitzak ebidentziaren bat du

[ ] Ebidentziak ulergarriak dira

[ ] Ez dute sekreturik

[ ] Ez dute beharrezkoa ez den datu pertsonalik

[ ] Pantaila-argazkiek beharrezkoa dena bakarrik erakusten dute
```

## Lehentasunak ezarri

Elementu guztiek ez dute garrantzi bera proiektu guztietan.

Erronka entregatu aurretik komeni da honako hauek identifikatzea:

```text
Kontrol kritikoak

        ↓

Lehenik egiaztatuta
```

Adibidez:

- baimena;
- sekretuak;
- datu-baseko kontsultak;
- fitxategien igoera;
- produkzioko konfigurazioa.

## Checklista eta berdinen arteko berrikuspena

Zerrenda bera berrikuspen gurutzatu baterako erabil daiteke.

```text
A taldea

        ↓

B proiektua berrikusten du


B taldea

        ↓

A proiektua berrikusten du
```

Helburua ez da beste taldea puntuatzea.

Konturatu gabe pasa daitezkeen alderdiak hautematea da.

## TxurdiGest-en aplikatzea

TxurdiGest-en ez litzateke beharrezkoa puntu guztiak betetzea funtzionalitate bat existitzen ez bada.

Adibidez:

```text
Fitxategien igoera

N/A
```

aplikazioak fitxategiak igotzea baimentzen ez badu.

Aitzitik, bereziki garrantzitsuak lirateke:

```text
Baliozkotzea

Autentifikazioa

Baimena

Datu-basea

Sekretuak

HTTPS

Erroreak

Logak
```

## Azken emaitza

Berrikuspena amaitzean, puntu bakoitzak egoera hauetako batean egon beharko luke:

```text
Egiaztatuta

Zuzenduta

Justifikatutako egiteke

Ez dagokio
```

Checklistak ez du dokumentu estatiko bihurtu behar.

Aplikazioaren benetako egoera islatu behar du.

## Ideia nagusia

> Segurtasun-checklist bat erabilgarria da kontrol zehatzak egiaztatzera behartzen duenean eta aplikazio bat argitaratu aurretik zer geratzen den pendiente hautematea errazten duenean.
