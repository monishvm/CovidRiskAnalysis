import 'dart:io';
import 'package:covid/api/api.dart';
import 'package:covid/components/signin_signup/rounded_button.dart';
import 'package:covid/components/signin_signup/span_text.dart';
import 'package:covid/components/signin_signup/text_field.dart';
import 'package:covid/components/signin_signup/title_builder.dart';
import 'package:covid/screens/personal_details.dart';
import 'package:covid/screens/sign_up.dart';
import 'package:covid/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  static const String id = 'sign_in';

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String username;
  String password;
  bool usernotFound = false;
  bool incorrectPassword = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    logoutCurrentUser().then((value) => setState(() {}));
  }

  Future<void> logoutCurrentUser() async {
    SharedPreferences ins = await SharedPref.getUsername();
    String crntUser = ins.getString(user);
    if (crntUser != null) {
      await API.logout(crntUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTitleBuilder(text: 'Login'),
                  SizedBox(height: 20),
                  usernotFound
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 35),
                              child: Text(
                                '* Enter a correct username',
                                style: GoogleFonts.aBeeZee(
                                    color: Colors.red.shade300),
                              ),
                            )
                          ],
                        )
                      : Container(),
                  SizedBox(height: 5),
                  CustomTextField(
                    hint: 'Username',
                    onChange: (value) {
                      username = value;
                    },
                    inVisible: false,
                  ),
                  SizedBox(height: 10),
                  incorrectPassword
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 35),
                              child: Text(
                                '* Incorrect password',
                                style: GoogleFonts.aBeeZee(
                                    color: Colors.red.shade300),
                              ),
                            )
                          ],
                        )
                      : Container(),
                  SizedBox(height: 5),
                  CustomTextField(
                    hint: 'Password',
                    onChange: (value) {
                      password = value;
                    },
                    inVisible: true,
                  ),
                  SizedBox(height: 30),
                  !isLoading
                      ? CustomRoundedButton(
                          text: 'Login',
                          ontap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            setState(() {
                              isLoading = true;
                            });
                            String result;
                            if (username != null && password != null) {
                              result = await API.signin(username, password);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Enter some thing')));
                            }
                            setState(() {
                              isLoading = false;
                            });
                            if (result == "signin success") {
                              await SharedPref.addUserToSP(username);
                              Navigator.pushNamed(
                                  context, PersonalDetailScreen.id);
                            } else if (result == "Incorrect password") {
                              setState(() {
                                incorrectPassword = true;
                                usernotFound = false;
                              });
                            } else if (result == "No user found on this name") {
                              setState(() {
                                usernotFound = true;
                                incorrectPassword = false;
                              });
                            }
                          },
                        )
                      : CircularProgressIndicator(),
                  SizedBox(height: 20),
                  CustomSpanText(
                    text: 'Need an Account ? ',
                    spanText: 'Signup',
                    ontap: () {
                      Navigator.pushNamed(context, SignUp.id);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
