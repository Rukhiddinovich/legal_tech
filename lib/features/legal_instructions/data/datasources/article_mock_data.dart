import '../../domain/entities/article.dart';

abstract interface class ArticleDataSource {
  Future<List<Article>> fetchArticles();
}

class ArticleMockDataSource implements ArticleDataSource {
  @override
  Future<List<Article>> fetchArticles() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return const [
      Article(
        id: 'art1',
        title: "Merosxo'rlar o'rtasida mulkni taqsimlash tartibi",
        category: 'Meros huquqi',
        areaId: 'inheritance',
        content: "Meros mulkini taqsimlash O'zbekiston Respublikasi Fuqarolik Kodeksining tegishli moddalariga asosan amalga oshiriladi. Meros qoldiruvchining vasiyatnomasi bo'lsa, mulk vasiyatnomaga muvofiq taqsimlanadi. Vasiyatnoma bo'lmaganda esa qonuniy navbat bo'yicha vorislar o'rtasida teng ulushlarda bo'linadi. Merosni qabul qilish muddati — meros ochilgan kundan boshlab 6 oyni tashkil etadi. Agar ushbu muddat o'tib ketgan bo'lsa, uni sud tartibida tiklash lozim bo'ladi.",
      ),
      Article(
        id: 'art2',
        title: 'Nikoh shartnomasi qanday tuziladi?',
        category: 'Oila huquqi',
        areaId: 'family',
        content: "Nikoh shartnomasi — nikohlanuvchi shaxslarning yoki er va xotinning nikohda bo'lgan davrida va (yoki) er-xotin nikohdan ajralgan taqdirda ularning mulkiy huquq hamda majburiyatlarini belgilovchi kelishuvidir. Ushbu shartnoma notarial tartibda tasdiqlanishi shart. Nikoh shartnomasida er-xotinning mavjud va kelgusida sotib olinadigan mol-mulkiga nisbatan birgalikdagi, ulushli yoki alohida egalik qilish tartibi belgilanishi mumkin.",
      ),
      Article(
        id: 'art3',
        title: 'Mehnat shartnomasini ish beruvchi tashabbusi bilan bekor qilish',
        category: 'Mehnat huquqi',
        areaId: 'labor',
        content: "Ish beruvchining tashabbusi bilan mehnat shartnomasini bekor qilish faqatgina qonunda ko'rsatilgan asoslar (shtat qisqarishi, xodimning malakasi yetarli emasligi, mehnat intizomini qo'pol ravishda buzilishi va h.k.) mavjud bo'lgandagina yo'l qo'yiladi. Ish beruvchi xodimni ogohlantirish muddati va tegishli kompensatsiya to'lovlarini amalga oshirishi shart. Aks holda mehnat shartnomasining bekor qilinishi noqonuniy deb hisoblanadi va xodim sud orqali ishga qayta tiklanishi mumkin.",
      ),
      Article(
        id: 'art4',
        title: 'Tadbirkorlik subyektlari uchun soliq imtiyozlari',
        category: 'Soliq huquqi',
        areaId: 'taxes',
        content: "Yangi tashkil etilgan tadbirkorlik subyektlari va ayrim sohalarda (AKT, turizm, eksport) faoliyat yurituvchi korxonalar uchun davlat tomonidan bir qator soliq imtiyozlari taqdim etiladi. Masalan, aylanmadan olinadigan soliqni soddalashtirilgan tartibda to'lash yoki ayrim soliq turlaridan (mol-mulk, yer) vaqtincha ozod bo'lish imkoniyatlari mavjud. Soliq kodeksida belgilangan imtiyozlarni qo'llash tartibini bilish korxonaning moliyaviy barqarorligini ta'minlashga xizmat qiladi.",
      ),
      Article(
        id: 'art5',
        title: 'Sud orqali mulk huquqini tiklash jarayoni',
        category: 'Tadbirkorlik huquqi',
        areaId: 'business',
        content: "Mulk huquqini buzilgan yoki tan olinmagan taqdirda sud tartibida tiklash huquq egasining arizasiga asosan ko'rib chiqiladi. Buning uchun fuqarolik yoki iqtisodiy sudga tegishli da'vo arizasi kiritiladi. Da'vo arizasida mulk huquqini tasdiqlovchi dalillar (shartnomalar, notarial hujjatlar, guvohnomalar) va davlat bojining to'langanligi haqidagi kvitansiya ilova qilinishi shart.",
      ),
    ];
  }
}
