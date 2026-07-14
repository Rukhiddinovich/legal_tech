import 'package:flutter/material.dart';
import 'package:legal_tech/core/widgets/global_text.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class QuickAccessCard extends StatelessWidget {
  final String title;
  final String count;
  final IconData icon;
  final VoidCallback? onTap;

  const QuickAccessCard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).cardColor
              : const Color(0xFFFAF0F1),
          borderRadius: BorderRadius.circular(24),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              Positioned(
                right: -10,
                bottom: -15,
                child: Icon(
                  icon,
                  size: 72,
                  color: const Color(0xFFB8001F).withValues(alpha: 0.18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GlobalText(
                      text: title,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFB8001F),
                      ),
                      child: GlobalText(
                        text: count,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
