import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legal_tech/core/constants/app_colors.dart';
import 'package:legal_tech/core/constants/app_icons.dart';
import 'package:legal_tech/core/helper/size_extension.dart';
import 'package:legal_tech/core/widgets/global_button.dart';
import 'package:legal_tech/core/widgets/global_text.dart';
import 'package:legal_tech/core/widgets/global_text_field.dart';

class LoginInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onSubmitted;

  const LoginInputField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.textInputType,
    required this.textInputAction,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlobalText(
          text: label,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.c334155,
        ),
        6.g,
        GlobalTextField(
          textInputType: textInputType,
          textInputAction: textInputAction,
          controller: controller,
          hintText: hintText,
          borderRadius: 14,
          borderColor: AppColors.cE2E8F0,
          fillColor: AppColors.white,
          fontSize: 15,
          textColor: AppColors.c1E293B,
          onSubmitted: onSubmitted,
        ),
      ],
    );
  }
}

class RememberMeRow extends StatelessWidget {
  final bool rememberMe;
  final VoidCallback onRememberMeTap;
  final VoidCallback onForgotPasswordTap;

  const RememberMeRow({
    super.key,
    required this.rememberMe,
    required this.onRememberMeTap,
    required this.onForgotPasswordTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onRememberMeTap,
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: rememberMe ? AppColors.c1E293B : AppColors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: rememberMe ? AppColors.c1E293B : AppColors.cCBD5E1,
                    width: 1.5,
                  ),
                ),
                child: rememberMe
                    ? const Icon(Icons.check, size: 16, color: AppColors.white)
                    : null,
              ),
              8.g,
              const GlobalText(
                text: "Remember me on this device",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.c475569,
              ),
            ],
          ),
        ),
        10.g,
        GestureDetector(
          onTap: onForgotPasswordTap,
          child: const GlobalText(
            text: "Forgot password?",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.c1E3A8A,
          ),
        ),
      ],
    );
  }
}

class OrSeparator extends StatelessWidget {
  const OrSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: AppColors.cE2E8F0, thickness: 1.2)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: GlobalText(
            text: "OR",
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.c94A3B8,
          ),
        ),
        Expanded(child: Divider(color: AppColors.cE2E8F0, thickness: 1.2)),
      ],
    );
  }
}

class GoogleLoginButton extends StatelessWidget {
  final VoidCallback? onTap;

  const GoogleLoginButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GlobalButton(
      onTap: onTap,
      color: AppColors.white,
      borderColor: AppColors.cE2E8F0,
      textColor: AppColors.c334155,
      title: "Sign in with Google",
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: "Manrope",
      radius: 27,
      leftIcon: SvgPicture.asset(AppIcons.googleIcn, width: 22, height: 22),
    );
  }
}

class TelegramLoginButton extends StatelessWidget {
  final VoidCallback? onTap;

  const TelegramLoginButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GlobalButton(
      onTap: onTap,
      color: AppColors.c29B6F6,
      textColor: AppColors.white,
      title: "Log in with Telegram",
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: "Manrope",
      radius: 27,
      leftIcon: SvgPicture.asset(
        AppIcons.telegramIcn,
        width: 22,
        height: 22,
        colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
      ),
    );
  }
}

class FooterLinks extends StatelessWidget {
  final VoidCallback onTap;

  const FooterLinks({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: RichText(
          text: const TextSpan(
            style: TextStyle(
              fontFamily: "Manrope",
              fontSize: 16,
              color: AppColors.c334155,
            ),
            children: [
              TextSpan(text: "New student? "),
              TextSpan(
                text: "Register here!",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.c1E3A8A,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LegalFooter extends StatelessWidget {
  final VoidCallback onTermsTap;
  final VoidCallback onPrivacyTap;

  const LegalFooter({
    super.key,
    required this.onTermsTap,
    required this.onPrivacyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(
              fontFamily: "Manrope",
              fontSize: 13,
              color: AppColors.c64748B,
              height: 1.5,
            ),
            children: [
              const TextSpan(text: "By continuing, you agree to our "),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: GestureDetector(
                  onTap: onTermsTap,
                  child: const GlobalText(
                    text: "Terms of Use",
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.c475569,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const TextSpan(text: " and "),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: GestureDetector(
                  onTap: onPrivacyTap,
                  child: const GlobalText(
                    text: "Privacy Policy",
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.c475569,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const TextSpan(text: "."),
            ],
          ),
        ),
      ),
    );
  }
}
