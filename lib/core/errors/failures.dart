import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure({required super.message});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message});
}

class LocationFailure extends Failure {
  const LocationFailure({required super.message});
}

class PermissionFailure extends Failure {
  const PermissionFailure({required super.message});
}
