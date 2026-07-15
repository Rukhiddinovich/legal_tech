import 'package:equatable/equatable.dart';

/// Mijozning platformadagi virtual hamyoni.
class Wallet extends Equatable {
  const Wallet({
    required this.balance,
    required this.frozen,
    required this.transactions,
  });

  /// Mavjud balans (so'm).
  final int balance;

  /// Escrow'da (konsultatsiya yakunini kutayotgan) muzlatilgan summa.
  final int frozen;
  final List<WalletTransaction> transactions;

  @override
  List<Object?> get props => [balance, frozen, transactions];
}

/// Hamyon tranzaksiyasi.
class WalletTransaction extends Equatable {
  const WalletTransaction({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isCredit,
    required this.dateLabel,
  });

  final String id;
  final String title;
  final String subtitle;
  final int amount;

  /// True — kirim (+), false — chiqim (−).
  final bool isCredit;
  final String dateLabel;

  @override
  List<Object?> get props => [id];
}
