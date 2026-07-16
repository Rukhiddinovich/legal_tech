import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/thousands_input_formatter.dart';
import '../../../../core/widgets/global_button.dart';
import '../../../../core/widgets/global_text.dart';
import '../../../../core/widgets/global_text_field.dart';
import '../../../../core/widgets/section_header.dart';
import '../../domain/entities/fee_result.dart';
import '../../domain/entities/fee_type.dart';
import '../bloc/fee_calculator_bloc.dart';

/// 06 — Davlat boji kalkulyatori.
class FeeCalculatorPage extends StatelessWidget {
  const FeeCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeeCalculatorBloc>(
      create: (_) => sl<FeeCalculatorBloc>(),
      child: const _CalculatorView(),
    );
  }
}

class _CalculatorView extends StatefulWidget {
  const _CalculatorView();

  @override
  State<_CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<_CalculatorView> {
  late final TextEditingController _amountController = TextEditingController(
    text: Formatters.money(context.read<FeeCalculatorBloc>().state.amount),
  );

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _onAmountChanged(String value) {
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    final amount = digits.isEmpty ? 0 : int.parse(digits);
    context.read<FeeCalculatorBloc>().add(FeeAmountChanged(amount));
  }

  Future<void> _pickType() async {
    final bloc = context.read<FeeCalculatorBloc>();
    final selected = await showModalBottomSheet<FeeType>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _TypePickerSheet(current: bloc.state.type),
    );
    if (selected != null) bloc.add(FeeTypeSelected(selected));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          _Header(),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 40),
              children: [
                GlobalText(
                  text: 'Sud va notarius bojlarini Bazaviy hisoblash miqdori (BHM) '
                      'va qonuniy foizlar asosida hisoblang.',
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.55,
                ),
                const SizedBox(height: 18),
                const FieldLabel('Boj turi'),
                BlocBuilder<FeeCalculatorBloc, FeeCalculatorState>(
                  buildWhen: (p, c) => p.type != c.type,
                  builder: (context, state) => _TypeSelector(
                    label: state.type.label,
                    onTap: _pickType,
                  ),
                ),
                const SizedBox(height: 16),
                const FieldLabel('Da\'vo summasi (so\'m)'),
                GlobalTextField(
                  controller: _amountController,
                  hintText: '0',
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  formatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    ThousandsInputFormatter(),
                  ],
                  onChanged: _onAmountChanged,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  textColor: AppColors.navyText,
                  validator: (_) => null,
                ),
                const SizedBox(height: 12),
                _BhmBanner(),
                const SizedBox(height: 20),
                BlocBuilder<FeeCalculatorBloc, FeeCalculatorState>(
                  builder: (context, state) => _ResultCard(result: state.result),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: GlobalButton(
                        title: 'Batafsil',
                        onTap: () {},
                        color: Theme.of(context).cardColor,
                        textColor: Theme.of(context).colorScheme.onSurface,
                        borderColor: AppColors.borderStrong,
                        radius: 16,
                        fontFamily: 'Manrope',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      child: GlobalButton(
                        title: 'Hujjatga qo\'shish',
                        onTap: () {},
                        color: AppColors.navy,
                        textColor: AppColors.white,
                        radius: 16,
                        fontFamily: 'Manrope',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;
    return Container(
      padding:
          EdgeInsets.fromLTRB(AppSpacing.xl, topPad + 14, AppSpacing.xl, 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: const Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Material(
            color: AppColors.chipBg,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () => Navigator.pop(context),
              child: const SizedBox(
                width: 38,
                height: 38,
                child: Icon(
                  CupertinoIcons.back,
                  size: 18,
                  color: AppColors.navyText,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          GlobalText(
            text: 'Boj kalkulyatori',
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ],
      ),
    );
  }
}

class _TypeSelector extends StatelessWidget {
  const _TypeSelector({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        borderRadius: BorderRadius.circular(13),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: AppColors.borderStrong),
          ),
          child: Row(
            children: [
              Expanded(
                child: GlobalText(
                  text: label,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.navyText,
                ),
              ),
              const Icon(
                CupertinoIcons.chevron_down,
                color: AppColors.textMuted,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BhmBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
      decoration: BoxDecoration(
        color: AppColors.goldDark.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: [
          const Icon(CupertinoIcons.info, size: 15, color: AppColors.goldDark),
          const SizedBox(width: 8),
          GlobalText(
            text: '1 BHM = ${Formatters.money(412000)} so\'m (2026-yil)',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF8A6F34),
          ),
        ],
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.result});

  final FeeResult result;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlobalText(
            text: 'To\'lanadigan davlat boji',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.white.withValues(alpha: 0.55),
          ),
          const SizedBox(height: 6),
          Text.rich(
            TextSpan(
              text: Formatters.money(result.total),
              style: AppTextStyles.serif(
                fontSize: 38,
                fontWeight: FontWeight.w600,
                color: AppColors.gold,
                height: 1,
              ),
              children: [
                TextSpan(
                  text: ' so\'m',
                  style: AppTextStyles.sans(
                    fontSize: 16,
                    color: AppColors.white.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Divider(color: AppColors.white.withValues(alpha: 0.12)),
          const SizedBox(height: 12),
          ...result.lines.map(
            (line) => Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GlobalText(
                    text: line.label,
                    fontSize: 12.5,
                    color: AppColors.white.withValues(alpha: 0.6),
                  ),
                  GlobalText(
                    text: line.value,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypePickerSheet extends StatelessWidget {
  const _TypePickerSheet({required this.current});

  final FeeType current;

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.paddingOf(context).bottom;
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 10, 16, bottomPad + 16),
        child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(
                color: AppColors.borderStrong,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: GlobalText(
              text: 'Boj turini tanlang',
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          ...FeeType.all.map(
            (type) => ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 4),
              onTap: () => Navigator.pop(context, type),
              title: GlobalText(
                text: type.label,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              subtitle: GlobalText(
                text: type.hint,
                fontSize: 12,
                color: AppColors.textMuted,
              ),
              trailing: type.id == current.id
                  ? const Icon(CupertinoIcons.check_mark_circled_solid,
                      color: AppColors.navy, size: 20)
                  : null,
            ),
          ),
        ],
      ),
      ),
    );
  }
}
