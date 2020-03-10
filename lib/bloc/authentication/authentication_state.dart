import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Unregistered extends AuthenticationState {}

class SignedIn extends AuthenticationState {
  final String userName;

  const SignedIn(this.userName);

  @override
  List<Object> get props => [userName];

  @override
  String toString() => '$userName signed in';
}

class SignedOut extends AuthenticationState {}
