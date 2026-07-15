import 'package:flutter/material.dart';

/// Mavzu (theme) holatini saqlash/olish uchun abstraksiya.
///
/// Prezentatsiya qatlami faqat shu interfeysga bog'lanadi (DIP) —
/// implementatsiya in-memory, Hive yoki API bo'lishi mumkin.
abstract interface class ThemeRepository {
  ThemeMode getThemeMode();
  Future<void> saveThemeMode(ThemeMode mode);
}
