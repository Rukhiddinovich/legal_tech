import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/review.dart';
import '../repositories/lawyer_repository.dart';

/// Berilgan advokat uchun sharhlarni oladi.
class GetLawyerReviews implements UseCase<List<Review>, String> {
  const GetLawyerReviews(this._repository);

  final LawyerRepository _repository;

  @override
  Future<Either<Failure, List<Review>>> call(String lawyerId) {
    return _repository.getReviews(lawyerId);
  }
}
