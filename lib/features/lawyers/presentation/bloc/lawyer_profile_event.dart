part of 'lawyer_profile_bloc.dart';

sealed class LawyerProfileEvent extends Equatable {
  const LawyerProfileEvent();

  @override
  List<Object?> get props => [];
}

class LawyerReviewsRequested extends LawyerProfileEvent {
  const LawyerReviewsRequested(this.lawyerId);

  final String lawyerId;

  @override
  List<Object?> get props => [lawyerId];
}
