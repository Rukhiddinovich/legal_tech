import 'package:legal_tech/core/storage/auth_hive_service.dart';
import 'package:legal_tech/core/storage/language_hive_service.dart';
import 'package:legal_tech/core/storage/theme_hive_service.dart';

/// AppStorageService - Barcha storage xizmatlarini boshqaruvchi singleton
///
/// Bu servis ilovaning barcha storage xizmatlarini bir joyda jamlaydi.
/// Foydalanish:
/// ```dart
/// await AppStorageService.instance.initialize();
/// AppStorageService.instance.auth.saveToken('token');
/// ```
class AppStorageService {
  static final AppStorageService _instance = AppStorageService._internal();
  static AppStorageService get instance => _instance;

  AppStorageService._internal();

  late final AuthHiveService _auth;
  late final ThemeHiveService _theme;
  late final LanguageHiveService _language;

  bool _isInitialized = false;

  /// Auth storage xizmati
  AuthHiveService get auth => _auth;

  /// Theme storage xizmati
  ThemeHiveService get theme => _theme;

  /// Language storage xizmati
  LanguageHiveService get language => _language;

  /// Barcha storage xizmatlarini ishga tushirish
  Future<void> initialize() async {
    if (_isInitialized) return;

    _auth = AuthHiveService();
    _theme = ThemeHiveService();
    _language = LanguageHiveService();

    await Future.wait([
      _auth.initialize(),
      _theme.initialize(),
      _language.initialize(),
    ]);

    _isInitialized = true;
  }

  /// Barcha storage xizmatlarini yopish
  Future<void> close() async {
    if (!_isInitialized) return;

    await Future.wait([_auth.close(), _theme.close(), _language.close()]);

    _isInitialized = false;
  }

  /// Barcha cache'larni tozalash
  Future<void> clearAll() async {
    await _auth.clearAuthData();
    await _auth.clearOnboardingData();
    await _theme.clearTheme();
    await _language.clearLanguage();
  }
}
