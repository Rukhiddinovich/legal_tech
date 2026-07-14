import 'package:dartz/dartz.dart';
import 'package:legal_tech/core/errors/failures.dart';
import 'package:legal_tech/core/usecases/usecase.dart';
import '../entities/theme_entity.dart';
import '../repositories/theme_repository.dart';

class GetThemeUseCase implements UseCase<ThemeEntity, NoParams> {
  final ThemeRepository repository;

  GetThemeUseCase(this.repository);

  @override
  Future<Either<Failure, ThemeEntity>> call(NoParams params) async {
    return await repository.getTheme();
  }
}
