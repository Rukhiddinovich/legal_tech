# UI/UX FUNKSIONAL SPETSIFIKATSIYA

*PRD v2.0 ga ilova — Ekranlar, Ikonkalar va Elementlarning Batafsil Xatti-harakati*

## "LegalTech Ekotizim" — Ekran-ma-Ekran Spetsifikatsiya

Har bir tugma, ikonka va boʻlim bosilganda tizimda nima sodir boʻlishini belgilaydigan hujjat —
dasturchi uchun ekran xaritasi.

Ushbu hujjat PRD v2.0 dagi modullarni ekran darajasida detallashtiradi. Har bir jadval bitta ekranga
tegishli: chap ustunda interfeys elementi, oʻrtada foydalanuvchi bosganda tizim bajaradigan amal,
oʻngda natijada foydalanuvchi koʻradigan aniq natija yozilgan.

---

## 1. Bosh Sahifa (Mijoz) — "Home" Ekrani

*Mijoz tizimga kirgach koʻradigan birinchi ekran. Yuqorida qidiruv paneli, oʻrtada soha ikonkalari (
grid koʻrinishida), pastda "Tezkor vositalar" bloki joylashadi.*

| Element / Ikonka                                                     | Bosilganda amal            | Natijada nima chiqadi                                                                                                                                                                                        |
|----------------------------------------------------------------------|----------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Soha ikonkasi — "Oila"                                               | Bosiladi                   | "Oila" sohasi boʻyicha filtrlangan advokatlar roʻyxati sahifasi ochiladi (2-boʻlimga qarang), narx tepada koʻrsatiladi (masalan 100 000 soʻm/30 daqiqa).                                                     |
| Soha ikonkasi — "Meros"                                              | Bosiladi                   | "Meros" sohasi boʻyicha filtrlangan, faqat shu yoʻnalishni tanlagan advokatlar roʻyxati ochiladi, narx — 150 000 soʻm/30 daqiqa koʻrsatiladi.                                                                |
| Soha ikonkasi — "Soliq", "Jinoyat", "Mehnat", "Tadbirkorlik" va h.k. | Bosiladi                   | Har biri xuddi shu tarzda — oʻsha sohaga mos filtrlangan advokatlar roʻyxatini ochadi, faqat narx va advokatlar roʻyxati farq qiladi.                                                                        |
| Qidiruv paneli (lupa ikonkasi)                                       | Bosiladi / matn kiritiladi | Klaviatura ochiladi, foydalanuvchi advokat ismi yoki kalit soʻz (masalan "ajralish") kiritishi mumkin; natijalar pastda roʻyxat sifatida real vaqtda chiqadi.                                                |
| Bildirishnoma qoʻngʻirogʻi                                           | Bosiladi                   | Bildirishnomalar roʻyxati ochiladi (soʻnggi toʻlovlar, seans holati, aksiyalar); oʻqilmagan xabarlar ustida qizil nuqta koʻrsatiladi.                                                                        |
| Profil rasmi / avatar (yuqori oʻng burchak)                          | Bosiladi                   | Foydalanuvchi profili menyusi ochiladi: "Mening buyurtmalarim", "Toʻlov tarixi", "Sozlamalar", "Til: Oʻzbek/Рус", "Yordam", "Chiqish".                                                                       |
| "Hujjatlar konstruktori" banner kartasi                              | Bosiladi                   | Hujjat turlari roʻyxati sahifasi ochiladi (4-boʻlimga qarang).                                                                                                                                               |
| "Davlat boji kalkulyatori" banner kartasi                            | Bosiladi                   | Kalkulyator formasi ochiladi (5-boʻlimga qarang).                                                                                                                                                            |
| "Huquqiy koʻrsatmalar" banner kartasi                                | Bosiladi                   | Maqolalar roʻyxati sahifasi ochiladi (6-boʻlimga qarang).                                                                                                                                                    |
| Til almashtirish tugmasi ("UZ / RU")                                 | Bosiladi                   | Til tanlash oynasi (2 ta variant) chiqadi, tanlangach butun interfeys shu tilga oʻtadi, sahifa qayta yuklanmaydi (real-time almashtirish).                                                                   |
| Pastki navigatsiya — "Bosh sahifa" ikonkasi                          | Bosiladi                   | Joriy ekran — hech narsa oʻzgarmaydi, faqat ikonka faollashadi (rangga kiradi).                                                                                                                              |
| Pastki navigatsiya — "Buyurtmalarim" ikonkasi                        | Bosiladi                   | Foydalanuvchining barcha oʻtgan va joriy konsultatsiya/hujjat buyurtmalari roʻyxati ochiladi (holat: "Yakunlangan", "Bekor qilingan", "Jarayonda").                                                          |
| Pastki navigatsiya — "B2B" ikonkasi                                  | Bosiladi                   | Agar foydalanuvchi jismoniy shaxs boʻlsa — "Biznes uchun" tanishtiruv sahifasi (obuna sotib olish taklifi) ochiladi; agar allaqachon B2B mijoz boʻlsa — toʻgʻridan-toʻgʻri B2B kabinetiga oʻtadi (8-boʻlim). |
| Pastki navigatsiya — "Profil" ikonkasi                               | Bosiladi                   | Profil sahifasiga oʻtadi (yuqoridagi avatar bilan bir xil natija).                                                                                                                                           |

