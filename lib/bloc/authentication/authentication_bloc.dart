import 'package:chatter/bloc/authentication/authentication_event.dart';
import 'package:chatter/bloc/authentication/authentication_state.dart';
import 'package:chatter/data/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  UserRepository _userRepository;

  AuthenticationBloc({@required UserRepository userRepository}) {
    if (userRepository != null) {
      _userRepository = userRepository;
    }
  }

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is Unregistered) {
      yield* _mapUnregisteredToState();
    } else if (event is SignedIn) {
      yield* _mapSignedInToState();
    } else if (event is SignedOut) {
      yield* _mapSignedOutToState();
    }
  }

  Stream<AuthenticationState> _mapUnregisteredToState() async* {
    try {
      final isSignedIn = await _userRepository.isSignedIn();

      if (isSignedIn) {
        final email = await _userRepository.getLoggedInUserEmail();
        yield Authenticated(email);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapSignedInToState() async* {
    yield Authenticated(await _userRepository.getLoggedInUserEmail());
  }

  Stream<AuthenticationState> _mapSignedOutToState() async* {
    yield Unauthenticated();
    _userRepository.signOut();
  }
}
