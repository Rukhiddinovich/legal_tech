import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/fee_result.dart';
import '../../domain/entities/fee_type.dart';
import '../../domain/usecases/calculate_fee.dart';

part 'fee_calculator_event.dart';
part 'fee_calculator_state.dart';

/// Davlat boji kalkulyatori logikasi.
///
/// Har o'zgarishda [CalculateFee] use-case orqali natijani qayta hisoblaydi.
class FeeCalculatorBloc extends Bloc<FeeCalculatorEvent, FeeCalculatorState> {
  FeeCalculatorBloc(this._calculateFee)
      : super(
          FeeCalculatorState(
            type: _initialType,
            amount: _initialAmount,
            result: const CalculateFee()(
              type: _initialType,
              amount: _initialAmount,
            ),
          ),
        ) {
    on<FeeTypeSelected>(_onTypeSelected);
    on<FeeAmountChanged>(_onAmountChanged);
  }

  final CalculateFee _calculateFee;

  static const FeeType _initialType = PropertyClaimCourtFee();
  static const num _initialAmount = 25000000;

  void _onTypeSelected(
    FeeTypeSelected event,
    Emitter<FeeCalculatorState> emit,
  ) {
    emit(
      state.copyWith(
        type: event.type,
        result: _calculateFee(type: event.type, amount: state.amount),
      ),
    );
  }

  void _onAmountChanged(
    FeeAmountChanged event,
    Emitter<FeeCalculatorState> emit,
  ) {
    emit(
      state.copyWith(
        amount: event.amount,
        result: _calculateFee(type: state.type, amount: event.amount),
      ),
    );
  }
}
