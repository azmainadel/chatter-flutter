import 'package:flutter/material.dart';

import 'ui/screens/chat_screen.dart';
import 'ui/screens/login_screen.dart';
import 'ui/screens/registration_screen.dart';
import 'ui/screens/welcome_screen.dart';

void main() => runApp(Chatter());

class Chatter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
