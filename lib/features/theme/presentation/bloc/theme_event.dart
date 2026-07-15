part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

/// Mavzuni yorug'/tungi o'rtasida almashtiradi.
class ThemeToggled extends ThemeEvent {
  const ThemeToggled();
}

/// Mavzuni aniq bir [ThemeMode] ga o'rnatadi.
class ThemeModeChanged extends ThemeEvent {
  const ThemeModeChanged(this.mode);

  final ThemeMode mode;

  @override
  List<Object?> get props => [mode];
}
