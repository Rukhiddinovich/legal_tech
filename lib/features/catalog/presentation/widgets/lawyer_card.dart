import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/global_text.dart';
import '../../../../core/widgets/gradient_avatar.dart';
import '../../../lawyers/domain/entities/lawyer.dart';

/// Katalogdagi advokat kartasi. Kengayadigan sharhlar (accordion) bilan.
class LawyerCard extends StatefulWidget {
  const LawyerCard({
    super.key,
    required this.lawyer,
    this.onOpenProfile,
    this.onConsult,
  });

  final Lawyer lawyer;
  final VoidCallback? onOpenProfile;
  final VoidCallback? onConsult;

  @override
  State<LawyerCard> createState() => _LawyerCardState();
}

class _LawyerCardState extends State<LawyerCard> {
  bool _expanded = false;

  void _showOnlineTooltip(BuildContext context) {
    toastification.show(
      context: context,
      type: ToastificationType.info,
      style: ToastificationStyle.fillColored,
      title: const Text('Hozir onlayn, darhol javob beradi'),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return AppCard(
      shadow: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: widget.onOpenProfile,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: widget.lawyer.isOnline ? () => _showOnlineTooltip(context) : null,
                  child: GradientAvatar(
                    name: widget.lawyer.fullName,
                    online: widget.lawyer.isOnline,
                    borderColor: Theme.of(context).cardColor,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: GlobalText(
                              text: widget.lawyer.fullName,
                              maxLines: 1,
                              isEllipsis: true,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: onSurface,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _expanded = !_expanded;
                              });
                            },
                            child: _RatingLabel(rating: widget.lawyer.rating),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      GlobalText(
                        text: widget.lawyer.specialization,
                        maxLines: 1,
                        isEllipsis: true,
                        fontSize: 12.5,
                        color: AppColors.textMuted,
                      ),
                      const SizedBox(height: 9),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          ...widget.lawyer.tags.map((t) => _Chip(label: t)),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _expanded = !_expanded;
                              });
                            },
                            child: _Chip(
                              label: '${widget.lawyer.reviewsCount} sharh ▾',
                              muted: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Accordion for Reviews
          if (_expanded) ...[
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            const GlobalText(
              text: 'So\'nggi sharhlar:',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.textMuted,
            ),
            const SizedBox(height: 6),
            _buildReviewItem('Kamola R.', 5, 'Juda ham maslahatlari foydali bo\'ldi. Tavsiya etaman!'),
            const SizedBox(height: 6),
            _buildReviewItem('Asadbek K.', 4, 'Yaxshi advokat, savollarga to\'liq javob berdi.'),
          ],

          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: Divider(),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    text: Formatters.money(widget.lawyer.pricePerSession),
                    style: AppTextStyles.sans(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: onSurface,
                    ),
                    children: [
                      TextSpan(
                        text: ' so\'m · ${widget.lawyer.sessionMinutes} daq',
                        style: AppTextStyles.sans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Material(
                color: AppColors.navy,
                borderRadius: BorderRadius.circular(AppRadius.md),
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  onTap: widget.onConsult,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 11,
                    ),
                    child: GlobalText(
                      text: 'Konsultatsiya',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(String name, int stars, String comment) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[900] : Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GlobalText(text: name, fontSize: 11.5, fontWeight: FontWeight.w700),
              Row(
                children: List.generate(5, (i) => Icon(
                  i < stars ? CupertinoIcons.star_fill : CupertinoIcons.star,
                  color: AppColors.gold,
                  size: 10,
                )),
              ),
            ],
          ),
          const SizedBox(height: 4),
          GlobalText(text: comment, fontSize: 11, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}

class _RatingLabel extends StatelessWidget {
  const _RatingLabel({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const GlobalText(text: '★', color: AppColors.gold, fontSize: 13),
        const SizedBox(width: 3),
        GlobalText(
          text: rating.toStringAsFixed(1),
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, this.muted = false});

  final String label;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.chipBg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: GlobalText(
        text: label,
        fontSize: 10.5,
        fontWeight: FontWeight.w600,
        color: muted ? AppColors.textMuted : AppColors.textSecondary,
      ),
    );
  }
}
