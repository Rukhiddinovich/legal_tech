import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initial()) {
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<ToggleRememberMe>(_onToggleRememberMe);
    on<SubmitLogin>(_onSubmitLogin);
  }

  void _onTogglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }

  void _onToggleRememberMe(ToggleRememberMe event, Emitter<AuthState> emit) {
    emit(state.copyWith(rememberMe: !state.rememberMe));
  }

  Future<void> _onSubmitLogin(
    SubmitLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));

    // Simulate API request delay
    await Future.delayed(const Duration(milliseconds: 1500));

    emit(state.copyWith(isLoading: false, isSuccess: true));
  }
}
