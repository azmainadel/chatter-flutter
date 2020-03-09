import 'package:Chatter/components/rounded_button.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 150.0,
                child: Image.asset('images/logo.png'),
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
                //Do something with the user input.
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
                //Do something with the user input.
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
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
