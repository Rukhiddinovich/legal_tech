import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_route_names.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../../../../core/widgets/global_button.dart';
import '../../../../core/widgets/global_text.dart';
import '../../../law_areas/domain/entities/law_area.dart';
import '../../domain/entities/article.dart';

class ArticleDetailPage extends StatefulWidget {
  const ArticleDetailPage({super.key, required this.article});

  final Article article;

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  bool? _isHelpful;

  void _onHelpfulChanged(bool helpful) {
    setState(() {
      _isHelpful = helpful;
    });
    toastification.show(
      context: context,
      type: helpful ? ToastificationType.success : ToastificationType.info,
      style: ToastificationStyle.fillColored,
      title: Text(
        helpful 
            ? 'Fikr-mulohazangiz uchun rahmat!' 
            : 'Fikringiz qabul qilindi. Kontentni yaxshilashga harakat qilamiz!',
      ),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  void _consultLawyer() {
    // Area mapping
    final String areaName = widget.article.category.replaceAll(' huquqi', '');
    final area = LawArea(
      id: widget.article.areaId,
      name: areaName,
      abbrev: widget.article.areaId.substring(0, 1).toUpperCase(),
      priceText: widget.article.areaId == 'family' 
          ? "100 000\nso'm/30 daq" 
          : widget.article.areaId == 'inheritance' 
              ? "150 000\nso'm/30 daq" 
              : "120 000\nso'm/30 daq",
    );
    context.push(AppRouteNames.lawyersByArea, extra: area);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: GlobalAppBar(
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0,
        title: GlobalText(
          text: widget.article.category,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
              children: [
                GlobalText(
                  text: widget.article.title,
                  fontFamily: 'Newsreader',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                  height: 1.25,
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 16),
                GlobalText(
                  text: widget.article.content,
                  fontSize: 14,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                  height: 1.7,
                ),
                const SizedBox(height: 36),
                const Divider(),
                const SizedBox(height: 24),
                // Helpful center section
                Center(
                  child: Column(
                    children: [
                      GlobalText(
                        text: 'Ushbu ko\'rsatma foydali bo\'ldimi?',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _FeedbackButton(
                            icon: CupertinoIcons.hand_thumbsup,
                            activeIcon: CupertinoIcons.hand_thumbsup_fill,
                            label: 'Ha',
                            color: AppColors.online,
                            active: _isHelpful == true,
                            onTap: () => _onHelpfulChanged(true),
                          ),
                          const SizedBox(width: 14),
                          _FeedbackButton(
                            icon: CupertinoIcons.hand_thumbsdown,
                            activeIcon: CupertinoIcons.hand_thumbsdown_fill,
                            label: 'Yo\'q',
                            color: AppColors.danger,
                            active: _isHelpful == false,
                            onTap: () => _onHelpfulChanged(false),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: GlobalButton(
              onTap: _consultLawyer,
              title: 'Shu mavzuda advokatga yozish',
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              color: isDark ? AppColors.darkTextPrimary : AppColors.navy,
              textColor: isDark ? AppColors.black : AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeedbackButton extends StatelessWidget {
  const _FeedbackButton({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.color,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final Color color;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        decoration: BoxDecoration(
          color: active 
              ? color.withValues(alpha: 0.15) 
              : (isDark ? Theme.of(context).cardColor : AppColors.chipBg),
          border: Border.all(
            color: active ? color : (isDark ? AppColors.darkBorder : AppColors.borderStrong),
            width: active ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              active ? activeIcon : icon,
              size: 16,
              color: active ? color : AppColors.textMuted,
            ),
            const SizedBox(width: 8),
            GlobalText(
              text: label,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: active ? color : AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
