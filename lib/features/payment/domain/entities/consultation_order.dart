import 'package:equatable/equatable.dart';

/// To'lovga tayyorlanган konsultatsiya buyurtmasi.
///
/// Split-payment (escrow) mantiqiga ko'ra to'lov platformada saqlanadi.
class ConsultationOrder extends Equatable {
  const ConsultationOrder({
    required this.lawyerId,
    required this.lawyerName,
    required this.lawyerSpecialization,
    required this.serviceType,
    required this.durationLabel,
    required this.format,
    required this.price,
    this.serviceFee = 0,
  });

  final String lawyerId;
  final String lawyerName;
  final String lawyerSpecialization;
  final String serviceType;
  final String durationLabel;
  final String format;
  final int price;
  final int serviceFee;

  int get total => price + serviceFee;

  @override
  List<Object?> get props => [lawyerId, price, serviceFee];
}
