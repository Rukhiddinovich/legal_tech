import '../../domain/entities/law_area.dart';

/// Huquq sohalari uchun ma'lumot manbai.
abstract interface class LawAreaDataSource {
  Future<List<LawArea>> fetchAreas();
}

/// Dizaynga mos statik sohalar ro'yxati.
class LawAreaMockDataSource implements LawAreaDataSource {
  @override
  Future<List<LawArea>> fetchAreas() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return const [
      LawArea(id: 'inheritance', name: 'Meros', abbrev: 'M'),
      LawArea(id: 'family', name: 'Oila', abbrev: 'O'),
      LawArea(id: 'taxes', name: 'Soliqlar', abbrev: 'S'),
      LawArea(id: 'criminal', name: 'Jinoyat', abbrev: 'J'),
      LawArea(id: 'labor', name: 'Mehnat', abbrev: 'Me'),
      LawArea(id: 'realestate', name: 'Ko\'chmas mulk', abbrev: 'Ko'),
    ];
  }
}
