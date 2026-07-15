part of 'consultation_bloc.dart';

sealed class ConsultationEvent extends Equatable {
  const ConsultationEvent();

  @override
  List<Object?> get props => [];
}

class ConsultationStarted extends ConsultationEvent {
  const ConsultationStarted(this.lawyerId);

  final String lawyerId;

  @override
  List<Object?> get props => [lawyerId];
}

class ConsultationMessageSent extends ConsultationEvent {
  const ConsultationMessageSent(this.text);

  final String text;

  @override
  List<Object?> get props => [text];
}

class ConsultationTicked extends ConsultationEvent {
  const ConsultationTicked();
}

class ConsultationWarningDismissed extends ConsultationEvent {
  const ConsultationWarningDismissed();
}

class ConsultationExtended extends ConsultationEvent {
  const ConsultationExtended();
}
