import 'package:equatable/equatable.dart';


class AuthEvent extends Equatable{
  const AuthEvent();

  @override
  List<Object?> get props => [];
}


class AuthRegisterEvent extends AuthEvent{
  final String name;
  final String email;
  final String password;

  AuthRegisterEvent({required this.name, required this.email, required this.password});

  @override
  List<Object?> get props => [name, email, password];
}

class AuthLoginEvent extends AuthEvent{
  final String email;
  final String password;

  AuthLoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class AuthLogoutEvent extends  AuthEvent{}


