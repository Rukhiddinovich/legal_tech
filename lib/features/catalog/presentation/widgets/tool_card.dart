import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/global_text.dart';

/// Bosh sahifadagi vosita kartasi (Hujjat generatori / Boj kalkulyatori).
class ToolCard extends StatelessWidget {
  const ToolCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.dark,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool dark;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bg = dark ? AppColors.navy : Theme.of(context).cardColor;
    final titleColor = dark
        ? AppColors.white
        : Theme.of(context).colorScheme.onSurface;
    final subColor = dark
        ? AppColors.white.withValues(alpha: 0.55)
        : AppColors.textMuted;
    final iconBoxColor =
        dark ? AppColors.gold.withValues(alpha: 0.22) : AppColors.goldSoft;

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: dark ? null : Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: iconBoxColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: AppColors.gold),
              ),
              const SizedBox(height: 10),
              GlobalText(
                text: title,
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: titleColor,
              ),
              const SizedBox(height: 3),
              GlobalText(
                text: subtitle,
                maxLines: 1,
                isEllipsis: true,
                fontSize: 11,
                color: subColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
