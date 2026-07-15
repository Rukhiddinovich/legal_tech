import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/repositories/wallet_repository.dart';

/// Hamyon uchun statik (in-memory) implementatsiya.
class WalletRepositoryImpl implements WalletRepository {
  @override
  Future<Either<Failure, Wallet>> getWallet() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const Right(
      Wallet(
        balance: 1250000,
        frozen: 150000,
        transactions: [
          WalletTransaction(
            id: 't1',
            title: 'Konsultatsiya to\'lovi',
            subtitle: 'Dilnoza Karimova',
            amount: 150000,
            isCredit: false,
            dateLabel: 'Bugun, 14:32',
          ),
          WalletTransaction(
            id: 't2',
            title: 'Hisob to\'ldirish',
            subtitle: 'Payme orqali',
            amount: 500000,
            isCredit: true,
            dateLabel: 'Kecha, 09:15',
          ),
          WalletTransaction(
            id: 't3',
            title: 'Hujjat generatsiyasi',
            subtitle: 'Da\'vo arizasi — PDF',
            amount: 50000,
            isCredit: false,
            dateLabel: '12-iyul, 18:40',
          ),
          WalletTransaction(
            id: 't4',
            title: 'Hisob to\'ldirish',
            subtitle: 'Uzum Bank orqali',
            amount: 1000000,
            isCredit: true,
            dateLabel: '10-iyul, 11:02',
          ),
        ],
      ),
    );
  }
}
