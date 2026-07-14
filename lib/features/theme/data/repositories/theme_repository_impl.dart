import 'package:dartz/dartz.dart';
import 'package:legal_tech/core/errors/exceptions.dart';
import 'package:legal_tech/core/errors/failures.dart';
import 'package:legal_tech/features/theme/data/datasources/theme_local_datasources.dart';
import 'package:legal_tech/features/theme/data/models/theme_model.dart';
import 'package:legal_tech/features/theme/domain/entities/theme_entity.dart';
import 'package:legal_tech/features/theme/domain/repositories/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource localDataSource;

  ThemeRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, ThemeModel>> getTheme() async {
    try {
      final themeModel = await localDataSource.getTheme();
      return Right(themeModel);
    } on CacheException {
      return const Left(
        CacheFailure(message: 'Failed to get theme from cache'),
      );
    } catch (e) {
      return Left(
        CacheFailure(
          message:
              'Unexpected error occurred while getting theme: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> setTheme(ThemeEntity theme) async {
    try {
      final themeModel = ThemeModel.fromEntity(theme);
      await localDataSource.setTheme(themeModel);
      return const Right(null);
    } on CacheException {
      return const Left(CacheFailure(message: 'Failed to save theme to cache'));
    } catch (e) {
      return Left(
        CacheFailure(
          message:
              'Unexpected error occurred while saving theme: ${e.toString()}',
        ),
      );
    }
  }
}
