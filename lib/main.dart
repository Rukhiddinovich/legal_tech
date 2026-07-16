import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/di/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('settings');

  // Bog'liqliklarni ishga tushirish (get_it).
  await initDependencies();

  // Status-bar ko'rinishini sozlash.
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('uz', 'UZ'), Locale('ru', 'RU')],
      path: 'assets/translations',
      fallbackLocale: const Locale('uz', 'UZ'),
      child: const Application(),
    ),
  );
}
