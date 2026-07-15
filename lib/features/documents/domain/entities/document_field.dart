import 'package:equatable/equatable.dart';

/// Hujjat generatori formasidagi bitta maydon ta'rifi.
enum DocumentFieldType { text, number, multiline }

class DocumentField extends Equatable {
  const DocumentField({
    required this.key,
    required this.label,
    required this.hint,
    this.type = DocumentFieldType.text,
    this.required = true,
    this.halfWidth = false,
  });

  final String key;
  final String label;
  final String hint;
  final DocumentFieldType type;
  final bool required;

  /// True bo'lsa — bitta qatorda ikki maydon yonma-yon (dizayndagidek).
  final bool halfWidth;

  @override
  List<Object?> get props => [key];
}
