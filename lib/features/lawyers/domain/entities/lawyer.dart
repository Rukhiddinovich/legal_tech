import 'package:equatable/equatable.dart';

/// Advokat/huquqshunos domen obyekti.
///
/// Katalog kartasi ham, to'liq profil ham shu entity'dan foydalanadi.
class Lawyer extends Equatable {
  const Lawyer({
    required this.id,
    required this.fullName,
    required this.specialization,
    required this.experienceYears,
    required this.rating,
    required this.reviewsCount,
    required this.consultationsCount,
    required this.pricePerSession,
    required this.sessionMinutes,
    required this.isOnline,
    required this.tags,
    required this.directions,
    required this.about,
    required this.areaIds,
  });

  final String id;
  final String fullName;

  /// Qisqa tavsif, masalan "Meros va oila huquqi · 12 yil".
  final String specialization;
  final int experienceYears;
  final double rating;
  final int reviewsCount;
  final int consultationsCount;

  /// Bir seans narxi (so'm).
  final int pricePerSession;

  /// Seans davomiyligi (daqiqa).
  final int sessionMinutes;
  final bool isOnline;

  /// Kartadagi kichik teglar (masalan "Meros", "Oila").
  final List<String> tags;

  /// Profildagi to'liq yo'nalishlar ro'yxati.
  final List<String> directions;
  final String about;

  /// Ushbu advokat tegishli bo'lgan huquq sohalari id-lari.
  final List<String> areaIds;

  @override
  List<Object?> get props => [id];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'specialization': specialization,
      'experienceYears': experienceYears,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'consultationsCount': consultationsCount,
      'pricePerSession': pricePerSession,
      'sessionMinutes': sessionMinutes,
      'isOnline': isOnline,
      'tags': tags,
      'directions': directions,
      'about': about,
      'areaIds': areaIds,
    };
  }

  factory Lawyer.fromMap(Map<String, dynamic> map) {
    return Lawyer(
      id: map['id'] ?? '',
      fullName: map['fullName'] ?? '',
      specialization: map['specialization'] ?? '',
      experienceYears: map['experienceYears']?.toInt() ?? 0,
      rating: map['rating']?.toDouble() ?? 0.0,
      reviewsCount: map['reviewsCount']?.toInt() ?? 0,
      consultationsCount: map['consultationsCount']?.toInt() ?? 0,
      pricePerSession: map['pricePerSession']?.toInt() ?? 0,
      sessionMinutes: map['sessionMinutes']?.toInt() ?? 0,
      isOnline: map['isOnline'] ?? false,
      tags: List<String>.from(map['tags'] ?? []),
      directions: List<String>.from(map['directions'] ?? []),
      about: map['about'] ?? '',
      areaIds: List<String>.from(map['areaIds'] ?? []),
    );
  }
}
