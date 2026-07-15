part of 'document_generator_bloc.dart';

sealed class DocumentGeneratorEvent extends Equatable {
  const DocumentGeneratorEvent();

  @override
  List<Object?> get props => [];
}

/// Sahifa ochilganda shablonlarni yuklaydi.
class DocumentGeneratorStarted extends DocumentGeneratorEvent {
  const DocumentGeneratorStarted();
}

/// Hujjat turi (shabloni) tanlandi.
class DocumentTemplateSelected extends DocumentGeneratorEvent {
  const DocumentTemplateSelected(this.template);

  final DocumentTemplate template;

  @override
  List<Object?> get props => [template];
}

/// Maydon qiymati o'zgardi.
class DocumentValueChanged extends DocumentGeneratorEvent {
  const DocumentValueChanged(this.key, this.value);

  final String key;
  final String value;

  @override
  List<Object?> get props => [key, value];
}

/// Hujjat turini tanlash bosqichiga qaytish.
class DocumentBackRequested extends DocumentGeneratorEvent {
  const DocumentBackRequested();
}

/// Hujjatni yaratish so'raldi.
class DocumentGenerateRequested extends DocumentGeneratorEvent {
  const DocumentGenerateRequested();
}

/// Sehrgarni boshiga qaytarish.
class DocumentReset extends DocumentGeneratorEvent {
  const DocumentReset();
}
