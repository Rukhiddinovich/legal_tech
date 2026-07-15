import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/document_template.dart';

/// Hujjat shablonlari uchun abstraksiya.
abstract interface class DocumentRepository {
  Future<Either<Failure, List<DocumentTemplate>>> getTemplates();
}
