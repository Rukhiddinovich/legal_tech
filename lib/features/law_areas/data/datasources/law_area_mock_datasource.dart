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
      LawArea(id: 'family', name: 'Oila', abbrev: 'O', priceText: "100 000\nso'm/30 daq"),
      LawArea(id: 'inheritance', name: 'Meros', abbrev: 'M', priceText: "150 000\nso'm/30 daq"),
      LawArea(id: 'taxes', name: 'Soliq', abbrev: 'S', priceText: "120 000\nso'm/30 daq"),
      LawArea(id: 'criminal', name: 'Jinoyat', abbrev: 'J', priceText: "200 000\nso'm/30 daq"),
      LawArea(id: 'labor', name: 'Mehnat', abbrev: 'Me', priceText: "100 000\nso'm/30 daq"),
      LawArea(id: 'business', name: 'Tadbirkorlik', abbrev: 'Ta', priceText: "180 000\nso'm/30 daq"),
    ];
  }
}
