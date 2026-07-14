import 'package:equatable/equatable.dart';

enum AppThemeMode { light, dark, system }

class ThemeEntity extends Equatable {
  final AppThemeMode themeMode;

  const ThemeEntity({required this.themeMode});

  @override
  List<Object?> get props => [themeMode];

  ThemeEntity copyWith({AppThemeMode? themeMode}) {
    return ThemeEntity(themeMode: themeMode ?? this.themeMode);
  }
}
