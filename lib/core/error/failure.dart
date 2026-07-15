import 'package:equatable/equatable.dart';

/// Domen darajasidagi xatoliklar uchun asosiy tip.
///
/// Repository'lar `Either<Failure, T>` qaytaradi — shu bilan istisnolar
/// prezentatsiya qatlamiga chiqmasdan, tiplashtirilgan holda uzatiladi.
sealed class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

/// Ma'lumot manbai (lokal/mock) bilan bog'liq xatolik.
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Ma\'lumotlarni o\'qishda xatolik']);
}

/// Server/tarmoq xatoligi (kelajakdagi API uchun).
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server bilan bog\'lanishda xatolik']);
}

/// So'ralgan resurs topilmadi.
class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Ma\'lumot topilmadi']);
}

/// Validatsiya xatoligi.
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
