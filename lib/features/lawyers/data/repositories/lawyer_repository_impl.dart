import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/lawyer.dart';
import '../../domain/entities/review.dart';
import '../../domain/repositories/lawyer_repository.dart';
import '../datasources/lawyer_mock_datasource.dart';

/// [LawyerRepository] implementatsiyasi.
///
/// Data-manba istisnolarini [Failure] ga o'giradi va domenga toza natija beradi.
class LawyerRepositoryImpl implements LawyerRepository {
  const LawyerRepositoryImpl(this._dataSource);

  final LawyerDataSource _dataSource;

  @override
  Future<Either<Failure, List<Lawyer>>> getLawyers() async {
    try {
      final lawyers = await _dataSource.fetchLawyers();
      return Right(lawyers);
    } catch (_) {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Lawyer>>> searchLawyers({
    String query = '',
    String? areaId,
  }) async {
    try {
      final all = await _dataSource.fetchLawyers();
      final normalized = query.trim().toLowerCase();

      final filtered = all.where((lawyer) {
        final matchesArea = areaId == null || lawyer.areaIds.contains(areaId);
        final matchesQuery = normalized.isEmpty ||
            lawyer.fullName.toLowerCase().contains(normalized) ||
            lawyer.specialization.toLowerCase().contains(normalized) ||
            lawyer.tags.any((t) => t.toLowerCase().contains(normalized));
        return matchesArea && matchesQuery;
      }).toList();

      return Right(filtered);
    } catch (_) {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Lawyer>> getLawyerById(String id) async {
    try {
      final all = await _dataSource.fetchLawyers();
      final match = all.where((l) => l.id == id).toList();
      if (match.isEmpty) return const Left(NotFoundFailure());
      return Right(match.first);
    } catch (_) {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Review>>> getReviews(String lawyerId) async {
    try {
      final reviews = await _dataSource.fetchReviews(lawyerId);
      return Right(reviews);
    } catch (_) {
      return const Left(CacheFailure());
    }
  }
}
