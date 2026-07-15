import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/view_status.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_route_names.dart';
import 'package:go_router/go_router.dart';
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
      create: (_) => sl<LawyerProfileBloc>()..add(LawyerReviewsRequested(lawyer.id)),
      child: _ProfileView(lawyer: lawyer),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView({required this.lawyer});

  final Lawyer lawyer;

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              // ── Navy header ──
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.xl,
                  topPad + 12,
                  AppSpacing.xl,
                  66,
                ),
                color: AppColors.navy,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _RoundHeaderButton(
                      icon: CupertinoIcons.back,
                      onTap: () => Navigator.pop(context),
                    ),
                    _RoundHeaderButton(
                      icon: CupertinoIcons.heart,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 140),
                  child: Transform.translate(
                    offset: const Offset(0, -48),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _ProfileCard(lawyer: lawyer),
                          const SizedBox(height: 20),
                          _label('Yo\'nalishlar'),
                          const SizedBox(height: 10),
                          _DirectionChips(directions: lawyer.directions),
                          const SizedBox(height: 18),
                          _PriceCard(lawyer: lawyer),
                          const SizedBox(height: 20),
                          _label('Advokat haqida'),
                          const SizedBox(height: 8),
                          GlobalText(
                            text: lawyer.about,
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            height: 1.6,
                          ),
                          const SizedBox(height: 22),
                          _label('Sharhlar (${lawyer.reviewsCount})'),
                          const SizedBox(height: 10),
                          const _ReviewsList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          _BottomBar(lawyer: lawyer),
        ],
      ),
    );
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(left: 4),
        child: GlobalText(
          text: text,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      );
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
                color: AppColors.textMuted,
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
              color: AppColors.textMuted,
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
                color: AppColors.textSecondary,
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
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.circular(AppRadius.xl),
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
                  color: AppColors.white.withValues(alpha: 0.55),
                ),
                const SizedBox(height: 3),
                Text.rich(
                  TextSpan(
                    text: Formatters.money(lawyer.pricePerSession),
                    style: AppTextStyles.sans(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.white,
                    ),
                    children: [
                      TextSpan(
                        text: ' so\'m',
                        style: AppTextStyles.sans(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white.withValues(alpha: 0.6),
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
                color: AppColors.white.withValues(alpha: 0.5),
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
            child: Center(
              child: AdolatLoader(),
            ),
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

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.lawyer});

  final Lawyer lawyer;

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.paddingOf(context).bottom;

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 14, 16, bottomPad + 14),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: const Border(top: BorderSide(color: AppColors.divider)),
        ),
        child: Material(
          color: AppColors.navy,
          borderRadius: BorderRadius.circular(15),
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () => context.push(
              AppRouteNames.checkout,
              extra: lawyer,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text.rich(
                  TextSpan(
                    text: 'Konsultatsiyani boshlash',
                    style: AppTextStyles.sans(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                    children: [
                      TextSpan(
                        text: ' · ${Formatters.soum(lawyer.pricePerSession)}',
                        style: AppTextStyles.sans(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.gold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
