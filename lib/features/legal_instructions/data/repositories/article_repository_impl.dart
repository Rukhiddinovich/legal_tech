import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../datasources/article_mock_data.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleDataSource _dataSource;

  ArticleRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<Article>>> getArticles() async {
    try {
      final list = await _dataSource.fetchArticles();
      return Right(list);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
