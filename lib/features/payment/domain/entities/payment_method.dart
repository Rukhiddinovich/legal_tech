import 'package:equatable/equatable.dart';

/// To'lov usuli (Payme, Click, Uzum, Xalqaro karta).
///
/// [brandColorHex] — logotip fonining rangi (UI da ishlatiladi).
class PaymentMethod extends Equatable {
  const PaymentMethod({
    required this.id,
    required this.name,
    required this.badge,
    required this.brandColorHex,
    this.note,
  });

  final String id;
  final String name;

  /// Logotip o'rnidagi qisqa belgi (masalan "P", "C").
  final String badge;
  final int brandColorHex;
  final String? note;

  /// Dizaynga mos statik ro'yxat.
  static const List<PaymentMethod> all = [
    PaymentMethod(
      id: 'payme',
      name: 'Payme',
      badge: 'P',
      brandColorHex: 0xFF00CFB4,
    ),
    PaymentMethod(
      id: 'click',
      name: 'Click',
      badge: 'C',
      brandColorHex: 0xFF1A73E8,
    ),
    PaymentMethod(
      id: 'uzum',
      name: 'Uzum Bank',
      badge: 'U',
      brandColorHex: 0xFF7C3AED,
    ),
    PaymentMethod(
      id: 'intl',
      name: 'Xalqaro karta',
      badge: '⌗',
      brandColorHex: 0xFF12222F,
      note: '(Visa / MC)',
    ),
  ];

  @override
  List<Object?> get props => [id];
}
