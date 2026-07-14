import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:legal_tech/core/constants/app_themes.dart';
import 'package:legal_tech/core/constants/constants.dart';
import 'package:legal_tech/core/provider/my_bloc_providers_part.dart';
import 'package:legal_tech/core/router/app_route_names.dart';
import 'package:legal_tech/core/router/app_route_part.dart';
import 'package:legal_tech/features/theme/domain/entities/theme_entity.dart';
import 'package:legal_tech/features/theme/presentation/bloc/theme/theme_bloc.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  static ValueNotifier<bool> hasInternet = ValueNotifier(true);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    final providers = MyBlocProviders.providers;

    Widget appContent = ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            ThemeMode themeMode = ThemeMode.light;
            if (state is ThemeLoaded) {
              switch (state.theme.themeMode) {
                case AppThemeMode.light:
                  themeMode = ThemeMode.light;
                  break;
                case AppThemeMode.dark:
                  themeMode = ThemeMode.dark;
                  break;
                case AppThemeMode.system:
                  themeMode = ThemeMode.system;
                  break;
              }
            }

            return MaterialApp(
              title: "LegalTech",
              locale: context.locale,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              scrollBehavior: const MaterialScrollBehavior().copyWith(
                physics: const BouncingScrollPhysics(),
              ),
              theme: AppThemes.lightTheme(),
              darkTheme: AppThemes.darkTheme(),
              themeMode: themeMode,
              debugShowCheckedModeBanner: false,
              initialRoute: RouteNames.splashScreen,
              onGenerateRoute: AppRoutes.generateRoute,
              navigatorKey: navigatorKey,
              builder: (context, child) {
                return child ?? const SizedBox();
              },
            );
          },
        );
      },
    );

    if (providers.isNotEmpty) {
      return MultiBlocProvider(providers: providers, child: appContent);
    }

    return appContent;
  }
}
