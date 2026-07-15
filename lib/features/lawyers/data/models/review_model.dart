import '../../domain/entities/review.dart';

/// [Review] entity'ining data-qatlam modeli.
class ReviewModel extends Review {
  const ReviewModel({
    required super.id,
    required super.authorName,
    required super.rating,
    required super.text,
    required super.verified,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as String,
      authorName: json['author_name'] as String,
      rating: json['rating'] as int,
      text: json['text'] as String,
      verified: json['verified'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author_name': authorName,
      'rating': rating,
      'text': text,
      'verified': verified,
    };
  }
}
