import 'package:flutter/material.dart';
import 'package:legal_tech/core/constants/app_colors.dart';
import 'package:legal_tech/core/constants/constants.dart';
import 'package:legal_tech/core/widgets/global_text.dart';

class GlobalButton extends StatelessWidget {
  const GlobalButton({
    super.key,
    this.onTap,
    this.color,
    this.gradient,
    this.gradientBegin,
    this.gradientEnd,
    this.textColor,
    this.title,
    this.leftIcon,
    this.rightIcon,
    this.radius = 100,
    this.borderColor,
    this.padding,
    this.isLoading = false,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.maxLines,
  });

  final VoidCallback? onTap;
  final Color? color;
  final List<Color>? gradient;

  final Alignment? gradientBegin;
  final Alignment? gradientEnd;

  final Color? textColor;
  final String? title;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final double? fontSize;
  final int? maxLines;
  final FontWeight? fontWeight;
  final String? fontFamily; // qo'shildi
  final bool isLoading;
  final double radius;
  final Color? borderColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onTap != null || isLoading;

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Container(
        decoration: isEnabled
            ? (gradient != null
            ? BoxDecoration(
          gradient: LinearGradient(
            colors: gradient!,
            begin: gradientBegin ?? Alignment.topCenter,
            end: gradientEnd ?? Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(radius),
        )
            : BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ))
            : BoxDecoration(
          color: borderColor != null
              ? Colors.transparent
              : AppColors.chipBg,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: ElevatedButton(
          onPressed: isLoading ? null : onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: gradient != null ? Colors.transparent : color,
            shadowColor: Colors.transparent,
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.symmetric(
              vertical: isLoading ? 10 : 20,
              horizontal: 28,
            ),
            maximumSize: Size.infinite,
            minimumSize: Size.fromHeight(
              MediaQuery.of(context).size.height * 0.07,
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: borderColor ?? Colors.transparent),
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          child: isLoading
              ? const MyCircularProgressIndicator(color: AppColors.white)
              : buttonContent(),
        ),
      ),
    );
  }

  Widget buttonContent() {
    if (leftIcon == null && rightIcon == null && title != null) {
      return GlobalText(
        text: title!,
        fontSize: fontSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.w600,
        fontFamily: fontFamily ?? "DaysOne",
        color: textColor,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines ?? 1,
      );
    }

    if (leftIcon != null && rightIcon == null && title == null) {
      return leftIcon!;
    }

    if (rightIcon != null && leftIcon == null && title == null) {
      return rightIcon!;
    }

    if (leftIcon != null && title != null && rightIcon == null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          leftIcon!,
          SizedBox(width: 8),
          Flexible(
            child: GlobalText(
              text: title!,
              fontSize: fontSize ?? 16,
              fontWeight: fontWeight ?? FontWeight.w600,
              fontFamily: fontFamily ?? "DaysOne",
              color: textColor,
              maxLines: maxLines ?? 1,
            ),
          ),
        ],
      );
    }

    if (title != null && rightIcon != null && leftIcon == null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: GlobalText(
              text: title!,
              fontSize: fontSize ?? 16,
              fontWeight: fontWeight ?? FontWeight.w600,
              fontFamily: fontFamily ?? "DaysOne",
              color: textColor,
              maxLines: maxLines ?? 1,
            ),
          ),
          SizedBox(width: 8),
          rightIcon!,
        ],
      );
    }

    if (leftIcon != null && title != null && rightIcon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leftIcon!,
          Expanded(
            child: GlobalText(
              text: title!,
              fontSize: fontSize ?? 16,
              fontWeight: fontWeight ?? FontWeight.w600,
              fontFamily: fontFamily ?? "DaysOne",
              color: textColor,
              textAlign: TextAlign.center,
              maxLines: maxLines ?? 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          rightIcon!,
        ],
      );
    }

    if (leftIcon != null && rightIcon != null && title == null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [leftIcon!, rightIcon!],
      );
    }

    return const SizedBox.shrink();
  }
}

