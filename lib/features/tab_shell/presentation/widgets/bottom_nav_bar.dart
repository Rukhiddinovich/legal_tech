import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/global_text.dart';

/// Pastki navigatsiya elementi modeli.
class NavItem {
  const NavItem({required this.icon, required this.activeIcon, required this.label});

  final IconData icon;
  final IconData activeIcon;
  final String label;
}

/// Dizayndagi shisha (blur) effektli pastki navigatsiya paneli.
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<NavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.paddingOf(context).bottom;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.fromLTRB(12, 11, 12, bottomPad + 10),
      decoration: BoxDecoration(
        color: (isDark ? AppColors.darkCard : AppColors.white)
            .withValues(alpha: 0.96),
        border: const Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (i) {
          final selected = i == currentIndex;
          final item = items[i];
          final color = selected ? AppColors.navy : AppColors.textHint;
          final activeColor =
              isDark && selected ? AppColors.gold : color;

          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => onTap(i),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    selected ? item.activeIcon : item.icon,
                    size: 22,
                    color: activeColor,
                  ),
                  const SizedBox(height: 5),
                  GlobalText(
                    text: item.label,
                    maxLines: 1,
                    isEllipsis: true,
                    fontSize: 10,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                    color: activeColor,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
