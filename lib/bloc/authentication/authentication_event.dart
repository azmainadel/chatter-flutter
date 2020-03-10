import 'package:chatter/bloc/authentication/authentication_state.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class Unregistered extends AuthenticationState {}

class SignedIn extends AuthenticationState {}

class SignedOut extends AuthenticationState {}
