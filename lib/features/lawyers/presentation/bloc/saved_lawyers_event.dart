part of 'saved_lawyers_bloc.dart';

sealed class SavedLawyersEvent extends Equatable {
  const SavedLawyersEvent();

  @override
  List<Object> get props => [];
}

class LoadSavedLawyers extends SavedLawyersEvent {}

class ToggleSavedLawyer extends SavedLawyersEvent {
  const ToggleSavedLawyer(this.lawyer);

  final Lawyer lawyer;

  @override
  List<Object> get props => [lawyer];
}