---

## 2. Soha Boʻyicha Advokatlar Roʻyxati (masalan, "Meros" bosilgach)

*Bu ekran istalgan soha ikonkasi bosilganda ochiladi. Yuqorida tanlangan soha nomi va narxi, pastda
shu sohada ishlaydigan advokatlar kartochkalari roʻyxati chiqadi.*

| Element / Ikonka                                                      | Bosilganda amal       | Natijada nima chiqadi                                                                                                                    |
|-----------------------------------------------------------------------|-----------------------|------------------------------------------------------------------------------------------------------------------------------------------|
| Saralash ikonkasi (yuqori oʻng, filter belgisi)                       | Bosiladi              | Saralash variantlari chiqadi: "Reyting boʻyicha (yuqoridan)", "Onlayn birinchi", "Tajriba boʻyicha", "Arzon narx birinchi".              |
| Advokat kartochkasi — avatar/ism                                      | Bosiladi              | Advokatning toʻliq profili sahifasi ochiladi (3-boʻlimga qarang).                                                                        |
| Advokat kartochkasidagi yashil nuqta ("Onlayn" belgisi)               | Bosiladi (yoki hover) | "Hozir onlayn, darhol javob beradi" degan qisqa izoh (tooltip) chiqadi — bosilsa profilga oʻtadi.                                        |
| Reyting yulduzchalari (masalan 4.8 ⭐)                                 | Bosiladi              | Shu advokatga yozilgan barcha sharhlar roʻyxati pastga ochiladi (advokat profiliga oʻtmasdan, shu joyning oʻzida kengayadi — accordion). |
| "Bogʻlanish" / "Konsultatsiya boshlash" tugmasi (har bir kartochkada) | Bosiladi              | Toʻlov tasdiqlash oynasi (modal) ochiladi: narx, davomiylik (30 daqiqa), toʻlov usuli tanlash (4-boʻlimga qarang).                       |
| "Filtrlarni tozalash" tugmasi                                         | Bosiladi              | Barcha qoʻllanilgan filtrlar bekor qilinadi, toʻliq roʻyxat qayta yuklanadi.                                                             |
| Orqaga qaytish strelkasi (yuqori chap)                                | Bosiladi              | Bosh sahifaga qaytadi.                                                                                                                   |

---

## 3. Advokat / Yurist Profili Sahifasi

*Advokat kartochkasidagi ism yoki avatar bosilganda ochiladigan toʻliq profil.*

| Element / Ikonka                                                       | Bosilganda amal               | Natijada nima chiqadi                                                                                                                        |
|------------------------------------------------------------------------|-------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| "✅ Tasdiqlangan advokat" yoki "Yurist-konsultant" belgisi              | Bosiladi                      | "Bu status nimani anglatadi?" degan qisqa tushuntirish oynasi (litsenziya raqami va tekshiruv sanasi bilan) ochiladi.                        |
| "Sohalar" bloki (masalan: Meros, Oila teglari)                         | Har bir teg bosiladi          | Shu soha boʻyicha advokatlar roʻyxatiga (2-boʻlim) oʻtadi, joriy advokat yuqorida ajratib koʻrsatiladi.                                      |
| "Sharhlar" boʻlimi                                                     | Bosiladi (yoki pastga skroll) | Barcha mijoz sharhlari sana va yulduzcha bilan roʻyxat koʻrinishida chiqadi; "Koʻproq koʻrsatish" tugmasi orqali sahifalanadi.               |
| "Statistika" bloki (masalan: "350+ konsultatsiya", "2 yillik tajriba") | Bosiladi                      | Interaktiv emas — faqat maʼlumot koʻrsatuvchi statik blok.                                                                                   |
| "Konsultatsiya boshlash" asosiy tugma (pastda, doim koʻrinadigan)      | Bosiladi                      | Toʻlov tasdiqlash oynasi ochiladi (4-boʻlim).                                                                                                |
| "Shikoyat qilish" (kichik matn, profil pastida)                        | Bosiladi                      | Faqat avval shu advokat bilan konsultatsiya boʻlgan foydalanuvchilarga koʻrinadi; bosilsa nizo ochish formasi ochiladi (9-boʻlim, PRD v2.0). |

