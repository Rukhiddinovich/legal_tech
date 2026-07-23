import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/adolat_loader.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/router/app_route_names.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../../../../core/widgets/global_button.dart';
import '../../../../core/widgets/global_text.dart';
import '../../../../core/widgets/gradient_avatar.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../lawyers/domain/entities/lawyer.dart';
import '../../domain/entities/consultation_order.dart';
import '../../domain/entities/payment_method.dart';
import '../bloc/payment_bloc.dart';

/// 03 — Himoyalangan to'lov (checkout).
class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key, required this.lawyer});

  final Lawyer lawyer;

  ConsultationOrder get _order => ConsultationOrder(
    lawyerId: lawyer.id,
    lawyerName: lawyer.fullName,
    lawyerSpecialization: lawyer.specialization,
    serviceType: 'Tezkor konsultatsiya',
    durationLabel: '${lawyer.sessionMinutes} daqiqagacha',
    format: 'Chat / Video',
    price: lawyer.pricePerSession,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentBloc>(
      create: (_) => PaymentBloc(),
      child: _CheckoutView(lawyer: lawyer, order: _order),
    );
  }
}

class _CheckoutView extends StatelessWidget {
  const _CheckoutView({required this.lawyer, required this.order});

  final Lawyer lawyer;
  final ConsultationOrder order;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listenWhen: (prev, curr) => !prev.isPaid && curr.isPaid,
      listener: (context, state) {
        context.pushReplacement(
          AppRouteNames.consultation,
          extra: lawyer,
        );
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: GlobalAppBar(
          backgroundColor: Theme.of(context).cardColor,
          elevation: 0,
          title: GlobalText(
            text: 'To\'lov',
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _OrderSummaryCard(lawyer: lawyer, order: order),
                    const SizedBox(height: 20),
                    const SectionHeader(title: 'To\'lov usuli'),
                    const SizedBox(height: 10),
                    const _PaymentMethods(),
                    const SizedBox(height: 18),
                    _PriceBreakdown(order: order),
                    const SizedBox(height: 14),
                    const _EscrowBanner(),
                  ],
                ),
              ),
            ),
            _PayBar(order: order),
          ],
        ),
      ),
    );
  }
}



class _OrderSummaryCard extends StatelessWidget {
  const _OrderSummaryCard({required this.lawyer, required this.order});

