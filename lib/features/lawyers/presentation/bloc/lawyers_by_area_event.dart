part of 'lawyers_by_area_bloc.dart';

sealed class LawyersByAreaEvent extends Equatable {
  const LawyersByAreaEvent();

  @override
  List<Object?> get props => [];
}

class LawyersByAreaStarted extends LawyersByAreaEvent {
  const LawyersByAreaStarted(this.areaId);

  final String areaId;

  @override
  List<Object?> get props => [areaId];
}