---

## 4. Toʻlov Oynasi va Konsultatsiya Jarayoni

### 4.1 Toʻlov tasdiqlash oynasi (modal)

| Element / Ikonka                             | Bosilganda amal | Natijada nima chiqadi                                                                                                                                              |
|----------------------------------------------|-----------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Toʻlov usuli ikonkalari (Click, Payme, Uzum) | Biri tanlanadi  | Tanlangan usul ajratib koʻrsatiladi (chegara chiziq bilan), "Toʻlash" tugmasi faollashadi.                                                                         |
| "Toʻlash" tugmasi                            | Bosiladi        | Tanlangan toʻlov tizimining oʻz sahifasiga (yoki SDK oynasiga) yoʻnaltiriladi; toʻlov tasdiqlangach avtomatik ravishda chat/qoʻngʻiroq ekraniga (4.2) oʻtkaziladi. |
| "Bekor qilish" (X belgisi, yuqori burchak)   | Bosiladi        | Modal yopiladi, foydalanuvchi avvalgi ekranga (profil yoki roʻyxat) qaytadi, hech qanday toʻlov amalga oshmaydi.                                                   |

### 4.2 Chat / Qoʻngʻiroq Ekrani (Konsultatsiya seansi)

| Element / Ikonka                                 | Bosilganda amal        | Natijada nima chiqadi                                                                                                                                           |
|--------------------------------------------------|------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Taymer (yuqorida, masalan "29:41")               | Avtomatik ishlaydi     | Har soniyada kamayadi; 5:00 qolganda rangi sariqqa, 1:00 qolganda qizilga oʻzgaradi va ogohlantirish push-xabari chiqadi.                                       |
| Video-qoʻngʻiroq ikonkasi (kamera belgisi)       | Bosiladi               | Video-qoʻngʻiroq oynasi ochiladi, ikkala tomonga kamera va mikrofonga ruxsat soʻraladi.                                                                         |
| Audio-qoʻngʻiroq ikonkasi (telefon belgisi)      | Bosiladi               | Faqat ovozli qoʻngʻiroq boshlanadi (kamera ishlatilmaydi).                                                                                                      |
| Fayl biriktirish ikonkasi (skrepka)              | Bosiladi               | Qurilma galereyasi/fayllar oynasi ochiladi; tanlangan fayl (rasm, PDF, hujjat) chatga yuklanadi va skanerlanadi (xavfsizlik uchun).                             |
| Matn kiritish maydoni + "Yuborish" tugmasi       | Matn yozilib, bosiladi | Xabar chatga qoʻshiladi; agar matnda taqiqlangan format (telefon, @, karta raqami) aniqlansa, xabar yuborilmaydi va ogohlantirish chiqadi (PRD v2.0, 6-boʻlim). |
| "+15 daqiqa" tugmasi                             | Bosiladi               | Qoʻshimcha toʻlov tasdiqlash mini-oynasi chiqadi (asosiy narxning 50%), tasdiqlansa taymerga +15:00 qoʻshiladi.                                                 |
| "Nizo ochish" ikonkasi (⚠ belgisi, pastki menyu) | Bosiladi               | Shikoyat sababi tanlanadigan forma ochiladi ("Advokat javob bermadi", "Sifatsiz maslahat", "Boshqa") — PRD v2.0, 9-boʻlim jarayoni ishga tushadi.               |
| "Seansni yakunlash" tugmasi (qizil, pastda)      | Bosiladi               | Tasdiqlash soʻraladi ("Haqiqatan ham yakunlaysizmi?"), tasdiqlansa seans yopiladi va reyting oynasiga (4.3) oʻtiladi.                                           |

### 4.3 Seans Yakunida — Reyting Oynasi

