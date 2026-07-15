import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart';

/// Barcha use-case'lar uchun umumiy shartnoma.
///
/// [Type] — natija turi, [Params] — kirish parametrlari.
/// Har bir use-case bitta vazifani bajaradi (SRP).
abstract interface class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Parametr talab qilmaydigan use-case'lar uchun bo'sh obyekt.
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
