import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/document_template.dart';
import '../../domain/repositories/document_repository.dart';
import '../datasources/document_mock_datasource.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  const DocumentRepositoryImpl(this._dataSource);

  final DocumentDataSource _dataSource;

  @override
  Future<Either<Failure, List<DocumentTemplate>>> getTemplates() async {
    try {
      final templates = await _dataSource.fetchTemplates();
      return Right(templates);
    } catch (_) {
      return const Left(CacheFailure());
    }
  }
}
