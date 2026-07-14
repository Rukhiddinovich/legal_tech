import 'package:legal_tech/features/theme/domain/entities/theme_entity.dart';

class ThemeModel extends ThemeEntity {
  const ThemeModel({required super.themeMode});

  factory ThemeModel.fromString(String themeString) {
    AppThemeMode mode;
    switch (themeString) {
      case 'light':
        mode = AppThemeMode.light;
        break;
      case 'dark':
        mode = AppThemeMode.dark;
        break;
      case 'system':
      default:
        mode = AppThemeMode.system;
        break;
    }
    return ThemeModel(themeMode: mode);
  }

  String toStorageString() {
    switch (themeMode) {
      case AppThemeMode.light:
        return 'light';
      case AppThemeMode.dark:
        return 'dark';
      case AppThemeMode.system:
        return 'system';
    }
  }

  factory ThemeModel.fromEntity(ThemeEntity entity) {
    return ThemeModel(themeMode: entity.themeMode);
  }
}
