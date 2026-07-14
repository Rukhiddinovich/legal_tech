import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final bool passwordVisible;
  final bool rememberMe;
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  const AuthState({
    required this.passwordVisible,
    required this.rememberMe,
    required this.isLoading,
    this.errorMessage,
    required this.isSuccess,
  });

  factory AuthState.initial() {
    return const AuthState(
      passwordVisible: false,
      rememberMe: false,
      isLoading: false,
      errorMessage: null,
      isSuccess: false,
    );
  }

  AuthState copyWith({
    bool? passwordVisible,
    bool? rememberMe,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return AuthState(
      passwordVisible: passwordVisible ?? this.passwordVisible,
      rememberMe: rememberMe ?? this.rememberMe,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
    passwordVisible,
    rememberMe,
    isLoading,
    errorMessage,
    isSuccess,
  ];
}
