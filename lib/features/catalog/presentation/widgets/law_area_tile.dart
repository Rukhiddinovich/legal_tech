import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/global_text.dart';
import '../../../law_areas/domain/entities/law_area.dart';

class _AreaStyle {
  const _AreaStyle(this.icon, this.iconColor, this.bgColor);
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
}

_AreaStyle _getStyleForArea(String id, bool isDark) {
  switch (id) {
    case 'family':
      return _AreaStyle(
        Icons.people_outline,
        isDark ? const Color(0xFF64B5F6) : const Color(0xFF1D3557),
        isDark ? const Color(0xFF64B5F6).withValues(alpha: 0.15) : const Color(0xFFF0F5FA),
      );
    case 'inheritance':
      return _AreaStyle(
        Icons.key_outlined,
        isDark ? const Color(0xFFFFB74D) : const Color(0xFFC06B13),
        isDark ? const Color(0xFFFFB74D).withValues(alpha:0.15) : const Color(0xFFFFF8EC),
      );
    case 'taxes':
      return _AreaStyle(
        Icons.calculate_outlined,
        isDark ? const Color(0xFF81C784) : const Color(0xFF177A40),
        isDark ? const Color(0xFF81C784).withValues(alpha:0.15) : const Color(0xFFEEF8F1),
      );
    case 'criminal':
      return _AreaStyle(
        Icons.gavel_outlined,
        isDark ? const Color(0xFFE57373) : const Color(0xFFB82828),
        isDark ? const Color(0xFFE57373).withValues(alpha:0.15) : const Color(0xFFFEF1F1),
      );
    case 'labor':
      return _AreaStyle(
        Icons.work_outline,
        isDark ? const Color(0xFFBA68C8) : const Color(0xFF7A20B8),
        isDark ? const Color(0xFFBA68C8).withValues(alpha:0.15) : const Color(0xFFF7F1FB),
      );
    case 'business':
      return _AreaStyle(
        Icons.domain,
        isDark ? const Color(0xFF4DB6AC) : const Color(0xFF0C7063),
        isDark ? const Color(0xFF4DB6AC).withValues(alpha:0.15) : const Color(0xFFEDF7F6),
      );
    default:
      return _AreaStyle(
        Icons.category_outlined,
        isDark ? AppColors.gold : AppColors.goldDark,
        isDark ? AppColors.gold.withValues(alpha:0.15) : AppColors.goldSoft,
      );
  }
}

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final style = _getStyleForArea(area.id, isDark);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:isDark ? 0.2 : 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: selected ? (isDark ? AppColors.darkTextPrimary : AppColors.navy) : Colors.transparent,
                width: selected ? 1.5 : 0,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 54,
                  height: 54,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: style.bgColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    style.icon,
                    color: style.iconColor,
                    size: 26,
                  ),
                ),
                const SizedBox(height: 14),
                GlobalText(
                  text: area.name,
                  maxLines: 1,
                  isEllipsis: true,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.navyText,
                ),
                const SizedBox(height: 8),
                if (area.priceText != null)
                  GlobalText(
                    text: area.priceText!,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                    height: 1.3,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
