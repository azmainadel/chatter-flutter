import 'package:chatter/bloc/login/login_event.dart';
import 'package:chatter/bloc/login/login_state.dart';
import 'package:chatter/data/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;

  LoginBloc({@required UserRepository userRepository}) {
    if (userRepository != null) {
      _userRepository = userRepository;
    }
  }

  @override
  LoginState get initialState {}

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) {}
}
