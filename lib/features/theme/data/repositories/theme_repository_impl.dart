import 'package:flutter/material.dart';

import '../../domain/repositories/theme_repository.dart';

/// [ThemeRepository] ning oddiy in-memory implementatsiyasi.
///
/// Backend talab qilinmagani uchun holat sessiya davomida xotirada saqlanadi.
/// Kelajakda Hive/SharedPreferences bilan almashtirish uchun yetarli —
/// prezentatsiya qatlami o'zgarmaydi.
class ThemeRepositoryImpl implements ThemeRepository {
  ThemeMode _mode = ThemeMode.light;

  @override
  ThemeMode getThemeMode() => _mode;

  @override
  Future<void> saveThemeMode(ThemeMode mode) async {
    _mode = mode;
  }
}
