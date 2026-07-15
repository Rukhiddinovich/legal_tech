import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/view_status.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/consultation_repository.dart';

part 'consultation_event.dart';
part 'consultation_state.dart';

/// Konsultatsiya chati logikasi:
///  • boshlang'ich xabarlarni yuklash;
///  • seans taymeri (30 daqiqa) — teskari sanoq;
///  • xabar yuborish + anti-chetlab o'tish filtri (PRD 5-bo'lim);
///  • vaqtni uzaytirish.
class ConsultationBloc extends Bloc<ConsultationEvent, ConsultationState> {
  ConsultationBloc(this._repository) : super(const ConsultationState()) {
    on<ConsultationStarted>(_onStarted);
    on<ConsultationMessageSent>(_onMessageSent);
    on<ConsultationTicked>(_onTicked);
    on<ConsultationWarningDismissed>(_onWarningDismissed);
    on<ConsultationExtended>(_onExtended);
  }

  final ConsultationRepository _repository;
  StreamSubscription<int>? _ticker;

  /// Seansning to'liq davomiyligi (30 daqiqa).
  static const int _sessionSeconds = 30 * 60;

  /// Uzaytirish uchun qo'shiladigan vaqt (15 daqiqa).
  static const int _extensionSeconds = 15 * 60;

  Future<void> _onStarted(
    ConsultationStarted event,
    Emitter<ConsultationState> emit,
  ) async {
    emit(state.copyWith(status: ViewStatus.loading));
    final result = await _repository.getMessages(event.lawyerId);

    result.fold(
      (failure) => emit(
        state.copyWith(status: ViewStatus.failure, error: failure.message),
      ),
      (messages) {
        emit(
          state.copyWith(
            status: ViewStatus.success,
            messages: messages,
            remainingSeconds: _sessionSeconds,
          ),
        );
        _startTicker();
      },
    );
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Stream<int>.periodic(const Duration(seconds: 1), (i) => i).listen(
      (_) => add(const ConsultationTicked()),
    );
  }

  void _onTicked(ConsultationTicked event, Emitter<ConsultationState> emit) {
    final next = state.remainingSeconds - 1;
    if (next <= 0) {
      _ticker?.cancel();
      _ticker = null;
      emit(state.copyWith(remainingSeconds: 0));
    } else {
      emit(state.copyWith(remainingSeconds: next));
    }
  }

  void _onMessageSent(
    ConsultationMessageSent event,
    Emitter<ConsultationState> emit,
  ) {
    final text = event.text.trim();
    if (text.isEmpty) return;

    // Anti-chetlab o'tish: taqiqlangan kontaktlar bloklanadi.
    if (ContactGuard.isBlocked(text)) {
      emit(state.copyWith(showBlockWarning: true, blockedSnippet: text));
      return;
    }

    final message = ChatMessage(
      id: 'local_${DateTime.now().microsecondsSinceEpoch}',
      text: text,
      isMine: true,
      timeLabel: _nowLabel(),
    );
    emit(state.copyWith(messages: [...state.messages, message]));
  }

  void _onWarningDismissed(
    ConsultationWarningDismissed event,
    Emitter<ConsultationState> emit,
  ) {
    emit(state.copyWith(showBlockWarning: false, clearSnippet: true));
  }

  void _onExtended(
    ConsultationExtended event,
    Emitter<ConsultationState> emit,
  ) {
    emit(
      state.copyWith(
        remainingSeconds: state.remainingSeconds + _extensionSeconds,
      ),
    );
    if (_ticker == null || state.remainingSeconds <= 0) _startTicker();
  }

  String _nowLabel() {
    final now = DateTime.now();
    final h = now.hour.toString().padLeft(2, '0');
    final m = now.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Future<void> close() {
    _ticker?.cancel();
    return super.close();
  }
}
