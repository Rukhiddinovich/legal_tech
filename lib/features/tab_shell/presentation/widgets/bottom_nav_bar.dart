import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/global_text.dart';

/// Pastki navigatsiya elementi modeli.
class NavItem {
  const NavItem({required this.icon, required this.activeIcon, required this.label});

  final IconData icon;
  final IconData activeIcon;
  final String label;
}

/// Zamonaviy, suzib yuruvchi (floating) pastki navigatsiya paneli.
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
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: bottomPad > 0 ? bottomPad : 12,
      ),
      height: 66,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark 
              ? AppColors.white.withValues(alpha: 0.05) 
              : AppColors.black.withValues(alpha: 0.04),
        ),
        boxShadow: [
          BoxShadow(
            color: (isDark ? AppColors.black : AppColors.navy)
                .withValues(alpha: isDark ? 0.45 : 0.06),
            blurRadius: 16,
            spreadRadius: -4,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (i) {
          final selected = i == currentIndex;
          final item = items[i];
          final activeColor = isDark 
              ? (selected ? AppColors.gold : AppColors.textMuted) 
              : (selected ? AppColors.navy : AppColors.textHint);

          return Expanded(
            child: ZoomTapAnimation(
              onTap: () => onTap(i),
              child: Container(
                color: Colors.transparent, // hit test'ni kengaytirish
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                      decoration: BoxDecoration(
                        color: selected 
                            ? (isDark ? AppColors.gold.withValues(alpha: 0.1) : AppColors.navy.withValues(alpha: 0.06))
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        selected ? item.activeIcon : item.icon,
                        size: 20,
                        color: activeColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    GlobalText(
                      text: item.label,
                      maxLines: 1,
                      isEllipsis: true,
                      fontSize: 9,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                      color: activeColor,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
