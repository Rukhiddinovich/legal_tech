part of 'lawyer_profile_bloc.dart';

class LawyerProfileState extends Equatable {
  const LawyerProfileState({
    this.status = ViewStatus.initial,
    this.reviews = const [],
    this.error,
  });

  final ViewStatus status;
  final List<Review> reviews;
  final String? error;

  LawyerProfileState copyWith({
    ViewStatus? status,
    List<Review>? reviews,
    String? error,
  }) {
    return LawyerProfileState(
      status: status ?? this.status,
      reviews: reviews ?? this.reviews,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, reviews, error];
}
