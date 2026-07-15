import 'package:equatable/equatable.dart';

import 'document_field.dart';

/// Hujjat shabloni (Da'vo arizasi, Shartnoma, va h.k.).
class DocumentTemplate extends Equatable {
  const DocumentTemplate({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.fields,
  });

  final String id;
  final String title;
  final String subtitle;
  final List<DocumentField> fields;

  @override
  List<Object?> get props => [id];
}
