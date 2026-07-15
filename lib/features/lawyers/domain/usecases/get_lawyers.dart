import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/lawyer.dart';
import '../repositories/lawyer_repository.dart';

/// Barcha (yoki onlayn) advokatlar ro'yxatini oladi.
class GetLawyers implements UseCase<List<Lawyer>, NoParams> {
  const GetLawyers(this._repository);

  final LawyerRepository _repository;

  @override
  Future<Either<Failure, List<Lawyer>>> call(NoParams params) {
    return _repository.getLawyers();
  }
}
