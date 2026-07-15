part of 'document_generator_bloc.dart';

class DocumentGeneratorState extends Equatable {
  const DocumentGeneratorState({
    this.status = ViewStatus.initial,
    this.templates = const [],
    this.selectedTemplate,
    this.step = DocumentStep.type,
    this.values = const {},
    this.isGenerating = false,
    this.error,
  });

  final ViewStatus status;
  final List<DocumentTemplate> templates;
  final DocumentTemplate? selectedTemplate;
  final DocumentStep step;
  final Map<String, String> values;
  final bool isGenerating;
  final String? error;

  /// Barcha majburiy maydonlar to'ldirilganmi?
  bool get canGenerate {
    final template = selectedTemplate;
    if (template == null) return false;
    return template.fields
        .where((f) => f.required)
        .every((f) => (values[f.key] ?? '').trim().isNotEmpty);
  }

  DocumentGeneratorState copyWith({
    ViewStatus? status,
    List<DocumentTemplate>? templates,
    DocumentTemplate? selectedTemplate,
    DocumentStep? step,
    Map<String, String>? values,
    bool? isGenerating,
    String? error,
  }) {
    return DocumentGeneratorState(
      status: status ?? this.status,
      templates: templates ?? this.templates,
      selectedTemplate: selectedTemplate ?? this.selectedTemplate,
      step: step ?? this.step,
      values: values ?? this.values,
      isGenerating: isGenerating ?? this.isGenerating,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        templates,
        selectedTemplate,
        step,
        values,
        isGenerating,
        error,
      ];
}
