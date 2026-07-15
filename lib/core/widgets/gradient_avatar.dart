import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../utils/formatters.dart';
import 'online_dot.dart';

/// Ism bosh harflari bilan gradientli dumaloq avatar.
///
/// [online] true bo'lsa, o'ng-past burchakda yashil status nuqtasi chiziladi.
class GradientAvatar extends StatelessWidget {
  const GradientAvatar({
    super.key,
    required this.name,
    this.size = 54,
    this.online = false,
    this.borderColor = AppColors.white,
    this.fontSize,
  });

  final String name;
  final double size;
  final bool online;
  final Color borderColor;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final indicator = size * 0.26;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: size,
            height: size,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.avatarGradient,
            ),
            child: Text(
              Formatters.initials(name),
              style: TextStyle(
                fontSize: fontSize ?? size * 0.3,
                fontWeight: FontWeight.w700,
                color: AppColors.gold,
              ),
            ),
          ),
          if (online)
            Positioned(
              right: -1,
              bottom: -1,
              child: Container(
                width: indicator,
                height: indicator,
                decoration: BoxDecoration(
                  color: AppColors.online,
                  shape: BoxShape.circle,
                  border: Border.all(color: borderColor, width: indicator * 0.2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Yumaloq "orqaga" tugmasi (dizayndagi header ikonasi).
class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.background = AppColors.chipBg,
    this.iconColor = AppColors.navyText,
    this.size = 38,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final Color background;
  final Color iconColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(icon, size: size * 0.45, color: iconColor),
        ),
      ),
    );
  }
}

/// Onlayn holat "chirog'i" bilan matnli belgi.
class OnlineBadge extends StatelessWidget {
  const OnlineBadge({super.key, this.label = 'Hozir onlayn'});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.online.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const OnlineDot(size: 7),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.onlineDark,
            ),
          ),
        ],
      ),
    );
  }
}
