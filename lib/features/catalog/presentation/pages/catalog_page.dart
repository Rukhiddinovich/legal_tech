
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/view_status.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_route_names.dart';
import '../../../../core/widgets/global_text.dart';
import '../../../../core/widgets/global_text_field.dart';
import '../../../../core/widgets/online_dot.dart';
import '../../../../core/widgets/section_header.dart';
import '../bloc/catalog_bloc.dart';
import '../widgets/law_area_tile.dart';
import '../widgets/lawyer_card.dart';
import '../widgets/tool_card.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  static const _userName = "John Doe";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CatalogBloc>(
      create: (_) => sl<CatalogBloc>()..add(const CatalogStarted()),
      child: Builder(
        builder: (context) {
          final topPad = MediaQuery.paddingOf(context).top;
          
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: BlocBuilder<CatalogBloc, CatalogState>(
              builder: (context, state) {
                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _HeaderDelegate(
                        userName: _userName,
                        topPad: topPad,
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.xl,
                        22,
                        AppSpacing.xl,
                        24,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          SectionHeader(
                            title: 'Huquq sohalari',
                            actionLabel: 'Barchasi',
                            onAction: () {},
                          ),
                          _buildAreasGrid(context, state),
                          const SizedBox(height: 16),
                          _buildToolsRow(context),
                          _buildInstructionsBanner(context),
                          const SizedBox(height: 22),
                          _buildOnlineHeader(state.onlineCount),
                          const SizedBox(height: 13),
                          ..._buildLawyerList(context, state),
                        ]),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildAreasGrid(BuildContext context, CatalogState state) {
    if (state.status.isLoading || state.areas.isEmpty) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
      final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

      return GridView.count(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 20),
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        crossAxisSpacing: 11,
        mainAxisSpacing: 11,
        childAspectRatio: 0.75,
        children: List.generate(
          6,
          (index) => Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      );
    }
    return GridView.count(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 20),
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 11,
      mainAxisSpacing: 11,
      childAspectRatio: 0.75,
      children: state.areas
          .map((area) => LawAreaTile(
                area: area,
                selected: false,
                onTap: () => context.push(AppRouteNames.lawyersByArea, extra: area),
              ))
          .toList(),
    );
  }

  Widget _buildToolsRow(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ToolCard(
              icon: CupertinoIcons.doc,
              title: 'Hujjat generatori',
              subtitle: 'Shartnoma, ariza — PDF',
              dark: true,
              onTap: () => context.push(AppRouteNames.documentGenerator),
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: ToolCard(
              icon: CupertinoIcons.percent,
              title: 'Boj kalkulyatori',
              subtitle: 'Sud & notarius boji',
              dark: false,
              onTap: () => context.push(AppRouteNames.feeCalculator),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionsBanner(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.navy, Color(0xFF1E2E4A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.25), width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => context.push(AppRouteNames.legalInstructions),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.gold.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const GlobalText(
                          text: 'Huquqiy ko\'rsatmalar',
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          color: AppColors.gold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const GlobalText(
                        text: 'Qonuniy Huquqlaringizni Biling',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                      const SizedBox(height: 4),
                      GlobalText(
                        text: 'Meros, oila, soliq va boshqa mavzularda rasmiy ko\'rsatmalar bazasi',
                        fontSize: 12,
                        color: AppColors.white.withValues(alpha: 0.6),
                        height: 1.35,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.gold.withValues(alpha: 0.22),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    CupertinoIcons.chevron_right,
                    color: AppColors.gold,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOnlineHeader(int count) {
    return SectionHeader(
      title: 'Onlayn advokatlar',
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const OnlineDot(size: 7),
          const SizedBox(width: 6),
          GlobalText(
            text: '$count ta faol',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.online,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildLawyerList(BuildContext context, CatalogState state) {
    if (state.status.isLoading || state.status.isInitial) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
      final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

      return List.generate(
        3,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      );
    }
    if (state.lawyers.isEmpty) {
      return const [
        Padding(
          padding: EdgeInsets.only(top: 40),
          child: Center(
            child: GlobalText(
              text: 'Advokat topilmadi',
              color: AppColors.textMuted,
            ),
          ),
        ),
      ];
    }
    return state.lawyers
        .map((lawyer) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: LawyerCard(
                lawyer: lawyer,
                onOpenProfile: () =>
                    context.push(AppRouteNames.lawyerProfile, extra: lawyer),
                onConsult: () =>
                    context.push(AppRouteNames.checkout, extra: lawyer),
              ),
            ))
        .toList();
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  _HeaderDelegate({required this.userName, required this.topPad});

  final String userName;
  final double topPad;

  @override
  double get minExtent => topPad + 86;

  @override
  double get maxExtent => topPad + 228;

  Widget _buildSearchField(BuildContext context) {
    return GlobalTextField(
      onChanged: (v) =>
          context.read<CatalogBloc>().add(CatalogSearchChanged(v)),
      hintText: 'Advokat yoki soha bo\'yicha qidiring',
      prefixIcon: const Icon(
        CupertinoIcons.search,
        size: 20,
        color: AppColors.textHint,
      ),
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.search,
      validator: (_) => null,
      fillColor: AppColors.white,
      borderColor: AppColors.white,
      borderRadius: 14,
      textColor: AppColors.navyText,
      hintTextColor: AppColors.textHint,
      fontSize: 14,
    );
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double percent =
        (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    final double opacity = 1.0 - percent;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: topPad + 14,
              left: AppSpacing.xl,
              right: AppSpacing.xl,
              child: Opacity(
                opacity: opacity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GlobalText(
                                text: 'Assalomu alaykum,',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white.withValues(alpha: 0.5),
                              ),
                              const SizedBox(height: 3),
                              GlobalText(
                                text: userName,
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Bookmark
                            Material(
                              color: Colors.white.withValues(alpha: 0.1),
                              shape: const CircleBorder(),
                              child: InkWell(
                                onTap: () => context.push(AppRouteNames.savedLawyers),
                                customBorder: const CircleBorder(),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    CupertinoIcons.bookmark,
                                    color: AppColors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Notifications Bell with dot
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Material(
                                  color: Colors.white.withValues(alpha: 0.1),
                                  shape: const CircleBorder(),
                                  child: InkWell(
                                    onTap: () => context.push(AppRouteNames.notifications),
                                    customBorder: const CircleBorder(),
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                        CupertinoIcons.bell,
                                        color: AppColors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 2,
                                  right: 2,
                                  child: Container(
                                    width: 7,
                                    height: 7,
                                    decoration: const BoxDecoration(
                                      color: AppColors.danger,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    GlobalText(
                      text: 'Bugun qanday huquqiy\nyordam kerak?',
                      fontFamily: 'Newsreader',
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                      height: 1.25,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 24,
              left: AppSpacing.xl,
              right: AppSpacing.xl,
              child: _buildSearchField(context),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _HeaderDelegate oldDelegate) {
    return oldDelegate.userName != userName || oldDelegate.topPad != topPad;
  }
}