  final Lawyer lawyer;
  final ConsultationOrder order;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return AppCard(
      child: Column(
        children: [
          Row(
            children: [
              GradientAvatar(
                name: lawyer.fullName,
                size: 46,
                borderColor: Theme.of(context).cardColor,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlobalText(
                      text: lawyer.fullName,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.darkTextPrimary : onSurface,
                    ),
                    const SizedBox(height: 2),
                    GlobalText(
                      text: lawyer.specialization,
                      maxLines: 1,
                      isEllipsis: true,
                      fontSize: 12,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.textMuted,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(),
          ),
          _row(context, 'Xizmat turi', order.serviceType),
          const SizedBox(height: 9),
          _row(context, 'Davomiyligi', order.durationLabel),
          const SizedBox(height: 9),
          _row(context, 'Format', order.format),
        ],
      ),
    );
  }

  Widget _row(BuildContext context, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GlobalText(
          text: label,
          fontSize: 13,
          color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
        ),
        Flexible(
          child: GlobalText(
            text: value,
            textAlign: TextAlign.right,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _PaymentMethods extends StatelessWidget {
  const _PaymentMethods();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      buildWhen: (p, c) => p.selectedMethodId != c.selectedMethodId,
      builder: (context, state) {
        return Column(
          children: PaymentMethod.all
              .map(
                (m) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _PaymentTile(
                method: m,
                selected: state.selectedMethodId == m.id,
                onTap: () => context
                    .read<PaymentBloc>()
                    .add(PaymentMethodSelected(m.id)),
              ),
            ),
          )
              .toList(),
        );
      },
    );
  }
}

class _PaymentTile extends StatelessWidget {
  const _PaymentTile({
    required this.method,
    required this.selected,
    required this.onTap,
  });

  final PaymentMethod method;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final borderColor = isDark
        ? (selected ? AppColors.darkTextPrimary : AppColors.darkBorder)
        : (selected ? AppColors.navy : AppColors.borderStrong);

    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: borderColor,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(method.brandColorHex),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: GlobalText(
                  text: method.badge,
                  color: AppColors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    text: method.name,
                    style: AppTextStyles.sans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: onSurface,
                    ),
                    children: [
                      if (method.note != null)
                        TextSpan(
                          text: ' ${method.note}',
                          style: AppTextStyles.sans(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: isDark ? AppColors.darkTextSecondary : AppColors.textMuted,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              _RadioDot(selected: selected),
            ],
          ),
        ),
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  const _RadioDot({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeColor = isDark ? AppColors.darkTextPrimary : AppColors.navy;
    final inactiveColor = isDark ? const Color(0xFF4B5563) : const Color(0xFFC7CDD4);
    final innerColor = isDark ? Theme.of(context).cardColor : AppColors.white;

    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: innerColor,
        border: Border.all(
          color: selected ? activeColor : inactiveColor,
          width: selected ? 6 : 1.5,
        ),
      ),
    );
  }
}

class _PriceBreakdown extends StatelessWidget {
  const _PriceBreakdown({required this.order});

  final ConsultationOrder order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        children: [
          _line(context, 'Xizmat narxi', Formatters.soum(order.price)),
          const SizedBox(height: 9),
          _line(
            context,
            'Xizmat haqi',
            Formatters.soum(order.serviceFee),
            valueColor: AppColors.online,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 11),
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GlobalText(
                text: 'Jami',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              GlobalText(
                text: Formatters.soum(order.total),
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _line(BuildContext context, String label, String value, {Color? valueColor}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GlobalText(
          text: label,
          fontSize: 13,
          color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
        ),
        GlobalText(
          text: value,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: valueColor ?? (isDark ? AppColors.darkTextPrimary : AppColors.textPrimary),
        ),
      ],
    );
  }
}

class _EscrowBanner extends StatelessWidget {
  const _EscrowBanner();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? AppColors.gold : const Color(0xFF5A441C);
    final subtitleColor = isDark ? const Color(0xFFD4AF60) : const Color(0xFF6B5426);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.goldDark.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.goldDark.withValues(alpha: 0.22)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(CupertinoIcons.shield, size: 20, color: AppColors.goldDark),
          const SizedBox(width: 11),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: 'Pulingiz himoyada. ',
                style: AppTextStyles.sans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: titleColor,
                  height: 1.5,
                ),
                children: [
                  TextSpan(
                    text:
                    'To\'lov platforma hisobida saqlanadi va konsultatsiya '
                        'yakunlangach advokatga o\'tkaziladi.',
                    style: AppTextStyles.sans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: subtitleColor,
                      height: 1.5,
                    ),
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

class _PayBar extends StatelessWidget {
  const _PayBar({required this.order});

  final ConsultationOrder order;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        if (state.isProcessing) {
          return const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 30),
            child: _ProcessingButton(),
          );
        }
        return GlobalButton(
          onTap: () => context.read<PaymentBloc>().add(const PaymentRequested()),
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
          title: '${Formatters.soum(order.total)} to\'lash',
          color: isDark ? AppColors.darkTextPrimary : AppColors.navy,
          textColor: isDark ? AppColors.black : AppColors.white,
        );
      },
    );
  }
}

class _ProcessingButton extends StatelessWidget {
  const _ProcessingButton();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkTextPrimary : AppColors.navy,
        borderRadius: BorderRadius.circular(28),
      ),
      child: AdolatLoader(
        color: isDark ? AppColors.black : AppColors.white,
        size: 24,
      ),
    );
  }
}