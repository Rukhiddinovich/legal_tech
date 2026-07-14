import 'package:legal_tech/core/errors/exceptions.dart';
import 'package:legal_tech/core/storage/theme_hive_service.dart';
import 'package:legal_tech/features/theme/domain/entities/theme_entity.dart';
import '../models/theme_model.dart';

abstract class ThemeLocalDataSource {
  Future<ThemeModel> getTheme();
  Future<void> setTheme(ThemeModel theme);
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final ThemeHiveService themeHiveService;

  ThemeLocalDataSourceImpl({required this.themeHiveService});

  @override
  Future<ThemeModel> getTheme() async {
    try {
      final themeString = themeHiveService.getTheme();
      if (themeString != null) {
        return ThemeModel.fromString(themeString);
      } else {
        return const ThemeModel(themeMode: AppThemeMode.system);
      }
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<void> setTheme(ThemeModel theme) async {
    try {
      await themeHiveService.setTheme(theme.toStorageString());
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}
