import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/repositories/theme_repository.dart';

part 'theme_event.dart';

/// Ilova mavzusini boshqaruvchi Bloc.
///
/// Holat sifatida [ThemeMode] ni chiqaradi. Repozitoriyga bog'lanadi,
/// aniq saqlash mexanizmiga emas (SOLID — DIP).
class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  ThemeBloc(this._repository) : super(_repository.getThemeMode()) {
    on<ThemeToggled>(_onToggled);
    on<ThemeModeChanged>(_onModeChanged);
  }

  final ThemeRepository _repository;

  bool get isDark => state == ThemeMode.dark;

  Future<void> _onToggled(ThemeToggled event, Emitter<ThemeMode> emit) async {
    final next = isDark ? ThemeMode.light : ThemeMode.dark;
    await _repository.saveThemeMode(next);
    emit(next);
  }

  Future<void> _onModeChanged(
    ThemeModeChanged event,
    Emitter<ThemeMode> emit,
  ) async {
    await _repository.saveThemeMode(event.mode);
    emit(event.mode);
  }
}
