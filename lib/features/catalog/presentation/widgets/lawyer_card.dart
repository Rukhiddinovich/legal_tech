import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/global_text.dart';
import '../../../../core/widgets/gradient_avatar.dart';
import '../../../lawyers/domain/entities/lawyer.dart';

/// Katalogdagi advokat kartasi.
class LawyerCard extends StatelessWidget {
  const LawyerCard({
    super.key,
    required this.lawyer,
    this.onOpenProfile,
    this.onConsult,
  });

  final Lawyer lawyer;
  final VoidCallback? onOpenProfile;
  final VoidCallback? onConsult;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return AppCard(
      onTap: onOpenProfile,
      shadow: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientAvatar(
                name: lawyer.fullName,
                online: lawyer.isOnline,
                borderColor: Theme.of(context).cardColor,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GlobalText(
                            text: lawyer.fullName,
                            maxLines: 1,
                            isEllipsis: true,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: onSurface,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        _RatingLabel(rating: lawyer.rating),
                      ],
                    ),
                    const SizedBox(height: 2),
                    GlobalText(
                      text: lawyer.specialization,
                      maxLines: 1,
                      isEllipsis: true,
                      fontSize: 12.5,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(height: 9),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        ...lawyer.tags.map((t) => _Chip(label: t)),
                        _Chip(
                          label: '${lawyer.reviewsCount} sharh',
                          muted: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: Divider(),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    text: Formatters.money(lawyer.pricePerSession),
                    style: AppTextStyles.sans(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: onSurface,
                    ),
                    children: [
                      TextSpan(
                        text: ' so\'m · ${lawyer.sessionMinutes} daq',
                        style: AppTextStyles.sans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Material(
                color: AppColors.navy,
                borderRadius: BorderRadius.circular(AppRadius.md),
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  onTap: onConsult,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 11,
                    ),
                    child: GlobalText(
                      text: 'Konsultatsiya',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RatingLabel extends StatelessWidget {
  const _RatingLabel({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const GlobalText(text: '★', color: AppColors.gold, fontSize: 13),
        const SizedBox(width: 3),
        GlobalText(
          text: rating.toStringAsFixed(1),
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, this.muted = false});

  final String label;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.chipBg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: GlobalText(
        text: label,
        fontSize: 10.5,
        fontWeight: FontWeight.w600,
        color: muted ? AppColors.textMuted : AppColors.textSecondary,
      ),
    );
  }
}
