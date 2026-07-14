import 'package:hive/hive.dart';

class AuthHiveService {
  static const String _boxName = 'authBox';

  // Storage keys
  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyUserId = 'user_id';
  static const String _keyPhoneNumber = 'phone_number';
  static const String _keyOnboardingSeen = 'onboarding_seen';
  static const String _keyUseBonus = 'use_bonus';

  late Box _box;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;
  Future<void> initialize() async {
    if (!_isInitialized) {
      _box = await Hive.openBox(_boxName);
      _isInitialized = true;
    }
  }

  // ============================================================
  // TOKEN OPERATIONS
  // ============================================================

  /// Access token saqlash
  Future<void> saveAccessToken(String token) async {
    await _box.put(_keyAccessToken, token);
  }

  /// Access token olish
  String? getAccessToken() {
    return _box.get(_keyAccessToken);
  }

  /// Access token o'chirish
  Future<void> removeAccessToken() async {
    await _box.delete(_keyAccessToken);
  }

  /// Refresh token saqlash
  Future<void> saveRefreshToken(String refreshToken) async {
    await _box.put(_keyRefreshToken, refreshToken);
  }

  /// Refresh token olish
  String? getRefreshToken() {
    return _box.get(_keyRefreshToken);
  }

  /// Refresh token o'chirish
  Future<void> removeRefreshToken() async {
    await _box.delete(_keyRefreshToken);
  }

  /// Token mavjudligini tekshirish
  bool hasToken() {
    final token = getAccessToken();
    return token != null && token.isNotEmpty;
  }

  // ============================================================
  // USER OPERATIONS
  // ============================================================

  /// User ID saqlash
  Future<void> saveUserId(String userId) async {
    await _box.put(_keyUserId, userId);
  }

  /// User ID olish
  String? getUserId() {
    return _box.get(_keyUserId);
  }

  /// User ID o'chirish
  Future<void> removeUserId() async {
    await _box.delete(_keyUserId);
  }

  /// Telefon raqam saqlash
  Future<void> savePhoneNumber(String phoneNumber) async {
    await _box.put(_keyPhoneNumber, phoneNumber);
  }

  /// Telefon raqam olish
  String? getPhoneNumber() {
    return _box.get(_keyPhoneNumber);
  }

  /// Telefon raqam o'chirish
  Future<void> removePhoneNumber() async {
    await _box.delete(_keyPhoneNumber);
  }

  // ============================================================
  // ONBOARDING OPERATIONS
  // ============================================================

  /// Onboarding ko'rilganligini saqlash
  Future<void> saveOnboardingSeen() async {
    await _box.put(_keyOnboardingSeen, true);
  }

  /// Onboarding ko'rilganligini tekshirish
  bool isOnboardingSeen() {
    return _box.get(_keyOnboardingSeen, defaultValue: false) as bool;
  }

  /// Onboarding ma'lumotlarini tozalash
  Future<void> clearOnboardingData() async {
    await _box.delete(_keyOnboardingSeen);
  }

  // ============================================================
  // BONUS OPERATIONS
  // ============================================================

  /// Bonusdan foydalanish holatini saqlash
  Future<void> saveUseBonus(bool value) async {
    await _box.put(_keyUseBonus, value);
  }

  /// Bonusdan foydalanish holatini olish
  bool getUseBonus() {
    return _box.get(_keyUseBonus, defaultValue: false) as bool;
  }

  // ============================================================
  // AUTH DATA OPERATIONS
  // ============================================================

  /// Barcha auth ma'lumotlarini saqlash
  Future<void> saveAuthData({
    required String accessToken,
    required String refreshToken,
    required String userId,
    String? phoneNumber,
  }) async {
    await saveAccessToken(accessToken);
    await saveRefreshToken(refreshToken);
    await saveUserId(userId);
    if (phoneNumber != null) {
      await savePhoneNumber(phoneNumber);
    }
  }

  /// Barcha auth ma'lumotlarini tozalash (logout)
  Future<void> clearAuthData() async {
    await removeAccessToken();
    await removeRefreshToken();
    await removeUserId();
    await removePhoneNumber();
  }

  /// Foydalanuvchi tizimga kirganligini tekshirish
  bool isLoggedIn() {
    return hasToken();
  }

  /// Box ni yopish
  Future<void> close() async {
    if (_isInitialized && Hive.isBoxOpen(_boxName)) {
      await _box.close();
      _isInitialized = false;
    }
  }
}