| Element / Ikonka                 | Bosilganda amal | Natijada nima chiqadi                                                                                 |
|----------------------------------|-----------------|-------------------------------------------------------------------------------------------------------|
| Yulduzcha reytingi (1–5 ⭐)       | Bosiladi        | Tanlangan son yulduzcha ajratib (toʻldirilgan) koʻrsatiladi; "Sharh yozish" matn maydoni faollashadi. |
| Sharh matn maydoni               | Matn kiritiladi | Ixtiyoriy — boʻsh qoldirish mumkin.                                                                   |
| "Yuborish" tugmasi               | Bosiladi        | Reyting va sharh advokat profiliga qoʻshiladi, foydalanuvchi "Buyurtmalarim" sahifasiga qaytariladi.  |
| "Oʻtkazib yuborish" (skip) matni | Bosiladi        | Reyting qoʻyilmasdan toʻgʻridan-toʻgʻri "Buyurtmalarim" sahifasiga qaytadi.                           |

---

## 5. Hujjatlar Konstruktori

### 5.1 Hujjat turlari roʻyxati

| Element / Ikonka                                                 | Bosilganda amal | Natijada nima chiqadi                                                                                                                                                                              |
|------------------------------------------------------------------|-----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| "Ariza" kategoriyasi ikonkasi                                    | Bosiladi        | Ariza turlari roʻyxati ochiladi (masalan: ish beruvchiga ariza, davlat organiga ariza).                                                                                                            |
| "Shartnoma" kategoriyasi ikonkasi                                | Bosiladi        | Shartnoma turlari roʻyxati ochiladi (ijara, mehnat shartnomasi loyihasi).                                                                                                                          |
| "Sudga daʼvo arizasi" kategoriyasi ikonkasi                      | Bosiladi        | Daʼvo arizasi shablon turlari roʻyxati ochiladi (soha boʻyicha: oila, mehnat, mulk).                                                                                                               |
| Notarial hujjat (masalan "Ishonchnoma") kartasi                  | Bosiladi        | Generatsiya formasi OCHILMAYDI — buning oʻrniga "Bu hujjat notarial tasdiqni talab qiladi" degan oynada "Vakolat.uz" havolasi yoki eng yaqin notarius roʻyxati koʻrsatiladi (PRD v2.0, 3C-boʻlim). |
| Har bir shablon kartochkasidagi "Namuna koʻrish" (koʻz ikonkasi) | Bosiladi        | Hujjatning boʻsh (maʼlumotsiz) namunasi PDF preview sifatida ochiladi, faqat oʻqish uchun.                                                                                                         |

### 5.2 Maʼlumot Kiritish Formasi

| Element / Ikonka                                        | Bosilganda amal | Natijada nima chiqadi                                                                                                                                                                        |
|---------------------------------------------------------|-----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Input maydonlar (Ism, Familiya, Pasport, Summa va h.k.) | Toʻldiriladi    | Har bir maydon toʻldirilgach yashil belgi (✓) chiqadi; notoʻgʻri format kiritilsa (masalan pasport formatida xato) qizil xato matni chiqadi.                                                 |
| "Generatsiya qilish" tugmasi                            | Bosiladi        | Agar barcha majburiy maydonlar toʻldirilgan boʻlsa — toʻlov oynasi (agar pullik boʻlsa) yoki toʻgʻridan-toʻgʻri PDF generatsiya jarayoni (agar B2B limit doirasida bepul boʻlsa) boshlanadi. |
| Yuklanish animatsiyasi ("PDF tayyorlanmoqda...")        | Avtomatik       | 2-5 soniya ichida tugaydi va natija sahifasiga oʻtadi.                                                                                                                                       |
| Natija sahifasi — "Yuklab olish" tugmasi                | Bosiladi        | PDF fayl qurilmaga yuklab olinadi.                                                                                                                                                           |
| Natija sahifasi — "Ulashish" ikonkasi                   | Bosiladi        | Qurilmaning standart ulashish menyusi (Telegram, Email, boshqa ilovalarga yuborish) ochiladi.                                                                                                |
| Natija sahifasi — "Yana bir hujjat yaratish" tugmasi    | Bosiladi        | Hujjat turlari roʻyxatiga (5.1) qaytadi.                                                                                                                                                     |

---

## 6. Davlat Boji Kalkulyatori

