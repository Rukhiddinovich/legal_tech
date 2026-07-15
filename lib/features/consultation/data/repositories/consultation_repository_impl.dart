import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/consultation_repository.dart';
import '../datasources/consultation_mock_datasource.dart';

class ConsultationRepositoryImpl implements ConsultationRepository {
  const ConsultationRepositoryImpl(this._dataSource);

  final ConsultationDataSource _dataSource;

  @override
  Future<Either<Failure, List<ChatMessage>>> getMessages(
    String lawyerId,
  ) async {
    try {
      final messages = await _dataSource.fetchMessages(lawyerId);
      return Right(messages);
    } catch (_) {
      return const Left(CacheFailure());
    }
  }
}
