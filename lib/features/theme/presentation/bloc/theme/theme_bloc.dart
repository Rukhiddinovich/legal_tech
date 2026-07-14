import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:legal_tech/core/errors/failures.dart';
import 'package:legal_tech/core/usecases/usecase.dart';
import 'package:legal_tech/features/theme/domain/entities/theme_entity.dart';
import 'package:legal_tech/features/theme/domain/usecases/get_theme_usecase.dart';
import 'package:legal_tech/features/theme/domain/usecases/set_theme_usecase.dart';
part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final GetThemeUseCase getThemeUseCase;
  final SetThemeUseCase setThemeUseCase;

  ThemeBloc({required this.getThemeUseCase, required this.setThemeUseCase})
    : super(ThemeInitial()) {
    on<GetThemeEvent>(_onGetTheme);
    on<SetThemeEvent>(_onSetTheme);
  }

  Future<void> _onGetTheme(
    GetThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    emit(const ThemeLoading());

    final failureOrTheme = await getThemeUseCase(NoParams());

    failureOrTheme.fold(
      (failure) => emit(ThemeError(_mapFailureToMessage(failure))),
      (theme) => emit(ThemeLoaded(theme)),
    );
  }

  Future<void> _onSetTheme(
    SetThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final currentState = state;
    emit(ThemeLoaded(event.theme));

    final failureOrSuccess = await setThemeUseCase(
      SetThemeParams(theme: event.theme),
    );

    failureOrSuccess.fold((failure) {
      if (currentState is ThemeLoaded) {
        emit(currentState);
      } else {
        emit(ThemeError(_mapFailureToMessage(failure)));
      }
    }, (_) {});
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (CacheFailure):
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
