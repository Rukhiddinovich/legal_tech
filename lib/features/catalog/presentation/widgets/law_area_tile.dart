import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/global_text.dart';
import '../../../law_areas/domain/entities/law_area.dart';

/// Bosh sahifadagi huquq sohasi katakchasi (grid item).
class LawAreaTile extends StatelessWidget {
  const LawAreaTile({
    super.key,
    required this.area,
    required this.selected,
    this.onTap,
  });

  final LawArea area;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? AppColors.navy : AppColors.border,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 38,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.goldSoft,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: GlobalText(
                  text: area.abbrev,
                  fontFamily: 'Newsreader',
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: AppColors.goldDark,
                ),
              ),
              const SizedBox(height: 11),
              GlobalText(
                text: area.name,
                maxLines: 2,
                isEllipsis: true,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: onSurface,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
