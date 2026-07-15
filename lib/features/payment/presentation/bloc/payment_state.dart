part of 'payment_bloc.dart';

/// To'lov ekranining holati.
class PaymentState extends Equatable {
  const PaymentState({
    this.selectedMethodId = 'payme',
    this.isProcessing = false,
    this.isPaid = false,
  });

  final String selectedMethodId;
  final bool isProcessing;
  final bool isPaid;

  PaymentState copyWith({
    String? selectedMethodId,
    bool? isProcessing,
    bool? isPaid,
  }) {
    return PaymentState(
      selectedMethodId: selectedMethodId ?? this.selectedMethodId,
      isProcessing: isProcessing ?? this.isProcessing,
      isPaid: isPaid ?? this.isPaid,
    );
  }

  @override
  List<Object?> get props => [selectedMethodId, isProcessing, isPaid];
}