| Element / Ikonka                       | Bosilganda amal  | Natijada nima chiqadi                                                                                                    |
|----------------------------------------|------------------|--------------------------------------------------------------------------------------------------------------------------|
| "Sud turi" dropdown (tanlov maydoni)   | Bosiladi         | Variantlar roʻyxati ochiladi: Fuqarolik ishlari, Xoʻjalik ishlari, Maʼmuriy ishlari va h.k.                              |
| "Daʼvo summasi" input maydoni          | Raqam kiritiladi | Kiritilgan raqam avtomatik minglik ajratgich bilan formatlanadi (masalan 1 000 000).                                     |
| "Hisoblash" tugmasi                    | Bosiladi         | Natija bloki pastda ochiladi: aniq boj summasi soʻmda, hisoblash formulasi qisqacha tushuntirilgan holda ("BHM x foiz"). |
| "Natijani saqlash / yuborish" ikonkasi | Bosiladi         | Hisoblangan natija PDF yoki matn koʻrinishida ulashish/yuklab olish uchun tayyorlanadi.                                  |

---

## 7. Huquqiy Koʻrsatmalar Bazasi

| Element / Ikonka                          | Bosilganda amal | Natijada nima chiqadi                                                                                                   |
|-------------------------------------------|-----------------|-------------------------------------------------------------------------------------------------------------------------|
| Kategoriya filtri (masalan "Oila huquqi") | Bosiladi        | Shu kategoriyadagi maqolalar roʻyxati chiqadi.                                                                          |
| Maqola sarlavhasi/kartochkasi             | Bosiladi        | Toʻliq maqola matni ochiladi; pastida "Foydali boʻldimi?" 👍👎 tugmalari va "Shu mavzuda advokatga yozish" tugmasi bor. |
| "Shu mavzuda advokatga yozish" tugmasi    | Bosiladi        | Maqola mavzusiga mos sohadagi advokatlar roʻyxatiga (2-boʻlim) oʻtkazadi.                                               |
| Qidiruv maydoni (yuqorida)                | Matn kiritiladi | Barcha maqolalar orasidan mos keluvchilar real-vaqtda pastda roʻyxat sifatida chiqadi.                                  |

---

## 8. Advokat / Yurist Kabineti

| Element / Ikonka                                          | Bosilganda amal | Natijada nima chiqadi                                                                                                                                            |
|-----------------------------------------------------------|-----------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Onlayn/Oflayn katta tugma (yuqorida, switch koʻrinishida) | Bosiladi        | Holat oʻzgaradi (yashil = onlayn, kulrang = oflayn); onlaynda yangi soʻrovlar kela boshlaydi, oflaynda toʻxtaydi.                                                |
| Kelib tushgan soʻrov kartochkasi — "Qabul qilish" tugmasi | Bosiladi        | Chat/qoʻngʻiroq ekrani (4.2 bilan bir xil, lekin advokat tomonidan) ochiladi.                                                                                    |
| Kelib tushgan soʻrov kartochkasi — "Rad etish" tugmasi    | Bosiladi        | Soʻrov keyingi navbatdagi mos advokatga avtomatik yoʻnaltiriladi, joriy advokat statistikasida "rad etish" hisoblanadi (koʻp rad etish reytingga taʼsir qiladi). |
| Balans ikonkasi (hamyon belgisi)                          | Bosiladi        | Joriy balans, kirim-chiqim tarixi va "Pulni yechib olish" tugmasi boʻlgan sahifa ochiladi.                                                                       |
| "Pulni yechib olish" (Withdrawal) tugmasi                 | Bosiladi        | Karta raqami tasdiqlash va summa kiritish formasi ochiladi; yuborilgach "Soʻrov qabul qilindi, 24 soat ichida koʻrib chiqiladi" xabari chiqadi.                  |
| "Sohalarim" boʻlimi (qalam/tahrirlash ikonkasi)           | Bosiladi        | Advokat oʻz ixtisoslik sohalarini qoʻshish/olib tashlash roʻyxatini tahrirlaydi (checkbox koʻrinishida).                                                         |
| "Litsenziya holati" bloki                                 | Bosiladi        | Litsenziya raqami, tasdiqlangan sana va (agar rad etilgan boʻlsa) sababi koʻrsatiladi; "Qayta yuklash" tugmasi orqali yangi hujjat yuklash mumkin.               |
| "Statistikam" boʻlimi                                     | Bosiladi        | Grafik koʻrinishida oylik daromad, konsultatsiyalar soni va oʻrtacha reyting koʻrsatiladi.                                                                       |

---

## 9. B2B (Biznes) Kabineti

