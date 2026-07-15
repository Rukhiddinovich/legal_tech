import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/global_button.dart';
import '../../../../core/widgets/global_text.dart';

/// Anti-chetlab o'tish ogohlantirish oynasi (PRD 5-bo'lim).
///
/// Foydalanuvchi taqiqlangan kontakt (telefon, Telegram, karta) yuborsa
/// chiqadi va tizimdan tashqariga chiqmaslik haqida ogohlantiradi.
class AntiContactOverlay extends StatelessWidget {
  const AntiContactOverlay({
    super.key,
    required this.blockedSnippet,
    required this.onDismiss,
  });

  final String? blockedSnippet;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: const Color(0x8C091018),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(26),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 320),
          padding: const EdgeInsets.fromLTRB(22, 26, 22, 22),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.35),
                blurRadius: 60,
                offset: const Offset(0, 24),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 58,
                height: 58,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  CupertinoIcons.exclamationmark_triangle,
                  color: AppColors.goldDark,
                  size: 30,
                ),
              ),
              const SizedBox(height: 16),
              GlobalText(
                text: 'Tashqi aloqa taqiqlangan',
                textAlign: TextAlign.center,
                fontFamily: 'Newsreader',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.navyText,
              ),
              const SizedBox(height: 10),
              GlobalText(
                text: 'Xavfsizlik uchun telefon raqami, Telegram yoki karta '
                    'ma\'lumotlarini almashish mumkin emas. Barcha aloqa platforma '
                    'ichida saqlanadi.',
                textAlign: TextAlign.center,
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.55,
              ),
              if (blockedSnippet != null) ...[
                const SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F0E4),
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(
                      color: AppColors.goldDark.withValues(alpha: 0.5),
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: GlobalText(
                    text: blockedSnippet!,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    isEllipsis: true,
                    fontSize: 13,
                    color: const Color(0xFF9A8248),
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
              const SizedBox(height: 18),
              GlobalButton(
                title: 'Tushunarli',
                onTap: onDismiss,
                color: AppColors.navy,
                textColor: AppColors.white,
                radius: 16,
                fontFamily: 'Manrope',
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
