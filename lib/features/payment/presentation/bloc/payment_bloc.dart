import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(const PaymentState()) {
    on<PaymentMethodSelected>(
      (event, emit) => emit(state.copyWith(selectedMethodId: event.methodId)),
    );
    on<PaymentRequested>(_onPay);
  }

  Future<void> _onPay(PaymentRequested event, Emitter<PaymentState> emit) async {
    if (state.isProcessing) return;
    emit(state.copyWith(isProcessing: true));
    await Future<void>.delayed(const Duration(milliseconds: 1400));
    emit(state.copyWith(isProcessing: false, isPaid: true));
  }
}
