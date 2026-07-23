import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/article.dart';

abstract interface class ArticleRepository {
  Future<Either<Failure, List<Article>>> getArticles();
}
