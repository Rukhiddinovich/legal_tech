import '../../domain/entities/lawyer.dart';

/// [Lawyer] entity'ining data-qatlam modeli (JSON ↔ obyekt).
///
/// Kelajakda API ulanганда aynan shu model serializatsiya uchun ishlatiladi.
class LawyerModel extends Lawyer {
  const LawyerModel({
    required super.id,
    required super.fullName,
    required super.specialization,
    required super.experienceYears,
    required super.rating,
    required super.reviewsCount,
    required super.consultationsCount,
    required super.pricePerSession,
    required super.sessionMinutes,
    required super.isOnline,
    required super.tags,
    required super.directions,
    required super.about,
    required super.areaIds,
  });

  factory LawyerModel.fromJson(Map<String, dynamic> json) {
    return LawyerModel(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      specialization: json['specialization'] as String,
      experienceYears: json['experience_years'] as int,
      rating: (json['rating'] as num).toDouble(),
      reviewsCount: json['reviews_count'] as int,
      consultationsCount: json['consultations_count'] as int,
      pricePerSession: json['price_per_session'] as int,
      sessionMinutes: json['session_minutes'] as int,
      isOnline: json['is_online'] as bool,
      tags: List<String>.from(json['tags'] as List),
      directions: List<String>.from(json['directions'] as List),
      about: json['about'] as String,
      areaIds: List<String>.from(json['area_ids'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'specialization': specialization,
      'experience_years': experienceYears,
      'rating': rating,
      'reviews_count': reviewsCount,
      'consultations_count': consultationsCount,
      'price_per_session': pricePerSession,
      'session_minutes': sessionMinutes,
      'is_online': isOnline,
      'tags': tags,
      'directions': directions,
      'about': about,
      'area_ids': areaIds,
    };
  }
}
