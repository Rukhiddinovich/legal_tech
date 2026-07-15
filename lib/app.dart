import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection_container.dart';
import 'core/router/app_route_names.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/theme/presentation/bloc/theme_bloc.dart';

/// Ilovaning ildiz (root) vidjeti.
class AdolatApp extends StatelessWidget {
  const AdolatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (_) => sl<ThemeBloc>(),
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Adolat',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: themeMode,
            initialRoute: AppRouteNames.splash,
            onGenerateRoute: AppRouter.onGenerateRoute,
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              physics: const BouncingScrollPhysics(),
            ),
          );
        },
      ),
    );
  }
}
