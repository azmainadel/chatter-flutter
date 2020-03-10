import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Unregistered extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final String userName;

  const Authenticated(this.userName);

  @override
  List<Object> get props => [userName];

  @override
  String toString() => '$userName signed in';
}

class Unauthenticated extends AuthenticationState {}
