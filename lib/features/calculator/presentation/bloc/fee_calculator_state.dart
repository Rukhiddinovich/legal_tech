part of 'fee_calculator_bloc.dart';

class FeeCalculatorState extends Equatable {
  const FeeCalculatorState({
    required this.type,
    required this.amount,
    required this.result,
  });

  final FeeType type;
  final num amount;
  final FeeResult result;

  int get bhm => CalculateFee.bhm2026;

  FeeCalculatorState copyWith({
    FeeType? type,
    num? amount,
    FeeResult? result,
  }) {
    return FeeCalculatorState(
      type: type ?? this.type,
      amount: amount ?? this.amount,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [type, amount, result];
}
