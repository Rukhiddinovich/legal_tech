import 'package:hive/hive.dart';

/// ThemeHiveService - Hive asosida mavzu sozlamalarini saqlash
class ThemeHiveService {
  static const String _boxName = 'themeBox';
  static const String _themeKey = 'CACHED_THEME';

  late Box _box;
  bool _isInitialized = false;

  /// Box ochilganligini tekshirish
  bool get isInitialized => _isInitialized;

  /// Hive box ni ochish
  Future<void> initialize() async {
    if (!_isInitialized) {
      _box = await Hive.openBox(_boxName);
      _isInitialized = true;
    }
  }

  /// Mavzu sozlamasini saqlash
  Future<void> setTheme(String themeMode) async {
    await _box.put(_themeKey, themeMode);
  }

  /// Mavzu sozlamasini olish
  String? getTheme() {
    return _box.get(_themeKey);
  }

  /// Mavzu sozlamasini o'chirish
  Future<void> clearTheme() async {
    await _box.delete(_themeKey);
  }

  /// Box ni yopish
  Future<void> close() async {
    if (_isInitialized && Hive.isBoxOpen(_boxName)) {
      await _box.close();
      _isInitialized = false;
    }
  }
}
