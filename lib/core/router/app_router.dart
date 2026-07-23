import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../features/app/presentation/pages/splash_page.dart';
import '../../features/calculator/presentation/pages/fee_calculator_page.dart';
import '../../features/consultation/presentation/pages/consultation_page.dart';
import '../../features/documents/presentation/pages/document_generator_page.dart';
import '../../features/lawyers/domain/entities/lawyer.dart';
import '../../features/lawyers/presentation/pages/lawyer_profile_page.dart';
import '../../features/lawyers/presentation/pages/lawyers_by_area_page.dart';
import '../../features/lawyers/presentation/pages/saved_lawyers_page.dart';
import '../../features/law_areas/domain/entities/law_area.dart';
import '../../features/payment/presentation/pages/checkout_page.dart';
import '../../features/profile/presentation/pages/profile_edit_page.dart';
import '../../features/tab_shell/presentation/pages/tab_box.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/global_text.dart';
import 'app_route_names.dart';

// New Features Imports
import '../../features/legal_instructions/domain/entities/article.dart';
import '../../features/legal_instructions/presentation/pages/articles_list_page.dart';
import '../../features/legal_instructions/presentation/pages/article_detail_page.dart';
import '../../features/lawyers/presentation/pages/rating_page.dart';
import '../../features/consultation/presentation/pages/call_page.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  const AppRouter._();

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRouteNames.splash,
    errorBuilder: (context, state) => _buildUnknownRoutePage(state.error?.toString()),
    routes: [
      GoRoute(
        path: AppRouteNames.splash,
        name: AppRouteNames.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRouteNames.tabShell,
        name: AppRouteNames.tabShell,
        builder: (context, state) => const TabBox(),
      ),
      GoRoute(
        path: AppRouteNames.lawyerProfile,
        name: AppRouteNames.lawyerProfile,
        builder: (context, state) {
          final lawyer = state.extra;
          if (lawyer is! Lawyer) return _buildUnknownRoutePage('Invalid Lawyer argument');
          return LawyerProfilePage(lawyer: lawyer);
        },
      ),
      GoRoute(
        path: AppRouteNames.checkout,
        name: AppRouteNames.checkout,
        builder: (context, state) {
          final lawyer = state.extra;
          if (lawyer is! Lawyer) return _buildUnknownRoutePage('Invalid Lawyer argument');
          return CheckoutPage(lawyer: lawyer);
        },
      ),
      GoRoute(
        path: AppRouteNames.consultation,
        name: AppRouteNames.consultation,
        builder: (context, state) {
          final lawyer = state.extra;
          if (lawyer is! Lawyer) return _buildUnknownRoutePage('Invalid Lawyer argument');
          return ConsultationPage(lawyer: lawyer);
        },
      ),
      GoRoute(
        path: AppRouteNames.documentGenerator,
        name: AppRouteNames.documentGenerator,
        builder: (context, state) => const DocumentGeneratorPage(),
      ),
      GoRoute(
        path: AppRouteNames.feeCalculator,
        name: AppRouteNames.feeCalculator,
        builder: (context, state) => const FeeCalculatorPage(),
      ),
      GoRoute(
        path: AppRouteNames.profileEdit,
        name: AppRouteNames.profileEdit,
        builder: (context, state) => const ProfileEditPage(),
      ),
      GoRoute(
        path: AppRouteNames.lawyersByArea,
        name: AppRouteNames.lawyersByArea,
        builder: (context, state) {
          final area = state.extra;
          if (area is! LawArea) return _buildUnknownRoutePage('Invalid LawArea argument');
          return LawyersByAreaPage(area: area);
        },
      ),
      GoRoute(
        path: AppRouteNames.savedLawyers,
        name: AppRouteNames.savedLawyers,
        builder: (context, state) => const SavedLawyersPage(),
      ),
      GoRoute(
        path: AppRouteNames.legalInstructions,
        name: AppRouteNames.legalInstructions,
        builder: (context, state) => const ArticlesListPage(),
      ),
      GoRoute(
        path: AppRouteNames.articleDetail,
        name: AppRouteNames.articleDetail,
        builder: (context, state) {
          final article = state.extra;
          if (article is! Article) return _buildUnknownRoutePage('Invalid Article argument');
          return ArticleDetailPage(article: article);
        },
      ),
      GoRoute(
        path: AppRouteNames.ratingPage,
        name: AppRouteNames.ratingPage,
        builder: (context, state) {
          final lawyer = state.extra;
          if (lawyer is! Lawyer) return _buildUnknownRoutePage('Invalid Lawyer argument');
          return RatingPage(lawyer: lawyer);
        },
      ),
      GoRoute(
        path: AppRouteNames.callPage,
        name: AppRouteNames.callPage,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final lawyer = extra['lawyer'] as Lawyer;
          final isVideo = extra['isVideo'] as bool;
          return CallPage(lawyer: lawyer, isVideo: isVideo);
        },
      ),
      GoRoute(
        path: AppRouteNames.notifications,
        name: AppRouteNames.notifications,
        builder: (context, state) => const NotificationsPage(),
      ),
    ],
  );

  static Widget _buildUnknownRoutePage([String? errorMsg]) {
    return Builder(
      builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: AppColors.white,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: AppColors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GlobalText(
                    text: errorMsg ?? "Route da xatolik sodir bo'ldi",
                    fontSize: 20.sp,
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go(AppRouteNames.splash);
                      }
                    },
                    child: const GlobalText(text: "Back", color: AppColors.white),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
