/// Matn/son formatlash uchun sof (pure) yordamchi funksiyalar.
///
/// Hech qanday Flutter bog'liqligi yo'q — bemalol unit-test qilinadi.
class Formatters {
  const Formatters._();

  /// Sonni "150 000" ko'rinishida (probel bilan) formatlaydi.
  static String money(num value) {
    final str = value.round().abs().toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i != 0 && (str.length - i) % 3 == 0) buffer.write(' ');
      buffer.write(str[i]);
    }
    final sign = value < 0 ? '-' : '';
    return '$sign$buffer';
  }

  /// "150 000 so'm" ko'rinishi.
  static String soum(num value) => "${money(value)} so'm";

  /// Sekundlarni "MM:SS" ko'rinishida qaytaradi.
  static String timer(int totalSeconds) {
    final safe = totalSeconds < 0 ? 0 : totalSeconds;
    final m = (safe ~/ 60).toString().padLeft(2, '0');
    final s = (safe % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  /// Ism-familiyadan bosh harflar (masalan "Dilnoza Karimova" → "DK").
  static String initials(String fullName) {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return (parts[0].substring(0, 1) + parts[1].substring(0, 1)).toUpperCase();
  }
}

/// Anti-chetlab o'tish (anti-disintermediation) filtri.
///
/// Chatда telefon raqami, Telegram, karta kabi taqiqlangan formatlar
/// borligini aniqlaydi. PRD 5-bo'lim talabiga muvofiq.
class ContactGuard {
  const ContactGuard._();

  static final List<RegExp> _patterns = [
    RegExp(r'\+?998[\s\-]?\d{2}', caseSensitive: false), // +998 telefon
    RegExp(r'\b\d{2}[\s\-]?\d{3}[\s\-]?\d{2}[\s\-]?\d{2}\b'), // 90 123 45 67
    RegExp(r'@\w{3,}'), // Telegram username
    RegExp(r'\bt\.me/', caseSensitive: false),
    RegExp(r'\btelegram\b', caseSensitive: false),
    RegExp(r'\bkarta\b', caseSensitive: false),
    RegExp(r'\bpayme\b', caseSensitive: false),
    RegExp(r'\bclick\b', caseSensitive: false),
    RegExp(r'\b\d{4}[\s\-]?\d{4}[\s\-]?\d{4}[\s\-]?\d{4}\b'), // karta raqami
  ];

  /// Matnda taqiqlangan format bor-yo'qligini tekshiradi.
  static bool isBlocked(String text) {
    return _patterns.any((p) => p.hasMatch(text));
  }
}
