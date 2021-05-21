import 'package:covid/screens/personal_details.dart';
import 'package:covid/screens/questions_screen.dart';
import 'package:covid/screens/sign_in.dart';
import 'package:covid/screens/sign_up.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignIn(),
      initialRoute: SignIn.id,
      routes: {
        SignIn.id: (context) => SignIn(),
        SignUp.id: (context) => SignUp(),
        QuestionScreen.id: (context) => QuestionScreen(),
        PersonalDetailScreen.id: (context) => PersonalDetailScreen(),
      },
    );
  }
}
