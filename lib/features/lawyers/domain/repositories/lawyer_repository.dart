import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/lawyer.dart';
import '../entities/review.dart';

/// Advokatlar ma'lumotlari uchun abstraksiya.
///
/// Har bir metod [Either] qaytaradi: chapda [Failure], o'ngda natija —
/// bu bilan xatoliklar tip darajasida ushlanadi (funksional yondashuv).
abstract interface class LawyerRepository {
  Future<Either<Failure, List<Lawyer>>> getLawyers();

  Future<Either<Failure, List<Lawyer>>> searchLawyers({
    String query,
    String? areaId,
  });

  Future<Either<Failure, Lawyer>> getLawyerById(String id);

  Future<Either<Failure, List<Review>>> getReviews(String lawyerId);
}
