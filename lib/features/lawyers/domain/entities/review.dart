import 'package:equatable/equatable.dart';

/// Advokat haqidagi sharh (reyting tizimi).
///
/// [verified] — PRD talabiga ko'ra, faqat to'lov qilgan real mijoz sharhi.
class Review extends Equatable {
  const Review({
    required this.id,
    required this.authorName,
    required this.rating,
    required this.text,
    required this.verified,
  });

  final String id;
  final String authorName;
  final int rating;
  final String text;
  final bool verified;

  @override
  List<Object?> get props => [id];
}
