import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legal_tech/core/constants/app_colors.dart';
import 'package:legal_tech/core/constants/app_icons.dart';

class GlobalTextField extends StatefulWidget {
  const GlobalTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    required this.textInputType,
    required this.textInputAction,
    this.controller,
    this.onChanged,
    this.labelText,
    this.maxLine,
    this.formatter,
    this.textAlign,
    this.enabled = true,
    this.focusNode,
    this.onEditingComplete,
    this.validator,
    this.onTap,
    this.borderColor,
    this.title,
    this.fillColor,
    this.hintTextColor,
    this.fontSize,
    this.fontWeight,
    this.maxLength,
    this.contentPadding,
    this.borderRadius,
    this.floatingLabelBehavior, this.label, this.textColor,
    this.customBorderRadius,
    this.onSubmitted,
  });

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? labelText;
  final Widget? label;
  final String? title;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final int? maxLine;
  final List<TextInputFormatter>? formatter;
  final TextAlign? textAlign;
  final bool? enabled;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final Color? borderColor;
  final Color? fillColor;
  final Color? textColor;
  final Color? hintTextColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final int? maxLength;
  final EdgeInsets? contentPadding;
  final double? borderRadius;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final BorderRadius? customBorderRadius;
  final ValueChanged<String>? onSubmitted;

  @override
  State<GlobalTextField> createState() => _GlobalTextFieldState();
}

class _GlobalTextFieldState extends State<GlobalTextField> {
  bool _isPasswordVisible = false;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      focusNode: widget.focusNode,
      validator: widget.validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return "Maydonni to'ldiring".tr();
            }
            return null;
          },

      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onFieldSubmitted: widget.onSubmitted,
      maxLength: widget.maxLength,
      onEditingComplete: widget.onEditingComplete,
      enabled: widget.enabled,
      textAlign: widget.textAlign ?? TextAlign.start,
      inputFormatters: widget.formatter,
      maxLines: widget.maxLine ?? 1,
      onChanged: widget.onChanged,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      obscureText:
          widget.textInputType == TextInputType.visiblePassword &&
          !_isPasswordVisible,
      style: GoogleFonts.manrope(
        color: widget.textColor ?? AppColors.textPrimary,
        fontSize: widget.fontSize ?? 18,
        fontWeight: widget.fontWeight ?? FontWeight.w500,
      ),
      cursorColor: widget.textColor ?? AppColors.textPrimary,
      cursorHeight: 20,
      decoration: InputDecoration(
        counter: const SizedBox.shrink(),
        floatingLabelBehavior:
            widget.floatingLabelBehavior ?? FloatingLabelBehavior.always,
        filled: true,
        fillColor: widget.fillColor ?? AppColors.white,
        suffixIcon: widget.textInputType == TextInputType.visiblePassword
            ? IconButton(
                splashRadius: 1,
                icon: SvgPicture.asset(
                  _isPasswordVisible
                      ? AppIcons.openEyeIcn
                      : AppIcons.closeEyeIcn,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : widget.suffixIcon,
        alignLabelWithHint: true,
        prefixIcon: widget.prefixIcon,
        hintText: widget.hintText?.tr(),
        hintStyle: TextStyle(
          color: widget.hintTextColor ?? AppColors.textSecondary.withValues(alpha: 0.72),
          fontSize: widget.fontSize ?? 16,
          fontWeight: widget.fontWeight ?? FontWeight.w500,
        ),
        label: widget.label,
        labelText: widget.label == null ? widget.labelText?.tr() : null,
        labelStyle: TextStyle(
          color: AppColors.black,
          fontSize: widget.fontSize ?? 16,
          fontWeight: widget.fontWeight ?? FontWeight.w500,
        ),
        contentPadding: widget.contentPadding ?? EdgeInsets.all(12),
        border: _buildBorder(),
        disabledBorder: _buildBorder(),
        enabledBorder: _buildBorder(),
        focusedBorder: _buildBorder(color: AppColors.borderStrong),
        errorBorder: _buildBorder(color: Colors.red),
        focusedErrorBorder: _buildBorder(color: Colors.red),
      ),
    );
  }

  OutlineInputBorder _buildBorder({Color? color}) {
    final radius = widget.customBorderRadius ??
        BorderRadius.circular(widget.borderRadius ?? 12);
    return OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(
        width: 1,
        color: color ?? widget.borderColor ?? AppColors.borderStrong,
      ),
    );
  }
}
