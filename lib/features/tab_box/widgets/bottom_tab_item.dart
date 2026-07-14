import 'package:flutter/material.dart';
import 'package:legal_tech/core/constants/app_colors.dart';
import 'package:legal_tech/core/widgets/global_text.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class BottomTabItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String label;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const BottomTabItem({
    super.key,
    required this.index,
    required this.icon,
    required this.label,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == selectedIndex;

    return ZoomTapAnimation(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.cB8001F.withValues(alpha: 0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.cB8001F : AppColors.c757575,
              size: 24,
            ),
            const SizedBox(height: 4),
            GlobalText(
              text: label,
              maxLines: 1,
              isEllipsis: true,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 10,
              color: isSelected ? AppColors.cB8001F : AppColors.c757575,
            ),
          ],
        ),
      ),
    );
  }
}
