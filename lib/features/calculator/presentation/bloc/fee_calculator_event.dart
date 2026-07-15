part of 'fee_calculator_bloc.dart';

sealed class FeeCalculatorEvent extends Equatable {
  const FeeCalculatorEvent();

  @override
  List<Object?> get props => [];
}

/// Boj turi tanlandi.
class FeeTypeSelected extends FeeCalculatorEvent {
  const FeeTypeSelected(this.type);

  final FeeType type;

  @override
  List<Object?> get props => [type];
}

/// Da'vo summasi o'zgardi.
class FeeAmountChanged extends FeeCalculatorEvent {
  const FeeAmountChanged(this.amount);

  final num amount;

  @override
  List<Object?> get props => [amount];
}
