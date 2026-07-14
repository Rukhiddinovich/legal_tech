import 'package:hive/hive.dart';

/// LanguageHiveService - Hive asosida til sozlamalarini saqlash
class LanguageHiveService {
  static const String _boxName = 'languageBox';
  static const String _localeKey = 'selected_locale';

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

  /// Til saqlash
  Future<void> saveLanguage(String languageCode) async {
    await _box.put(_localeKey, languageCode);
  }

  /// Til olish (sinxron)
  String? getSavedLanguage() {
    return _box.get(_localeKey);
  }

  /// Til o'chirish
  Future<void> clearLanguage() async {
    await _box.delete(_localeKey);
  }

  /// Box ni yopish
  Future<void> close() async {
    if (_isInitialized && Hive.isBoxOpen(_boxName)) {
      await _box.close();
      _isInitialized = false;
    }
  }
}
