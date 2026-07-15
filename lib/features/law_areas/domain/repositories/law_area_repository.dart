import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/law_area.dart';

/// Huquq sohalari ro'yxati uchun abstraksiya.
abstract interface class LawAreaRepository {
  Future<Either<Failure, List<LawArea>>> getAreas();
}
