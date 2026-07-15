import 'package:flutter/material.dart';

import '../../features/app/presentation/pages/splash_page.dart';
import '../../features/calculator/presentation/pages/fee_calculator_page.dart';
import '../../features/consultation/presentation/pages/consultation_page.dart';
import '../../features/documents/presentation/pages/document_generator_page.dart';
import '../../features/lawyers/domain/entities/lawyer.dart';
import '../../features/lawyers/presentation/pages/lawyer_profile_page.dart';
import '../../features/payment/presentation/pages/checkout_page.dart';
import '../../features/tab_shell/presentation/pages/tab_shell_page.dart';
import 'app_route_names.dart';

/// Markazlashtirilgan navigatsiya (onGenerateRoute).
///
/// Argument tekshiruvi shu yerda inkapsulyatsiya qilinadi — sahifalar
/// noto'g'ri tipdagi argument haqida o'ylamaydi.
class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteNames.splash:
        return _page(const SplashPage(), settings);

      case AppRouteNames.tabShell:
        return _page(const TabShellPage(), settings);

      case AppRouteNames.lawyerProfile:
        final lawyer = settings.arguments;
        if (lawyer is! Lawyer) return _error(settings);
        return _page(LawyerProfilePage(lawyer: lawyer), settings);

      case AppRouteNames.checkout:
        final lawyer = settings.arguments;
        if (lawyer is! Lawyer) return _error(settings);
        return _page(CheckoutPage(lawyer: lawyer), settings);

      case AppRouteNames.consultation:
        final lawyer = settings.arguments;
        if (lawyer is! Lawyer) return _error(settings);
        return _page(ConsultationPage(lawyer: lawyer), settings);

      case AppRouteNames.documentGenerator:
        return _page(const DocumentGeneratorPage(), settings);

      case AppRouteNames.feeCalculator:
        return _page(const FeeCalculatorPage(), settings);

      default:
        return _error(settings);
    }
  }

  static MaterialPageRoute<dynamic> _page(Widget child, RouteSettings settings) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => child,
      settings: settings,
    );
  }

  static MaterialPageRoute<dynamic> _error(RouteSettings settings) {
    return MaterialPageRoute<dynamic>(
      settings: settings,
      builder: (_) => Scaffold(
        body: Center(
          child: Text('Sahifa topilmadi: ${settings.name}'),
        ),
      ),
    );
  }
}
