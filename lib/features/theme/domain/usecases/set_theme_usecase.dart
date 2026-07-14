import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:legal_tech/core/errors/failures.dart';
import 'package:legal_tech/core/usecases/usecase.dart';
import '../entities/theme_entity.dart';
import '../repositories/theme_repository.dart';

class SetThemeUseCase implements UseCase<void, SetThemeParams> {
  final ThemeRepository repository;

  SetThemeUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(SetThemeParams params) async {
    return await repository.setTheme(params.theme);
  }
}

class SetThemeParams extends Equatable {
  final ThemeEntity theme;

  const SetThemeParams({required this.theme});

  @override
  List<Object> get props => [theme];
}
