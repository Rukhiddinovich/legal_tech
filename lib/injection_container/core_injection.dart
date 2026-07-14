import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:legal_tech/core/storage/app_storage_service.dart';
import 'package:legal_tech/core/storage/auth_hive_service.dart';
import 'package:legal_tech/core/storage/language_hive_service.dart';
import 'package:legal_tech/core/storage/theme_hive_service.dart';

import 'injection_container.dart';

Future<void> initCore() async {
  // Connectivity'ni ro'yxatdan o'tkazish
  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  // AppStorageService singleton registration and initialization of all storage services
  final appStorageService = AppStorageService.instance;
  await appStorageService.initialize();
  sl.registerSingleton<AppStorageService>(appStorageService);

  // Register individual Hive services from the initialized AppStorageService instance
  sl.registerSingleton<ThemeHiveService>(appStorageService.theme);
  sl.registerSingleton<AuthHiveService>(appStorageService.auth);
  sl.registerSingleton<LanguageHiveService>(appStorageService.language);
}
