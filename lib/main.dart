import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legal_tech/application.dart';
import 'package:legal_tech/core/constants/constants.dart';
import 'package:legal_tech/core/storage/language_hive_service.dart';
import 'package:legal_tech/core/widgets/global_app_bar.dart';
import 'package:legal_tech/core/widgets/global_text.dart';
import 'package:toastification/toastification.dart';
import 'injection_container/injection_container.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Hive.initFlutter();
      await init();
      FlutterError.onError = (details) {
        myPrint("FlutterError: ${details.exception}");
        myPrint("StackTrace: ${details.stack}");
      };
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.black,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );

      try {
        await EasyLocalization.ensureInitialized();
        EasyLocalization.logger.enableBuildModes = [];
        final startLocale = await _getSavedLocale();
        runApp(
          ToastificationWrapper(
            child: EasyLocalization(
              supportedLocales: const [
                Locale('uz', 'UZ'),
                Locale('ru', 'RU'),
                Locale('en', 'EN'),
              ],
              path: 'assets/translations',
              fallbackLocale: const Locale('uz', 'UZ'),
              startLocale: startLocale,
              child: const Application(),
            ),
          ),
        );
      } catch (error, stackTrace) {
        myPrint("Application initialization error: $error");
        myPrint("StackTrace: $stackTrace");
        runApp(ErrorApp(message: error.toString()));
      }
    },
    (error, stackTrace) {
      myPrint("Uncaught error: $error");
      myPrint("StackTrace: $stackTrace");
    },
  );
}

Future<Locale> _getSavedLocale() async {
  try {
    final languageHiveService = sl<LanguageHiveService>();
    final savedLanguage = languageHiveService.getSavedLanguage();
    if (savedLanguage != null && savedLanguage.isNotEmpty) {
      return Locale(savedLanguage, savedLanguage.toUpperCase());
    }
    return const Locale('uz', 'UZ');
  } catch (e) {
    myPrint("Error getting saved locale: $e");
    return const Locale('uz', 'UZ');
  }
}

class ErrorApp extends StatelessWidget {
  final String message;

  const ErrorApp({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: GlobalAppBar(
          title: const GlobalText(text: "Error"),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 80, color: Colors.red),
                const SizedBox(height: 24),
                GlobalText(
                  text: kReleaseMode
                      ? "Oops... Something went wrong!"
                      : "Application Error",
                  textAlign: TextAlign.center,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 16),
                if (!kReleaseMode) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: GlobalText(
                      text: message,
                      textAlign: TextAlign.center,
                      fontSize: 14,
                    ),
                  ),
                ],
                if (kReleaseMode) ...[
                  const GlobalText(
                    text: "Please restart the application",
                    textAlign: TextAlign.center,
                    fontSize: 16,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
