import '../../domain/entities/chat_message.dart';

abstract interface class ConsultationDataSource {
  Future<List<ChatMessage>> fetchMessages(String lawyerId);
}

/// Dizayn maketidagi boshlang'ich suhbat.
class ConsultationMockDataSource implements ConsultationDataSource {
  @override
  Future<List<ChatMessage>> fetchMessages(String lawyerId) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return const [
      ChatMessage(
        id: 'm1',
        text: 'Assalomu alaykum! Meros bo\'yicha savolingizni eshitaman.',
        isMine: false,
        timeLabel: '14:32',
      ),
      ChatMessage(
        id: 'm2',
        text: 'Otamdan qolgan uy 3 farzandga qanday bo\'linadi?',
        isMine: true,
        timeLabel: '14:33',
      ),
      ChatMessage(
        id: 'm3',
        text:
            'Vasiyat bo\'lmasa, meros qonun bo\'yicha teng ulushlarda '
            'bo\'linadi. Rafiqa ham birinchi navbat vorisi hisoblanadi.',
        isMine: false,
        timeLabel: '14:34',
      ),
    ];
  }
}
