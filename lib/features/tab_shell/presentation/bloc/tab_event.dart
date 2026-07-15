part of 'tab_bloc.dart';

sealed class TabEvent extends Equatable {
  const TabEvent();

  @override
  List<Object?> get props => [];
}

/// Tab tanlandi.
class TabSelected extends TabEvent {
  const TabSelected(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}
