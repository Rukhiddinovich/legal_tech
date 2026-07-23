import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String id;
  final String title;
  final String category;
  final String content;
  final String areaId;

  const Article({
    required this.id,
    required this.title,
    required this.category,
    required this.content,
    required this.areaId,
  });

  @override
  List<Object?> get props => [id, title, category, content, areaId];
}
