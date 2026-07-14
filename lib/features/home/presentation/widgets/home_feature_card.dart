import 'package:flutter/material.dart';
import 'package:legal_tech/core/constants/app_colors.dart';

class HomeFeatureCard extends StatelessWidget {
  final Color? backgroundColor;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final double borderRadius;
  final List<BoxShadow>? boxShadow;
  final Widget? leftWidget;
  final Widget? rightWidget;
  final int leftFlex;
  final int rightFlex;
  final CrossAxisAlignment crossAxisAlignment;
  final Widget? child;

  const HomeFeatureCard({
    super.key,
    this.backgroundColor,
    this.margin = const EdgeInsets.symmetric(horizontal: 16),
    this.padding = const EdgeInsets.only(left: 24, top: 20, bottom: 20),
    this.onTap,
    this.borderRadius = 28,
    this.boxShadow,
    this.leftWidget,
    this.rightWidget,
    this.leftFlex = 5,
    this.rightFlex = 5,
    this.crossAxisAlignment = CrossAxisAlignment.end,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBgColor = backgroundColor ?? Theme.of(context).cardColor;

    final cardContent =
        child ??
        Row(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            if (leftWidget != null)
              Expanded(
                flex: leftFlex,
                child: Padding(padding: padding, child: leftWidget!),
              ),
            if (rightWidget != null)
              Expanded(flex: rightFlex, child: rightWidget!),
          ],
        );

    return Container(
      width: double.infinity,
      margin: margin,
      decoration: BoxDecoration(
        color: effectiveBgColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: onTap != null
            ? Material(
                color: Colors.transparent,
                child: InkWell(onTap: onTap, child: cardContent),
              )
            : cardContent,
      ),
    );
  }
}
