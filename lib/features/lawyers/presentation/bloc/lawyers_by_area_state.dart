part of 'lawyers_by_area_bloc.dart';

class LawyersByAreaState extends Equatable {
  const LawyersByAreaState({
    this.status = ViewStatus.initial,
    this.lawyers = const [],
    this.error,
  });

  final ViewStatus status;
  final List<Lawyer> lawyers;
  final String? error;

  LawyersByAreaState copyWith({
    ViewStatus? status,
    List<Lawyer>? lawyers,
    String? error,
  }) {
    return LawyersByAreaState(
      status: status ?? this.status,
      lawyers: lawyers ?? this.lawyers,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, lawyers, error];
}
