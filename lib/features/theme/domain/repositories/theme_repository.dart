import 'package:dartz/dartz.dart';
import 'package:legal_tech/core/errors/failures.dart';
import 'package:legal_tech/features/theme/domain/entities/theme_entity.dart';

abstract class ThemeRepository {
  Future<Either<Failure, ThemeEntity>> getTheme();
  Future<Either<Failure, void>> setTheme(ThemeEntity theme);
}
