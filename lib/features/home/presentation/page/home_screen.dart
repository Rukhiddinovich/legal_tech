import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legal_tech/core/constants/app_colors.dart';
import 'package:legal_tech/core/constants/app_icons.dart';
import 'package:legal_tech/core/helper/size_extension.dart';
import 'package:legal_tech/core/router/app_route_names.dart';
import 'package:legal_tech/core/widgets/global_text.dart';
import 'package:legal_tech/features/home/presentation/widgets/home_feature_card.dart';
import 'package:legal_tech/features/home/presentation/widgets/quick_access_card.dart';
import 'package:legal_tech/features/theme/domain/entities/theme_entity.dart';
import 'package:legal_tech/features/theme/presentation/bloc/theme/theme_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 12,
                bottom: 8,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.04),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ZoomTapAnimation(
                    onTap: () {},
                    child: Icon(
                      Icons.search_rounded,
                      color: isDarkTheme ? AppColors.white : AppColors.c1E293B,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  SvgPicture.asset(
                    AppIcons.satashkentFullIcn,
                    width: 200,
                    colorFilter: const ColorFilter.mode(
                      AppColors.cB8001F,
                      BlendMode.srcIn,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ZoomTapAnimation(
                        onTap: () {},
                        child: Icon(
                          Icons.notifications_none_rounded,
                          color: isDarkTheme ? AppColors.cBFBFBF : AppColors.c4A5565,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      BlocBuilder<ThemeBloc, ThemeState>(
                        builder: (context, state) {
                          final isDark = state is ThemeLoaded &&
                              state.theme.themeMode == AppThemeMode.dark;
                          return ZoomTapAnimation(
                            onTap: () {
                              final newMode = isDark
                                  ? AppThemeMode.light
                                  : AppThemeMode.dark;
                              context.read<ThemeBloc>().add(
                                    SetThemeEvent(
                                      ThemeEntity(themeMode: newMode),
                                    ),
                                  );
                            },
                            child: Icon(
                              isDark
                                  ? Icons.light_mode_rounded
                                  : Icons.dark_mode_outlined,
                              color: isDark ? Colors.amber : AppColors.c4A5565,
                              size: 22,
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 12),
                      ZoomTapAnimation(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RouteNames.authScreen,
                            (route) => false,
                          );
                        },
                        child: const Icon(
                          Icons.logout_rounded,
                          color: AppColors.cB8001F,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          const GlobalText(text: "👋", fontSize: 28),
                          const SizedBox(width: 8),
                          Expanded(
                            child: GlobalText(
                              text: "Hi Jamshid Jo'rayev",
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    HomeFeatureCard(
                      leftWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GlobalText(
                            text: "Last Test\nResult",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          const SizedBox(height: 12),
                          const GlobalText(
                            text: "0",
                            fontWeight: FontWeight.w800,
                            fontSize: 72,
                            color: AppColors.cB8001F,
                          ),
                          const GlobalText(
                            text: "0/0",
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: AppColors.c757575,
                          ),
                        ],
                      ),
                      rightWidget: Align(
                        alignment: Alignment.bottomRight,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            SvgPicture.asset(
                              AppIcons.yodaBgIcn,
                              height: 180,
                              fit: BoxFit.contain,
                            ),
                            Image.asset(
                              AppImages.yoda1,
                              height: 175,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: HomeFeatureCard(
                        padding: EdgeInsets.zero,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: GlobalText(
                                text: "Roadmap",
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            const Spacer(),
                            SvgPicture.asset(
                              AppIcons.roadmapsIcn,
                              fit: BoxFit.cover,
                              width: 200,
                            ),
                          ],
                        ),
                      ),
                    ),
                    16.g,
                    HomeFeatureCard(
                      backgroundColor: AppColors.cB8001F,
                      padding: EdgeInsets.zero,
                      child: Stack(
                        children: [
                          Positioned(
                            right: -40,
                            top: -40,
                            child: Container(
                              width: 220,
                              height: 220,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.white.withValues(alpha: 0.15),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 24,
                              top: 20,
                              bottom: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    const GlobalText(
                                      text: "16",
                                      fontWeight: FontWeight.w800,
                                      fontSize: 64,
                                      color: AppColors.white,
                                    ),
                                    const SizedBox(width: 6),
                                    const GlobalText(
                                      text: "Days",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: AppColors.white,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                GlobalText(
                                  text: "Left Until Exam Day",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: AppColors.white.withValues(alpha: 0.7),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 20,
                            bottom: 20,
                            child: ZoomTapAnimation(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.white.withValues(alpha: 0.2),
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  color: AppColors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    HomeFeatureCard(
                      leftWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GlobalText(
                                text: "My Goal\nScore",
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              const SizedBox(width: 12),
                              ZoomTapAnimation(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.black.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: Theme.of(context).colorScheme.onSurface,
                                    size: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const GlobalText(
                            text: "400",
                            fontWeight: FontWeight.w800,
                            fontSize: 48,
                            color: AppColors.cB8001F,
                          ),
                        ],
                      ),
                      rightWidget: Align(
                        alignment: Alignment.bottomRight,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            SvgPicture.asset(
                              AppIcons.yodaBgIcn,
                              height: 150,
                              fit: BoxFit.contain,
                              colorFilter: ColorFilter.mode(
                                Colors.white.withValues(alpha: 0.05),
                                BlendMode.srcIn,
                              ),
                            ),
                            Image.asset(
                              AppImages.yoda2,
                              height: 145,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    HomeFeatureCard(
                      leftFlex: 6,
                      rightFlex: 4,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      leftWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GlobalText(
                                text: "My Goal\nUniversity",
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              const SizedBox(width: 12),
                              ZoomTapAnimation(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.black.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: Theme.of(context).colorScheme.onSurface,
                                    size: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ZoomTapAnimation(
                            onTap: () {},
                            child: const GlobalText(
                              text: "+ Choose University →",
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.cB8001F,
                            ),
                          ),
                        ],
                      ),
                      rightWidget: Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset(
                          AppImages.accepted,
                          height: 145,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    HomeFeatureCard(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      leftWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GlobalText(
                            text: "Competitions",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ],
                      ),
                      rightWidget: Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset(
                          AppImages.leaderboard,
                          height: 145,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: GlobalText(
                        text: "Quick Access",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1.4,
                        children: [
                          QuickAccessCard(
                            title: "Placements",
                            count: "4",
                            icon: Icons.checklist_rtl_rounded,
                            onTap: () {},
                          ),
                          QuickAccessCard(
                            title: "Homework",
                            count: "0",
                            icon: Icons.checklist_rtl_rounded,
                            onTap: () {},
                          ),
                          QuickAccessCard(
                            title: "Exams",
                            count: "0",
                            icon: Icons.assignment_rounded,
                            onTap: () {},
                          ),
                          QuickAccessCard(
                            title: "Last Dances",
                            count: "3",
                            icon: Icons.school_rounded,
                            onTap: () {},
                          ),
                          QuickAccessCard(
                            title: "Level Checks",
                            count: "0",
                            icon: Icons.trending_up_rounded,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
