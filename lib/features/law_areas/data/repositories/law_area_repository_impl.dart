import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/law_area.dart';
import '../../domain/repositories/law_area_repository.dart';
import '../datasources/law_area_mock_datasource.dart';

class LawAreaRepositoryImpl implements LawAreaRepository {
  const LawAreaRepositoryImpl(this._dataSource);

  final LawAreaDataSource _dataSource;

  @override
  Future<Either<Failure, List<LawArea>>> getAreas() async {
    try {
      final areas = await _dataSource.fetchAreas();
      return Right(areas);
    } catch (_) {
      return const Left(CacheFailure());
    }
  }
}
