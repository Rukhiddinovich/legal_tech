import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/repositories/theme_repository.dart';

/// [ThemeRepository] ning Hive orqali saqlanadigan implementatsiyasi.
class ThemeRepositoryImpl implements ThemeRepository {
  final Box _box = Hive.box('settings');
  static const String _themeKey = 'themeMode';

  @override
  ThemeMode getThemeMode() {
    final String? themeStr = _box.get(_themeKey);
    if (themeStr == 'dark') return ThemeMode.dark;
    return ThemeMode.light;
  }

  @override
  Future<void> saveThemeMode(ThemeMode mode) async {
    final themeStr = mode == ThemeMode.dark ? 'dark' : 'light';
    await _box.put(_themeKey, themeStr);
  }
}
