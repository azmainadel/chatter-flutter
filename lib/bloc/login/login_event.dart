import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends LoginEvent {}

class PasswordChanged extends LoginEvent {}

class Submitted extends LoginEvent {}

class LoginWithCredentialsPressed extends LoginEvent {}
