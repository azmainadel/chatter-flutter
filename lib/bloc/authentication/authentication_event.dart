import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class Unregistered extends AuthenticationEvent {}

class SignedIn extends AuthenticationEvent {}

class SignedOut extends AuthenticationEvent {}
