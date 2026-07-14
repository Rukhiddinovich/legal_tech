part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class GetThemeEvent extends ThemeEvent {}

class SetThemeEvent extends ThemeEvent {
  final ThemeEntity theme;

  const SetThemeEvent(this.theme);

  @override
  List<Object> get props => [theme];
}
