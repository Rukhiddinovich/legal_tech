import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/view_status.dart';
import '../../domain/entities/document_template.dart';
import '../../domain/repositories/document_repository.dart';

part 'document_generator_event.dart';
part 'document_generator_state.dart';

/// Hujjat yaratish qadamlari.
enum DocumentStep { type, data, done }

/// Hujjat generatori sehrgar (wizard) logikasi.
class DocumentGeneratorBloc
    extends Bloc<DocumentGeneratorEvent, DocumentGeneratorState> {
  DocumentGeneratorBloc(this._repository)
      : super(const DocumentGeneratorState()) {
    on<DocumentGeneratorStarted>(_onStarted);
    on<DocumentTemplateSelected>(_onTemplateSelected);
    on<DocumentValueChanged>(_onValueChanged);
    on<DocumentBackRequested>(_onBackRequested);
    on<DocumentGenerateRequested>(_onGenerateRequested);
    on<DocumentReset>(_onReset);
  }

  final DocumentRepository _repository;

  Future<void> _onStarted(
    DocumentGeneratorStarted event,
    Emitter<DocumentGeneratorState> emit,
  ) async {
    emit(state.copyWith(status: ViewStatus.loading));
    final result = await _repository.getTemplates();
    result.fold(
      (failure) => emit(
        state.copyWith(status: ViewStatus.failure, error: failure.message),
      ),
      (templates) =>
          emit(state.copyWith(status: ViewStatus.success, templates: templates)),
    );
  }

  void _onTemplateSelected(
    DocumentTemplateSelected event,
    Emitter<DocumentGeneratorState> emit,
  ) {
    emit(
      state.copyWith(
        selectedTemplate: event.template,
        step: DocumentStep.data,
        values: const {},
      ),
    );
  }

  void _onValueChanged(
    DocumentValueChanged event,
    Emitter<DocumentGeneratorState> emit,
  ) {
    final next = Map<String, String>.from(state.values)..[event.key] = event.value;
    emit(state.copyWith(values: next));
  }

  void _onBackRequested(
    DocumentBackRequested event,
    Emitter<DocumentGeneratorState> emit,
  ) {
    emit(state.copyWith(step: DocumentStep.type));
  }

  Future<void> _onGenerateRequested(
    DocumentGenerateRequested event,
    Emitter<DocumentGeneratorState> emit,
  ) async {
    if (!state.canGenerate || state.isGenerating) return;
    emit(state.copyWith(isGenerating: true));
    await Future<void>.delayed(const Duration(milliseconds: 1400));
    emit(state.copyWith(isGenerating: false, step: DocumentStep.done));
  }

  void _onReset(
    DocumentReset event,
    Emitter<DocumentGeneratorState> emit,
  ) {
    emit(state.copyWith(step: DocumentStep.type, values: const {}));
  }
}
