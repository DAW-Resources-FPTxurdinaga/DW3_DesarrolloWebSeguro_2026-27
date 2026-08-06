# 2. jarduera. Aplikaziorako sarbidea diseinatzea

## Helburuak

Jarduera hau amaitzean gai izango zara:

- Aplikazio bateko erabiltzaile mota desberdinak identifikatzeko.
- Profil bakoitzerako sarbide-sistema egokia diseinatzeko.
- Erabiltzaile bakoitzak zer eragiketa egin ahal izango dituen definitzeko.
- Proiektuaren garapenean geroago inplementatuko dituzun erabakiak prestatzeko.

---

## Testuingurua

**TxurdiGest**-eko garapen-taldea aplikaziorako sarbidea inplementatzen hasiko da.

Saio-hasiera programatu aurretik, beharrezkoa da nor sartu ahal izango den aplikaziora eta saioa hasi ondoren erabiltzaile bakoitzak zer egin ahal izango duen erabakitzea.

Diseinu on batek segurtasun-arazoak saihestuko ditu eta ondorengo garapena erraztuko du.

---

## Jarduera

Lan egin 3 edo 4 laguneko taldeetan.

Aztertu zuen aplikazioa eta erabaki:

- zer erabiltzaile mota egongo diren;
- saioa hastean nola identifikatuko diren;
- saioan zehar zer informazio gorde beharko den;
- erabiltzaile mota bakoitzak zer eragiketa egin ahal izango dituen;
- zer eragiketa egon beharko diren debekatuta.

Ez da beharrezkoa oraindik pentsatzea nola programatu funtzionalitate horiek.

Helburua da inplementazioan gidari izango den diseinu argi bat definitzea.

---

## Nola heldu diezaiokezue?

Honelako prozesu bat jarrai dezakezue:

1. Egin aplikazioa erabiliko duten erabiltzaile guztien zerrenda bat.
2. Taldekatu antzeko ardurak dituztenak.
3. Erabiltzaile mota bakoitzerako, erabaki bere lana egiteko zer ekintza behar dituen.
4. Galdetu zeuen buruari ba ote dagoen egin behar ez lukeen ekintzaren bat.
5. Berrikusi erabiltzaile batek benetan behar dituenak baino baimen gehiago ote dituen.

Ez dago irtenbide zuzen bakar bat. Garrantzitsuena hartutako erabakiak justifikatzea da.

!!! tip "Aholkua"

    Erabiltzaile batek bere funtzioa betetzeko ekintza jakin bat egin behar ez badu, ziurrenik ez luke ekintza hori egiteko baimenik izan behar.

---

## Erronkari aplikazioa

Berrikusi zuen proiektua eta prestatu zerrenda bat honako hauekin:

- aplikazioak izango dituen erabiltzaile-profilak;
- bakoitzarentzat erabilgarri egongo diren funtzionalitateak;
- autentifikazioa beharko duten eragiketak;
- baimen-kudeaketa beharko duten eragiketak.

Erabaki horiek gidari izango dira sarbide-sistema 3. blokean inplementatzen duzuenean.

---

## Ohiko akatsak

Ohikoa da akats hauetako batzuk egitea:

❌ Erabiltzaile guztiek baimen berak behar dituztela pentsatzea.

❌ Garapena errazteko erabiltzaile-profil bakar bat sortzea.

❌ Interfazean botoi bat ezkutatzea eta funtzionalitatea dagoeneko babestuta dagoela pentsatzea.

❌ Zerbitzarian eragiketa bat egin aurretik baimenak ez egiaztatzea.

---

## Sakontzeko

Aukeratu zuen aplikazioko funtzionalitate garrantzitsu bat.

Adibidez:

- kalifikazio bat aldatzea;
- erabiltzaile bat ezabatzea;
- pasahitz bat aldatzea;
- txosten bat deskargatzea.

Galdetu:

- Nork egin beharko luke ekintza hau?
- Nork ez luke egin beharko?
- Zer gertatuko da erabiltzaile bat baimenik gabe sartzen saiatzen bada?

Partekatu zuen erantzunak taldeko gainerakoekin.

---

## Gogoratu beharrekoa

- Autentifikatzea erabiltzaile baten identitatea egiaztatzea da.
- Baimentzea erabiltzaile horrek zer egin dezakeen egiaztatzea da.
- Erabiltzaile bakoitzak behar dituen baimenak soilik izan behar ditu.
- Baimenen behin betiko egiaztapena beti zerbitzarian egin behar da.