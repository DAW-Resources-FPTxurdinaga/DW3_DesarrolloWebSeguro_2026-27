# 3. jarduera. Konfigurazio seguru bat diseinatzea

## Helburuak

Jarduera hau amaitzean gai izango zara:

- Web aplikazio baten informazio sentikorra identifikatzeko.
- Iturburu-kodea eta konfigurazioa bereizteko.
- Zer informazio babestuta mantendu behar den erabakitzeko.
- Lan-ingurune desberdinetarako konfigurazio egokia prestatzeko.

---

## Testuingurua

**TxurdiGest**-eko garapen-taldea aplikazioaren garapena hastear dago.

Kodea idatzi aurretik, aplikazioaren parte izango den informazioa eta iturburu-kodetik kanpo mantendu beharko dena erabaki nahi ditu.

Erabaki horiek hasieratik hartzeak segurtasun-arazoak saihestuko ditu eta aplikazioaren hedapena erraztuko du.

---

## Jarduera

Lan egin 3 edo 4 laguneko taldeetan.

Aztertu zuen aplikazioa eta erabaki:

- aplikazioak funtzionatzeko zer informazio erabiliko duen;
- zer informazio den sentikorra;
- zer datu izan daitezkeen iturburu-kodearen parte;
- zer datu mantendu behar diren kodetik kanpo;
- zer informazio aldatuko den garapen- eta produkzio-inguruneen artean.

Ez da beharrezkoa oraindik erabakitzea konfigurazio hori nola inplementatu.

Helburua da babestu beharreko informazioa behar bezala identifikatzea.

---

## Nola heldu diezaiokezue?

Honelako prozesu bat jarrai dezakezue:

1. Egin zuen aplikazioak erabiliko duen informazio guztiaren zerrenda bat.
2. Markatu zer informaziok arriskuan jar lezakeen segurtasuna publiko bihurtuko balitz.
3. Pentsatu zer datu aldatuko diren aplikazioa garapenetik produkziora pasatzen denean.
4. Erabaki zer informazio ez litzatekeen inoiz zuzenean kodean gorde behar.

!!! tip "Aholkua"

    Galde iezaiozue beti zuen buruari:

    **Zer gertatuko litzateke biltegi hau minutu batzuetan publikoa izango balitz?**

    Erantzuna bada norbaitek zuen datu-basera sarbidea lor lezakeela, API bat zuen izenean erabil lezakeela edo aplikazioa konprometitu lezakeela, informazio hori ez litzateke zuzenean kodean idatzita egon behar.

---

## Erronkari aplikazioa

Berrikusi zuen proiektua eta prestatu zerrenda txiki bat, zuen aplikazioak erabiliko duen informazio sentikorrarekin.

Egiaztatu taldeak argi daukala:

- zer datu babestu beharko diren;
- zer datu alda daitezkeen ingurunearen arabera;
- zer informazio ez litzatekeen inoiz biltegira igo behar.

Erabaki horiek gidari izango dira aplikazioa 4. blokean konfiguratzen duzuenean.

---

## Ohiko akatsak

Ohikoa da akats hauetako batzuk egitea:

❌ Datu-baseko pasahitza zuzenean kodean idaztea.

❌ API gakoak Git biltegi batean gordetzea.

❌ Garapenerako eta produkziorako konfigurazio bera erabiltzea.

❌ Biltegi pribatu batek sekretuak babesteko beharra ezabatzen duela pentsatzea.

---

## Sakontzeko

Bilatu PHP edo Laravel erabiliz garatutako proiektu bat.

Kodea aztertzera sartu gabe, saiatu identifikatzen:

- non gordetzen duen konfigurazioa;
- nola bereizten dituen kodea eta konfigurazio-datuak;
- zer informazio aldatzen den ingurune desberdinen artean.

Partekatu taldearekin antolaketa honek zer abantaila ekartzen dituen.

---

## Gogoratu beharrekoa

- Kodeak eta konfigurazioak funtzio desberdinak betetzen dituzte.
- Informazio sentikorrak ez du inoiz iturburu-kodearen parte izan behar.
- Ingurune bakoitzak konfigurazio desberdina behar dezake.
- Konfigurazioaren kudeaketa on batek mantentzea errazten du eta aplikazioaren segurtasuna hobetzen du.