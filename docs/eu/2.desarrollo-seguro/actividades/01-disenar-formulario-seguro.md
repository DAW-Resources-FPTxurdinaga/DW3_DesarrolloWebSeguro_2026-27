# 1. jarduera. Inprimaki seguru bat diseinatzea

## Helburuak

Jarduera hau amaitzean gai izango zara:

- Web inprimaki batek jasoko dituen datuak identifikatzeko.
- Programatzen hasi aurretik balidazio-estrategia bat diseinatzeko.
- Erabiltzailearen esperientzia hobetzen duten egiaztapenak eta aplikazioa babesteko beharrezkoak direnak bereizteko.
- Datu bat baliozkoa ez denean aplikazioak nola erantzungo duen erabakitzeko.

---

## Testuingurua

**TxurdiGest**-eko garapen-taldeak ikasleen alta inprimakia inplementatuko du.

Programatzen hasi aurretik, erabiltzaileek sartutako datuak nola tratatuko diren erabaki behar da.

Diseinu on batek arazo asko saihestuko ditu garapenean, eta aplikazioaren mantentzea erraztuko du.

---

## Jarduera

Lan egin 3 edo 4 laguneko taldeetan.

Aztertu ikasleen alta inprimakia eta erabaki:

- inprimakiak zer datu eskatuko dituen;
- zer eremu izango diren derrigorrezkoak;
- datu bakoitzak zer balidazio-arau izango dituen;
- JavaScript-ek zer egiaztapen egingo dituen;
- PHPk zer egiaztapen egingo dituen;
- datu bat baliozkoa ez denean erabiltzaileak zer mezu ikusiko duen.

Ez da beharrezkoa koderik idaztea.

Helburua da erabakiak hartzea, proiektuaren garapenean baliagarriak izango zaizkizuenak.

---

## Nola heldu diezaiokezue?

Ez badakizue nondik hasi, prozesu hau jarrai dezakezue:

1. Egin inprimakiak jasoko dituen datu guztien zerrenda bat.
2. Pentsatu zer arazo ager daitezkeen datu horietako bat okerra bada.
3. Erabaki zer baldintza bete behar dituen datu bakoitzak baliozkoa dela jotzeko.
4. Bereizi erabiltzaileari laguntzeko egin daitezkeen egiaztapenak eta aplikazioa babesteko ezinbestekoak direnak.
5. Pentsatu erabiltzaileak zer informazio beharko duen errorea zuzentzeko.

Ez saiatu irtenbide perfektua aurkitzen. Garrantzitsuena da erabaki guztiak justifikatuta egotea.

!!! tip "Aholkua"

    Balidazio bati buruz zalantzak badituzue, galdetu:

    **Zer gertatuko litzateke erabiltzaile batek datu hau eskuz aldatuko balu zerbitzarira bidali aurretik?**

---

## Erronkari aplikazioa

Aukeratu zuen proiektuko inprimakietako bat eta errepikatu prozesu bera.

Amaitzean, egiaztatu taldeak argi daukala:

- inprimakiak zer datu jasoko dituen;
- bakoitzak zer balidazio-arau izango dituen;
- JavaScript-ek zer balidazio egingo dituen;
- PHPk zer balidazio egingo dituen.

Erabaki horiek gidari izango dira 3. blokean.

---

## Ohiko akatsak

Ohikoa da akats hauetako batzuk egitea:

❌ Nabigatzailetik jasotako datuak fidagarriak direla pentsatzea.

❌ JavaScript-en soilik balidatzea.

❌ Balidazioak inprimakia dagoeneko programatuta dagoenean diseinatzea.

❌ Honelako mezuak erakustea:

> "SQL errorea 42. lerroan."

Erabiltzaileak arazoa zuzentzen lagunduko dion mezu argia jaso behar du. Informazio teknikoa barnean erregistratu behar da.

---

## Sakontzeko

Aukeratu zuen aplikazioko beste inprimaki bat eta errepikatu prozesu bera.

Ondoren, alderatu bi kasuetan hartutako erabakiak.

Balidazio-irizpide berak erabili dituzue?

Erantzuna ezezkoa bada, justifikatu arrazoia.

---

## Gogoratu beharrekoa

- Nabigatzailetik jasotako datu guztiak ez-fidagarritzat hartu behar dira.
- Programatu aurretik balidazioa diseinatzeak akats asko saihesten ditu.
- JavaScript-ek erabiltzaileari lagun diezaioke, baina ez du inoiz ordezten zerbitzarian egindako balidazioa.
- Balidazio on batek aplikazioaren kalitatea eta segurtasuna hobetzen ditu.