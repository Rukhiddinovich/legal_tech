import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/global_text.dart';
import '../../domain/entities/review.dart';

/// Advokat profilidagi bitta sharh kartasi.
class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return AppCard(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFFEDE7DA),
                  shape: BoxShape.circle,
                ),
                child: GlobalText(
                  text: Formatters.initials(review.authorName),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.goldDark,
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: GlobalText(
                  text: review.authorName,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: onSurface,
                ),
              ),
              GlobalText(
                text: '★' * review.rating,
                color: AppColors.gold,
                fontSize: 12,
              ),
            ],
          ),
          const SizedBox(height: 9),
          GlobalText(
            text: review.text,
            fontSize: 12.5,
            color: AppColors.textSecondary,
            height: 1.55,
          ),
          if (review.verified) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.verified_outlined,
                  size: 13,
                  color: AppColors.online,
                ),
                const SizedBox(width: 5),
                GlobalText(
                  text: 'Tasdiqlangan mijoz · to\'lov qilingan',
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.online,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
