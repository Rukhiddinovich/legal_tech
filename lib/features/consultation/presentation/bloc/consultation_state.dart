part of 'consultation_bloc.dart';

class ConsultationState extends Equatable {
  const ConsultationState({
    this.status = ViewStatus.initial,
    this.messages = const [],
    this.remainingSeconds = 0,
    this.showBlockWarning = false,
    this.blockedSnippet,
    this.error,
  });

  final ViewStatus status;
  final List<ChatMessage> messages;
  final int remainingSeconds;
  final bool showBlockWarning;
  final String? blockedSnippet;
  final String? error;

  /// "MM:SS" ko'rinishidagi qolgan vaqt.
  String get remainingLabel => Formatters.timer(remainingSeconds);

  /// Vaqt tugashiga 5 daqiqadan kam qoldimi? (ogohlantirish uchun).
  bool get isLowTime => remainingSeconds <= 5 * 60;

  bool get isFinished => remainingSeconds <= 0 && status.isSuccess;

  ConsultationState copyWith({
    ViewStatus? status,
    List<ChatMessage>? messages,
    int? remainingSeconds,
    bool? showBlockWarning,
    String? blockedSnippet,
    bool clearSnippet = false,
    String? error,
  }) {
    return ConsultationState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      showBlockWarning: showBlockWarning ?? this.showBlockWarning,
      blockedSnippet: clearSnippet ? null : (blockedSnippet ?? this.blockedSnippet),
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        messages,
        remainingSeconds,
        showBlockWarning,
        blockedSnippet,
        error,
      ];
}
