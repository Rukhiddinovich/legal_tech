import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/adolat_loader.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/global_text.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/repositories/wallet_repository.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  late final Future<Either<Failure, Wallet>> _future =
      sl<WalletRepository>().getWallet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: FutureBuilder<Either<Failure, Wallet>>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: AdolatLoader(),
            );
          }
          final wallet = snapshot.data!.getOrElse(
            () => const Wallet(balance: 0, frozen: 0, transactions: []),
          );
          return SafeArea(
            bottom: false,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 14),
                  child: GlobalText(
                    text: 'Hamyon',
                    fontFamily: 'Newsreader',
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                _BalanceCard(wallet: wallet),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 10),
                  child: GlobalText(
                    text: 'Tranzaksiyalar',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                ...wallet.transactions.map(
                  (t) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _TransactionTile(transaction: t),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  const _BalanceCard({required this.wallet});

  final Wallet wallet;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlobalText(
            text: 'Mavjud balans',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.white.withValues(alpha: 0.55),
          ),
          const SizedBox(height: 6),
          Text.rich(
            TextSpan(
              text: Formatters.money(wallet.balance),
              style: AppTextStyles.serif(
                fontSize: 36,
                fontWeight: FontWeight.w600,
                color: AppColors.gold,
                height: 1,
              ),
              children: [
                TextSpan(
                  text: ' so\'m',
                  style: AppTextStyles.sans(
                    fontSize: 15,
                    color: AppColors.white.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.gold.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(CupertinoIcons.lock,
                    size: 14, color: AppColors.gold),
                const SizedBox(width: 7),
                GlobalText(
                  text: 'Escrow\'da: ${Formatters.soum(wallet.frozen)}',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.gold,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  icon: CupertinoIcons.add,
                  label: 'To\'ldirish',
                  filled: true,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: _ActionButton(
                  icon: CupertinoIcons.arrow_up_right,
                  label: 'Yechish',
                  filled: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.filled,
  });

  final IconData icon;
  final String label;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(
        color: filled ? AppColors.gold : AppColors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 17,
            color: filled ? AppColors.navyText : AppColors.white,
          ),
          const SizedBox(width: 7),
          GlobalText(
            text: label,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: filled ? AppColors.navyText : AppColors.white,
          ),
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.transaction});

  final WalletTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final credit = transaction.isCredit;

    final Color debitColor = isDark ? AppColors.white : AppColors.navy;

    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: (credit ? AppColors.online : debitColor)
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              credit ? CupertinoIcons.arrow_down_left : CupertinoIcons.arrow_up_right,
              size: 18,
              color: credit ? AppColors.online : debitColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalText(
                  text: transaction.title,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: onSurface,
                ),
                const SizedBox(height: 2),
                GlobalText(
                  text: '${transaction.subtitle} · ${transaction.dateLabel}',
                  maxLines: 1,
                  isEllipsis: true,
                  fontSize: 11.5,
                  color: AppColors.textMuted,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          GlobalText(
            text: '${credit ? '+' : '−'}${Formatters.money(transaction.amount)}',
            fontSize: 13.5,
            fontWeight: FontWeight.w800,
            color: credit ? AppColors.online : onSurface,
          ),
        ],
      ),
    );
  }
}
