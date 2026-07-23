import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:legal_tech/core/router/app_route_names.dart';
import 'package:legal_tech/core/widgets/global_app_bar.dart';
import 'package:legal_tech/core/widgets/global_button.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/view_status.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/adolat_loader.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/global_text.dart';
import '../../../../core/widgets/gradient_avatar.dart';
import '../../domain/entities/lawyer.dart';
import '../bloc/lawyer_profile_bloc.dart';
import '../widgets/review_card.dart';

/// 02 — Advokat profili.
class LawyerProfilePage extends StatelessWidget {
  const LawyerProfilePage({super.key, required this.lawyer});

  final Lawyer lawyer;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LawyerProfileBloc>(
      create: (_) =>
          sl<LawyerProfileBloc>()..add(LawyerReviewsRequested(lawyer.id)),
      child: _ProfileView(lawyer: lawyer),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView({required this.lawyer});

  final Lawyer lawyer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: GlobalAppBar(
        actionWidget: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: _RoundHeaderButton(icon: CupertinoIcons.heart, onTap: () {}),
        ),
        backgroundColor: AppColors.navy,
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 54, 16, 30),
              children: [
                _ProfileCard(lawyer: lawyer),
                const SizedBox(height: 20),
                _label(context, 'Yo\'nalishlar'),
                const SizedBox(height: 10),
                _DirectionChips(directions: lawyer.directions),
                const SizedBox(height: 18),
                _PriceCard(lawyer: lawyer),
                const SizedBox(height: 20),
                _label(context, 'Advokat haqida'),
                const SizedBox(height: 8),
                GlobalText(
                  text: lawyer.about,
                  fontSize: 13,
                  color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                  height: 1.6,
                ),
                const SizedBox(height: 22),
                _label(context, 'Sharhlar (${lawyer.reviewsCount})'),
                const SizedBox(height: 10),
                const _ReviewsList(),
              ],
            ),
          ),
          GlobalButton(
            onTap: () => context.push(AppRouteNames.checkout, extra: lawyer),
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
            title: "Konsultatsiyani boshlash",
            color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextPrimary : AppColors.navy,
            textColor: Theme.of(context).brightness == Brightness.dark ? AppColors.black : AppColors.white,
            rightIcon:  Text(
               ' · ${Formatters.soum(lawyer.pricePerSession)}',
              style: AppTextStyles.sans(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).brightness == Brightness.dark ? AppColors.navyText : AppColors.gold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(BuildContext context, String text) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: GlobalText(
        text: text,
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
      ),
    );
  }
}

class _RoundHeaderButton extends StatelessWidget {
  const _RoundHeaderButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white.withValues(alpha: 0.12),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, size: 16, color: AppColors.white),
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.lawyer});

  final Lawyer lawyer;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        AppCard(
          shadow: true,
          radius: AppRadius.xxl,
          padding: const EdgeInsets.fromLTRB(18, 48, 18, 20),
          child: Column(
            children: [
              GlobalText(
                text: lawyer.fullName,
                fontFamily: 'Newsreader',
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: onSurface,
              ),
              const SizedBox(height: 3),
              GlobalText(
                text: lawyer.specialization,
                textAlign: TextAlign.center,
                fontSize: 13,
                color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextSecondary : AppColors.textMuted,
              ),
              if (lawyer.isOnline) ...[
                const SizedBox(height: 10),
                const OnlineBadge(),
              ],
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 14),
              Row(
                children: [
                  _StatCell(
                    value: '★ ${lawyer.rating.toStringAsFixed(1)}',
                    label: 'Reyting',
                    first: true,
                  ),
                  _StatCell(
                    value: '${lawyer.experienceYears} yil',
                    label: 'Tajriba',
                  ),
                  _StatCell(
                    value: '${lawyer.consultationsCount}',
                    label: 'Konsultatsiya',
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: -42,
          child: GradientAvatar(
            name: lawyer.fullName,
            size: 84,
            online: lawyer.isOnline,
            fontSize: 26,
          ),
        ),
      ],
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.value,
    required this.label,
    this.first = false,
  });

  final String value;
  final String label;
  final bool first;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: first
            ? null
            : const BoxDecoration(
                border: Border(left: BorderSide(color: AppColors.divider)),
              ),
        child: Column(
          children: [
            GlobalText(
              text: value,
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(height: 2),
            GlobalText(
              text: label, 
              fontSize: 11, 
              color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextSecondary : AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}

class _DirectionChips extends StatelessWidget {
  const _DirectionChips({required this.directions});

  final List<String> directions;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: directions
          .map(
            (d) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: AppColors.borderStrong),
              ),
              child: GlobalText(
                text: d,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextSecondary : AppColors.textSecondary,
              ),
            ),
          )
          .toList(),
    );
  }
}

class _PriceCard extends StatelessWidget {
  const _PriceCard({required this.lawyer});

  final Lawyer lawyer;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: isDark ? Theme.of(context).cardColor : AppColors.navy,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: isDark ? Border.all(color: AppColors.darkBorder) : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalText(
                  text: 'Tezkor konsultatsiya',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.white.withValues(alpha: 0.55),
                ),
                const SizedBox(height: 3),
                Text.rich(
                  TextSpan(
                    text: Formatters.money(lawyer.pricePerSession),
                    style: AppTextStyles.sans(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.white,
                    ),
                    children: [
                      TextSpan(
                        text: ' so\'m',
                        style: AppTextStyles.sans(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.darkTextSecondary : AppColors.white.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GlobalText(
                text: '${lawyer.sessionMinutes} daqiqagacha',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.gold,
              ),
              const SizedBox(height: 3),
              GlobalText(
                text: 'Chat · Audio · Video',
                fontSize: 11,
                color: isDark ? AppColors.darkTextSecondary : AppColors.white.withValues(alpha: 0.5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReviewsList extends StatelessWidget {
  const _ReviewsList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LawyerProfileBloc, LawyerProfileState>(
      builder: (context, state) {
        if (state.status.isLoading || state.status.isInitial) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: AdolatLoader()),
          );
        }
        return Column(
          children: state.reviews
              .map(
                (r) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ReviewCard(review: r),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
