import 'package:chatter/bloc/authentication/authentication_bloc.dart';
import 'package:chatter/bloc/authentication/authentication_event.dart';
import 'package:chatter/bloc/login/login_bloc.dart';
import 'package:chatter/bloc/login/login_event.dart';
import 'package:chatter/bloc/login/login_state.dart';
import 'package:chatter/data/repositories/user_repository.dart';
import 'package:chatter/ui/components/rounded_button.dart';
import 'package:chatter/ui/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginForm extends StatefulWidget {
  UserRepository _userRepository;

  LoginForm({@required userRepository}) {
    if (userRepository != null) {
      _userRepository = userRepository;
    }
  }

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;
  bool showSpinner = false;

  String email;
  String password;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isCredentialsValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();

    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

/*  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 150.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  color: Colors.black54,
                ),
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextInputFieldDecoration.copyWith(
                    hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                style: TextStyle(
                  color: Colors.black54,
                ),
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextInputFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  buttonColor: Colors.lightBlueAccent,
                  buttonText: 'Log In',
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });

                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );

                      if (user != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }

                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.isFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Login Failure'), Icon(Icons.error)],
                  ),
                  backgroundColor: Colors.red,
                ),
              );
          }
          if (state.isSubmitting) {
            setState(() {
              showSpinner = true;
            });
          }
          if (state.isSuccess) {
            setState(() {
              showSpinner = false;
            });

            BlocProvider.of<AuthenticationBloc>(context).add(SignedIn());
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 150.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextInputFieldDecoration.copyWith(
                      hintText: 'Enter your email'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextInputFieldDecoration.copyWith(
                      hintText: 'Enter your password'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  buttonColor: Colors.lightBlueAccent,
                  buttonText: 'Log In',
                  onPressed: () {
                    setState(() {
                      showSpinner = true;
                    });

                    isLoginButtonEnabled(state) ? _onFormSubmitted : null;
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
