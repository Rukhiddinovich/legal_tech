import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../../../../core/widgets/global_button.dart';
import '../../../../core/widgets/global_text.dart';
import '../../../../core/widgets/global_text_field.dart';
import '../../../../core/widgets/gradient_avatar.dart';
import '../../../lawyers/domain/entities/lawyer.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key, required this.lawyer});

  final Lawyer lawyer;

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  int _selectedStars = 0;
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submit() {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      title: const Text('Sharhingiz muvaffaqiyatli yuborildi. Rahmat!'),
      autoCloseDuration: const Duration(seconds: 3),
    );
    // Pop back to tab shell or home
    Navigator.of(context).pop();
  }

  void _skip() {
    Navigator.of(context).pop();
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
          text: 'Seansni baholash',
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        actionWidget: TextButton(
          onPressed: _skip,
          child: const GlobalText(
            text: 'O\'tkazib yuborish',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textMuted,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                children: [
                  Center(
                    child: GradientAvatar(
                      name: widget.lawyer.fullName,
                      size: 80,
                      online: false,
                    ),
                  ),
                  const SizedBox(height: 18),
                  GlobalText(
                    text: widget.lawyer.fullName,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  const SizedBox(height: 4),
                  GlobalText(
                    text: widget.lawyer.specialization,
                    fontSize: 13,
                    color: AppColors.textMuted,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 36),
                  const GlobalText(
                    text: 'Konsultatsiya qanday o\'tdi? Baholang:',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 14),
                  // Stars selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      final starNumber = index + 1;
                      final isSelected = starNumber <= _selectedStars;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedStars = starNumber;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(
                            isSelected ? CupertinoIcons.star_fill : CupertinoIcons.star,
                            color: isSelected ? AppColors.gold : AppColors.textHint,
                            size: 38,
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 30),
                  if (_selectedStars > 0) ...[
                    const GlobalText(
                      text: 'Sharh yozish (ixtiyoriy):',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 8),
                    GlobalTextField(
                      controller: _commentController,
                      hintText: 'Fikr va takliflaringizni yozib qoldiring...',
                      maxLine: 4,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      textColor: isDark ? AppColors.white : AppColors.navyText,
                      fillColor: Theme.of(context).cardColor,
                      validator: (_) => null,
                    ),
                  ],
                ],
              ),
            ),
            GlobalButton(
              onTap: _selectedStars > 0 ? _submit : null,
              title: 'Yuborish',
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
              color: isDark ? AppColors.darkTextPrimary : AppColors.navy,
              textColor: isDark ? AppColors.black : AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