| Element / Ikonka                                      | Bosilganda amal | Natijada nima chiqadi                                                                                                                                           |
|-------------------------------------------------------|-----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| "Joriy tarif" bloki (masalan "Standart")              | Bosiladi        | Tarif tafsilotlari (limitlar, qolgan hujjat/konsultatsiya soni, keyingi toʻlov sanasi) ochiladi.                                                                |
| "Tarifni oʻzgartirish" tugmasi                        | Bosiladi        | Barcha tarif paketlari solishtirma jadval koʻrinishida chiqadi, tanlangach toʻlov tasdiqlanadi va yangi tarif keyingi toʻlov davridan kuchga kiradi.            |
| "Hujjat generatsiya qilish" tugmasi                   | Bosiladi        | Agar oylik limit tugamagan boʻlsa — hujjat konstruktoriga (5-boʻlim) bepul rejimda oʻtadi; limit tugagan boʻlsa — 20% chegirmali pullik rejimga taklif chiqadi. |
| "Konsultatsiya buyurtma qilish" tugmasi               | Bosiladi        | Advokatlar roʻyxatiga (2-boʻlim) B2B rejimida (limit hisobidan) oʻtadi.                                                                                         |
| "Xodimlar" boʻlimi (agar tarif ruxsat bersa)          | Bosiladi        | Kompaniya nomidan foydalanadigan qoʻshimcha xodim hisoblarini qoʻshish/oʻchirish roʻyxati ochiladi.                                                             |
| "Toʻlov tarixi" boʻlimi                               | Bosiladi        | Barcha oylik toʻlovlar va fiskal cheklar roʻyxati chiqadi, har biri yonida "Yuklab olish" (chek) tugmasi bor.                                                   |
| "Obunani bekor qilish" havolasi (pastda, kichik matn) | Bosiladi        | Tasdiqlash oynasi chiqadi ("Joriy oy oxirigacha xizmat davom etadi"), tasdiqlansa avtomatik toʻlov oʻchiriladi.                                                 |

---

## 10. Admin Panel

### 10.1 Chap Menyu Ikonkalari

| Element / Ikonka                           | Bosilganda amal | Natijada nima chiqadi                                                                                                                                                       |
|--------------------------------------------|-----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| "Foydalanuvchilar" ikonkasi                | Bosiladi        | Barcha mijozlar, advokatlar va yuristlar roʻyxati (qidiruv/filtr bilan) ochiladi.                                                                                           |
| "Moderatsiya" ikonkasi                     | Bosiladi        | Litsenziya tasdiqlashni kutayotgan advokat/yurist arizalari roʻyxati chiqadi; har birida "Koʻrish", "Tasdiqlash", "Rad etish" tugmalari bor.                                |
| Moderatsiya roʻyxatidagi "Koʻrish" tugmasi | Bosiladi        | Yuklangan litsenziya hujjati kattalashtirilgan holda, "Litsenziya" tizimida qoʻlda tekshirish uchun havola bilan koʻrsatiladi.                                              |
| "Tranzaksiyalar" ikonkasi                  | Bosiladi        | Barcha toʻlovlar, komissiyalar va withdrawal soʻrovlari jadvali ochiladi; "Withdrawal"lar yonida "Tasdiqlash" tugmasi bor.                                                  |
| "Nizolar (Arbitraj)" ikonkasi              | Bosiladi        | Ochiq va yopilgan nizolar roʻyxati chiqadi; har bir nizo bosilganda chat tarixi, ikkala tomon izohi va "Qaror qabul qilish" formasi ochiladi (PRD v2.0, 9-boʻlim jarayoni). |
| "Kontent" ikonkasi                         | Bosiladi        | Huquqiy koʻrsatmalar maqolalari va hujjat shablonlarini qoʻshish/tahrirlash/oʻchirish paneli ochiladi.                                                                      |
| "Analitika" ikonkasi                       | Bosiladi        | Umumiy platforma statistikasi: daromad, faol foydalanuvchilar, eng koʻp soʻralgan sohalar grafiklari.                                                                       |
| "Sozlamalar" ikonkasi                      | Bosiladi        | Sohalar boʻyicha narxlarni, BHM qiymatini, komissiya foizini oʻzgartirish paneli ochiladi.                                                                                  |

---

## 💡 Eslatma

Ushbu hujjat PRD v2.0 bilan birga ishlatilishi kerak — u yerda biznes mantiq va qoidalar, bu yerda
esa har bir ekran va tugmaning aniq xatti-harakati yozilgan. Dizayner (UI/UX) ushbu hujjat asosida
wireframe va Figma maketlarini tayyorlashi, dasturchi esa har bir elementni aynan shu tavsifga mos
qilib ishlab chiqishi tavsiya etiladi.
