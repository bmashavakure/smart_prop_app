import 'package:equatable/equatable.dart';


class AuthState extends Equatable{
  AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState{}

class AuthLoading extends AuthState{}


class AuthAuthenticated extends AuthState{
  final String message;

  AuthAuthenticated({required this.message});

  @override
  List<Object?> get props => [message];

}


class AuthUnauthenticated extends AuthState{}


class AuthError extends AuthState{
  final String error;

  AuthError({required this.error});

  @override
  List<Object?> get props => [error];
}

