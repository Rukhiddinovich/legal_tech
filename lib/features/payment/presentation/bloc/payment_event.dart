part of 'payment_bloc.dart';

sealed class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class PaymentMethodSelected extends PaymentEvent {
  const PaymentMethodSelected(this.methodId);

  final String methodId;

  @override
  List<Object?> get props => [methodId];
}

class PaymentRequested extends PaymentEvent {
  const PaymentRequested();
}
