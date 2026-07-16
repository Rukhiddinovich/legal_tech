import '../models/lawyer_model.dart';
import '../models/review_model.dart';

/// Advokatlar uchun ma'lumot manbai abstraksiyasi.
///
/// Bugun mock, ertaga `LawyerRemoteDataSource` — repository o'zgarmaydi.
abstract interface class LawyerDataSource {
  Future<List<LawyerModel>> fetchLawyers();
  Future<List<ReviewModel>> fetchReviews(String lawyerId);
}

/// Dizayn maketiga mos statik (in-memory) ma'lumotlar.
class LawyerMockDataSource implements LawyerDataSource {
  /// Real tarmoq kechikishini taqlid qilish uchun kichik kechikish.
  static const _latency = Duration(milliseconds: 350);

  @override
  Future<List<LawyerModel>> fetchLawyers() async {
    await Future<void>.delayed(_latency);
    return _lawyers.map(LawyerModel.fromJson).toList();
  }

  @override
  Future<List<ReviewModel>> fetchReviews(String lawyerId) async {
    await Future<void>.delayed(_latency);
    final list = _reviews[lawyerId] ?? _reviews['default']!;
    return list.map(ReviewModel.fromJson).toList();
  }

  static final List<Map<String, dynamic>> _lawyers = [
    {
      'id': 'l1',
      'full_name': 'Dilnoza Karimova',
      'specialization': 'Meros va oila huquqi · 12 yil',
      'experience_years': 12,
      'rating': 4.9,
      'reviews_count': 128,
      'consultations_count': 340,
      'price_per_session': 150000,
      'session_minutes': 30,
      'is_online': true,
      'tags': ['Meros', 'Oila'],
      'directions': [
        'Meros nizolari',
        'Ajrim & aliment',
        'Nikoh shartnomasi',
        'Vasiylik',
      ],
      'about':
          'Toshkent Davlat Yuridik Universiteti bitiruvchisi. Fuqarolik va '
              'oila ishlari bo\'yicha 12 yillik amaliyot. Meros bo\'linishi va '
              'aliment nizolarida 340+ mijozga yordam bergan.',
      'area_ids': ['inheritance', 'family'],
    },
    {
      'id': 'l2',
      'full_name': 'Sardor Aliyev',
      'specialization': 'Soliq va biznes huquqi · 9 yil',
      'experience_years': 9,
      'rating': 4.8,
      'reviews_count': 96,
      'consultations_count': 210,
      'price_per_session': 200000,
      'session_minutes': 30,
      'is_online': true,
      'tags': ['Soliqlar', 'B2B'],
      'directions': [
        'Soliq nizolari',
        'Biznes ro\'yxatdan o\'tkazish',
        'Shartnomalar',
        'Litsenziya',
      ],
      'about':
          'Biznes va soliq huquqi bo\'yicha 9 yillik tajriba. Tadbirkorlarga '
              'soliq optimizatsiyasi va nizolarni hal qilishda yordam beradi.',
      'area_ids': ['taxes'],
    },
    {
      'id': 'l3',
      'full_name': 'Nodira Yusupova',
      'specialization': 'Mehnat huquqi · 7 yil',
      'experience_years': 7,
      'rating': 4.7,
      'reviews_count': 74,
      'consultations_count': 155,
      'price_per_session': 120000,
      'session_minutes': 30,
      'is_online': true,
      'tags': ['Mehnat', 'Nizolar'],
      'directions': [
        'Ishdan bo\'shatish',
        'Mehnat shartnomasi',
        'Ish haqi nizolari',
      ],
      'about':
          'Mehnat munosabatlari bo\'yicha mutaxassis. Xodim va ish beruvchi '
              'o\'rtasidagi nizolarni sudgacha hal qilishga ixtisoslashgan.',
      'area_ids': ['labor'],
    },
    {
      'id': 'l4',
      'full_name': "John Doe",
      'specialization': 'Jinoyat huquqi · 15 yil',
      'experience_years': 15,
      'rating': 5.0,
      'reviews_count': 203,
      'consultations_count': 480,
      'price_per_session': 250000,
      'session_minutes': 30,
      'is_online': false,
      'tags': ['Jinoyat', 'Himoya'],
      'directions': [
        'Jinoyat ishlarida himoya',
        'Sud jarayoni',
        'Apellyatsiya',
      ],
      'about':
          'Jinoyat huquqi bo\'yicha 15 yillik advokatlik amaliyoti. Sud '
              'jarayonlarida mijoz manfaatlarini himoya qilishda katta tajriba.',
      'area_ids': ['criminal'],
    },
    {
      'id': 'l5',
      'full_name': 'Kamola Rashidova',
      'specialization': 'Ko\'chmas mulk huquqi · 8 yil',
      'experience_years': 8,
      'rating': 4.6,
      'reviews_count': 61,
      'consultations_count': 132,
      'price_per_session': 180000,
      'session_minutes': 30,
      'is_online': true,
      'tags': ['Ko\'chmas mulk', 'Oldi-sotdi'],
      'directions': [
        'Uy-joy oldi-sotdisi',
        'Ijara shartnomalari',
        'Kadastr nizolari',
      ],
      'about':
          'Ko\'chmas mulk bitimlari va nizolari bo\'yicha huquqiy yordam. '
              'Oldi-sotdi shartnomalarini yuridik jihatdan xavfsiz rasmiylashtiradi.',
      'area_ids': ['realestate'],
    },
  ];

  static final Map<String, List<Map<String, dynamic>>> _reviews = {
    'default': [
      {
        'id': 'r1',
        'author_name': 'Malika T.',
        'rating': 5,
        'text':
            'Meros masalasini juda tez va tushunarli hal qildi. Kerakli '
                'hujjatlarni ham darhol tayyorlab berdi. Rahmat!',
        'verified': true,
      },
      {
        'id': 'r2',
        'author_name': 'Bekzod A.',
        'rating': 5,
        'text':
            'Savolimga aniq va professional javob oldim. Vaqtni behuda '
                'sarflamadik.',
        'verified': true,
      },
      {
        'id': 'r3',
        'author_name': 'Sevara N.',
        'rating': 4,
        'text': 'Yaxshi maslahat berdi, hujjat namunasini yubordi.',
        'verified': true,
      },
    ],
  };
}
