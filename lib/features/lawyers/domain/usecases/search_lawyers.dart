import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/lawyer.dart';
import '../repositories/lawyer_repository.dart';

/// Advokatlarni matn va/yoki soha bo'yicha qidiradi.
class SearchLawyers implements UseCase<List<Lawyer>, SearchLawyersParams> {
  const SearchLawyers(this._repository);

  final LawyerRepository _repository;

  @override
  Future<Either<Failure, List<Lawyer>>> call(SearchLawyersParams params) {
    return _repository.searchLawyers(
      query: params.query,
      areaId: params.areaId,
    );
  }
}

class SearchLawyersParams extends Equatable {
  const SearchLawyersParams({this.query = '', this.areaId});

  final String query;
  final String? areaId;

  @override
  List<Object?> get props => [query, areaId];
}
