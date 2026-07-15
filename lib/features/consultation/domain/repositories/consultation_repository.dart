import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/chat_message.dart';

/// Konsultatsiya (chat) ma'lumotlari uchun abstraksiya.
abstract interface class ConsultationRepository {
  /// Berilgan advokat bilan seansning boshlang'ich xabarlari.
  Future<Either<Failure, List<ChatMessage>>> getMessages(String lawyerId);
}
