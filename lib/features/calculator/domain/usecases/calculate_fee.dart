import '../entities/fee_result.dart';
import '../entities/fee_type.dart';

/// Davlat bojini hisoblovchi use-case.
///
/// Sof funksiya — tashqi bog'liqliksiz, to'liq test qilinadi.
/// Backend talab qilinmaydi, chunki hisob formula asosida bajariladi.
class CalculateFee {
  const CalculateFee();

  /// 2026-yil uchun Bazaviy hisoblash miqdori (so'm).
  static const int bhm2026 = 412000;

  FeeResult call({
    required FeeType type,
    required num amount,
    int bhm = bhm2026,
  }) {
    return type.calculate(amount: amount, bhm: bhm);
  }
}
