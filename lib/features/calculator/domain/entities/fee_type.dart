import 'fee_result.dart';

/// Davlat boji turini modellashtiruvchi sealed hierarxiya (Strategy pattern).
///
/// Har bir tur o'zining hisoblash qoidasini [calculate] da inkapsulyatsiya
/// qiladi — yangi boj turi qo'shish uchun mavjud kodni o'zgartirish shart emas
/// (Open/Closed printsipi).
sealed class FeeType {
  const FeeType({required this.id, required this.label, required this.hint});

  final String id;
  final String label;
  final String hint;

  /// [amount] — da'vo/bitim summasi, [bhm] — bazaviy hisoblash miqdori.
  FeeResult calculate({required num amount, required num bhm});

  /// UI dropdown uchun barcha mavjud turlar.
  static const List<FeeType> all = [
    PropertyClaimCourtFee(),
    DivorceCourtFee(),
    InheritanceNotaryFee(),
    ContractNotaryFee(),
  ];
}

/// Mulkiy da'vo (sud) — da'vo summasining 3% i.
class PropertyClaimCourtFee extends FeeType {
  const PropertyClaimCourtFee()
      : super(
          id: 'property_claim',
          label: 'Mulkiy da\'vo (sud)',
          hint: 'Sud boji',
        );

  static const double _rate = 0.03;

  @override
  FeeResult calculate({required num amount, required num bhm}) {
    final fee = (amount * _rate).round();
    return FeeResult(
      total: fee,
      lines: [
        FeeLine('Da\'vo summasi', '${_money(amount)} so\'m'),
        FeeLine('Stavka (3%)', '${_money(fee)} so\'m'),
        const FeeLine('Notarius tasdig\'i', 'Talab etilmaydi'),
      ],
      needsNotary: false,
    );
  }
}

/// Nikohdan ajralish (sud) — 1 BHM miqdorida qat'iy boj.
class DivorceCourtFee extends FeeType {
  const DivorceCourtFee()
      : super(
          id: 'divorce',
          label: 'Nikohdan ajralish (sud)',
          hint: 'Sud boji',
        );

  @override
  FeeResult calculate({required num amount, required num bhm}) {
    final fee = bhm.round();
    return FeeResult(
      total: fee,
      lines: [
        FeeLine('Stavka', '1 BHM'),
        FeeLine('1 BHM', '${_money(bhm)} so\'m'),
        const FeeLine('Notarius tasdig\'i', 'Talab etilmaydi'),
      ],
      needsNotary: false,
    );
  }
}

/// Meros guvohnomasi (notarius) — meros summasining 1% i.
class InheritanceNotaryFee extends FeeType {
  const InheritanceNotaryFee()
      : super(
          id: 'inheritance_notary',
          label: 'Meros guvohnomasi (notarius)',
          hint: 'Notarius boji',
        );

  static const double _rate = 0.01;

  @override
  FeeResult calculate({required num amount, required num bhm}) {
    final fee = (amount * _rate).round();
    return FeeResult(
      total: fee,
      lines: [
        FeeLine('Meros summasi', '${_money(amount)} so\'m'),
        FeeLine('Stavka (1%)', '${_money(fee)} so\'m'),
        const FeeLine('Notarius tasdig\'i', 'Talab etiladi'),
      ],
      needsNotary: true,
    );
  }
}

/// Shartnoma tasdig'i (notarius) — bitim summasining 1% i, minimal 0.5 BHM.
class ContractNotaryFee extends FeeType {
  const ContractNotaryFee()
      : super(
          id: 'contract_notary',
          label: 'Shartnoma tasdig\'i (notarius)',
          hint: 'Notarius boji',
        );

  static const double _rate = 0.01;

  @override
  FeeResult calculate({required num amount, required num bhm}) {
    final raw = (amount * _rate).round();
    final minimum = (bhm * 0.5).round();
    final fee = raw < minimum ? minimum : raw;
    return FeeResult(
      total: fee,
      lines: [
        FeeLine('Bitim summasi', '${_money(amount)} so\'m'),
        FeeLine('Stavka (1%)', '${_money(raw)} so\'m'),
        FeeLine('Minimal (0.5 BHM)', '${_money(minimum)} so\'m'),
      ],
      needsNotary: true,
    );
  }
}

// Faylning ichki yordamchisi (Formatters ni domenga kiritmaslik uchun).
String _money(num value) {
  final str = value.round().abs().toString();
  final buffer = StringBuffer();
  for (int i = 0; i < str.length; i++) {
    if (i != 0 && (str.length - i) % 3 == 0) buffer.write(' ');
    buffer.write(str[i]);
  }
  return buffer.toString();
}
