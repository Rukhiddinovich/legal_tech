import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import 'package:legal_tech/core/router/app_route_names.dart';
import 'package:legal_tech/core/widgets/global_app_bar.dart';
import 'package:legal_tech/core/widgets/global_button.dart';
import 'package:legal_tech/core/widgets/global_text_field.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/view_status.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/adolat_loader.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/global_text.dart';
import '../../../../core/widgets/gradient_avatar.dart';
import '../../../law_areas/domain/entities/law_area.dart';
import '../../domain/entities/lawyer.dart';
import '../bloc/lawyer_profile_bloc.dart';
import '../bloc/saved_lawyers_bloc.dart';
import '../widgets/review_card.dart';

/// 02 — Advokat profili.
class LawyerProfilePage extends StatelessWidget {
  const LawyerProfilePage({super.key, required this.lawyer});

  final Lawyer lawyer;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LawyerProfileBloc>(
      create: (_) =>
          sl<LawyerProfileBloc>()..add(LawyerReviewsRequested(lawyer.id)),
      child: _ProfileView(lawyer: lawyer),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView({required this.lawyer});

  final Lawyer lawyer;

  void _showDisputeDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _DisputeModal(lawyer: lawyer),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: GlobalAppBar(
        actionWidget: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: BlocBuilder<SavedLawyersBloc, SavedLawyersState>(
            builder: (context, state) {
              final isSaved = state.isSaved(lawyer.id);
              return _RoundHeaderButton(
                icon: isSaved ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
                onTap: () {
                  context.read<SavedLawyersBloc>().add(ToggleSavedLawyer(lawyer));
                },
              );
            },
          ),
        ),
        backgroundColor: AppColors.navy,
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 54, 16, 30),
              children: [
                _ProfileCard(lawyer: lawyer),
                const SizedBox(height: 20),
                _label(context, 'Yo\'nalishlar (Filtrlash uchun bosing)'),
                const SizedBox(height: 10),
                _DirectionChips(directions: lawyer.directions),
                const SizedBox(height: 18),
                _PriceCard(lawyer: lawyer),
                const SizedBox(height: 20),
                _label(context, 'Advokat haqida'),
                const SizedBox(height: 8),
                GlobalText(
                  text: lawyer.about,
                  fontSize: 13,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                  height: 1.6,
                ),
                const SizedBox(height: 22),
                _label(context, 'Sharhlar (${lawyer.reviewsCount})'),
                const SizedBox(height: 10),
                const _ReviewsList(),
                const SizedBox(height: 24),
                // Dispute Complaint Text Link
                Center(
                  child: TextButton(
                    onPressed: () => _showDisputeDialog(context),
                    child: const GlobalText(
                      text: 'Shikoyat qilish / Nizo ochish',
                      fontSize: 12,
                      color: AppColors.danger,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GlobalButton(
            onTap: () => context.push(AppRouteNames.checkout, extra: lawyer),
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
            title: "Konsultatsiyani boshlash",
            color: isDark ? AppColors.darkTextPrimary : AppColors.navy,
            textColor: isDark ? AppColors.black : AppColors.white,
            rightIcon:  Text(
               ' · ${Formatters.soum(lawyer.pricePerSession)}',
              style: AppTextStyles.sans(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.navyText : AppColors.gold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(BuildContext context, String text) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: GlobalText(
        text: text,
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
      ),
    );
  }
}

class _RoundHeaderButton extends StatelessWidget {
  const _RoundHeaderButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white.withValues(alpha: 0.12),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, size: 16, color: AppColors.white),
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.lawyer});

  final Lawyer lawyer;

  void _showLicenseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const GlobalText(text: 'Tasdiqlangan advokat statusi', fontSize: 16, fontWeight: FontWeight.w700),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlobalText(text: 'Advokat: ${lawyer.fullName}', fontSize: 13),
            const SizedBox(height: 8),
            const GlobalText(text: 'Litsenziya raqami: AP-9041/2024', fontSize: 13, fontWeight: FontWeight.w600),
            const SizedBox(height: 4),
            const GlobalText(text: 'Tekshirilgan sana: 12-Mart 2026', fontSize: 12, color: AppColors.textMuted),
            const SizedBox(height: 12),
            const GlobalText(
              text: 'Ushbu status advokatning rasmiy ravishda litsenziyalanganligi, malakasi tasdiqlanganligi va platforma tekshiruvidan muvaffaqiyatli o\'tganligini bildiradi.',
              fontSize: 11.5,
              color: AppColors.textMuted,
              height: 1.4,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Tushunarli'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        AppCard(
          shadow: true,
          radius: AppRadius.xxl,
          padding: const EdgeInsets.fromLTRB(18, 48, 18, 20),
          child: Column(
            children: [
              GlobalText(
                text: lawyer.fullName,
                fontFamily: 'Newsreader',
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: onSurface,
              ),
              const SizedBox(height: 3),
              GlobalText(
                text: lawyer.specialization,
                textAlign: TextAlign.center,
                fontSize: 13,
                color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextSecondary : AppColors.textMuted,
              ),
              const SizedBox(height: 8),
              
              // Verify Badge
              GestureDetector(
                onTap: () => _showLicenseDialog(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.online.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(CupertinoIcons.checkmark_seal_fill, color: AppColors.online, size: 13),
                      SizedBox(width: 4),
                      GlobalText(
                        text: 'Tasdiqlangan advokat',
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.online,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (lawyer.isOnline) ...[
                const OnlineBadge(),
              ],
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 14),
              Row(
                children: [
                  _StatCell(
                    value: '★ ${lawyer.rating.toStringAsFixed(1)}',
                    label: 'Reyting',
                    first: true,
                  ),
                  _StatCell(
                    value: '${lawyer.experienceYears} yil',
                    label: 'Tajriba',
                  ),
                  _StatCell(
                    value: '${lawyer.consultationsCount}',
                    label: 'Konsultatsiya',
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: -42,
          child: GradientAvatar(
            name: lawyer.fullName,
            size: 84,
            online: lawyer.isOnline,
            fontSize: 26,
          ),
        ),
      ],
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.value,
    required this.label,
    this.first = false,
  });

  final String value;
  final String label;
  final bool first;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: first
            ? null
            : const BoxDecoration(
                border: Border(left: BorderSide(color: AppColors.divider)),
              ),
        child: Column(
          children: [
            GlobalText(
              text: value,
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(height: 2),
            GlobalText(
              text: label, 
              fontSize: 11, 
              color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextSecondary : AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}

class _DirectionChips extends StatelessWidget {
  const _DirectionChips({required this.directions});

  final List<String> directions;

  LawArea _getAreaFromDirection(String d) {
    final String id = d == 'Oila' 
        ? 'family' 
        : d == 'Meros' 
            ? 'inheritance' 
            : d == 'Soliq' 
                ? 'taxes' 
                : d == 'Jinoyat' 
                    ? 'criminal' 
                    : d == 'Mehnat' 
                        ? 'labor' 
                        : 'business';
    return LawArea(
      id: id,
      name: d,
      abbrev: d.substring(0, 1).toUpperCase(),
      priceText: id == 'family' 
          ? "100 000\nso'm/30 daq" 
          : id == 'inheritance' 
              ? "150 000\nso'm/30 daq" 
              : "120 000\nso'm/30 daq",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: directions
          .map(
            (d) => GestureDetector(
              onTap: () => context.push(AppRouteNames.lawyersByArea, extra: _getAreaFromDirection(d)),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: AppColors.borderStrong),
                ),
                child: GlobalText(
                  text: d,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _PriceCard extends StatelessWidget {
  const _PriceCard({required this.lawyer});

  final Lawyer lawyer;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: isDark ? Theme.of(context).cardColor : AppColors.navy,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: isDark ? Border.all(color: AppColors.darkBorder) : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalText(
                  text: 'Tezkor konsultatsiya',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.white.withValues(alpha: 0.55),
                ),
                const SizedBox(height: 3),
                Text.rich(
                  TextSpan(
                    text: Formatters.money(lawyer.pricePerSession),
                    style: AppTextStyles.sans(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.white,
                    ),
                    children: [
                      TextSpan(
                        text: ' so\'m',
                        style: AppTextStyles.sans(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.darkTextSecondary : AppColors.white.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GlobalText(
                text: '${lawyer.sessionMinutes} daqiqagacha',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.gold,
              ),
              const SizedBox(height: 3),
              GlobalText(
                text: 'Chat · Audio · Video',
                fontSize: 11,
                color: isDark ? AppColors.darkTextSecondary : AppColors.white.withValues(alpha: 0.5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReviewsList extends StatelessWidget {
  const _ReviewsList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LawyerProfileBloc, LawyerProfileState>(
      builder: (context, state) {
        if (state.status.isLoading || state.status.isInitial) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: AdolatLoader()),
          );
        }
        return Column(
          children: state.reviews
              .map(
                (r) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ReviewCard(review: r),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _DisputeModal extends StatefulWidget {
  const _DisputeModal({required this.lawyer});

  final Lawyer lawyer;

  @override
  State<_DisputeModal> createState() => _DisputeModalState();
}

class _DisputeModalState extends State<_DisputeModal> {
  String _selectedReason = 'Advokat javob bermadi';
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submitDispute() {
    Navigator.pop(context);
    toastification.show(
      context: context,
      type: ToastificationType.warning,
      style: ToastificationStyle.fillColored,
      title: const Text('Shikoyatingiz qabul qilindi. 24 soat ichida arbitraj ko\'rib chiqadi.'),
      autoCloseDuration: const Duration(seconds: 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: EdgeInsets.fromLTRB(16, 12, 16, MediaQuery.paddingOf(context).bottom + 24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.borderStrong,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          GlobalText(
            text: 'Nizo ochish / Shikoyat qilish',
            fontSize: 16.5,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          const SizedBox(height: 14),
          const GlobalText(text: 'Shikoyat sababi:', fontSize: 13, fontWeight: FontWeight.w600),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _selectedReason,
            items: ['Advokat javob bermadi', 'Sifatsiz maslahat', 'Boshqa']
                .map((r) => DropdownMenuItem(value: r, child: GlobalText(text: r, fontSize: 13.5)))
                .toList(),
            onChanged: (val) {
              if (val != null) {
                setState(() {
                  _selectedReason = val;
                });
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
          ),
          const SizedBox(height: 14),
          const GlobalText(text: 'Qo\'shimcha izoh:', fontSize: 13, fontWeight: FontWeight.w600),
          const SizedBox(height: 6),
          GlobalTextField(
            controller: _commentController,
            hintText: 'Muammoni batafsil tasvirlang...',
            maxLine: 3,
            textColor: isDark ? AppColors.white : AppColors.navyText,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.done,
            validator: (_) => null,
          ),
          const SizedBox(height: 20),
          GlobalButton(
            onTap: _submitDispute,
            title: 'Nizo Yuborish',
            color: AppColors.danger,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
