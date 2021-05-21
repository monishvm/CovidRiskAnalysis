import 'package:covid/api/api.dart';
import 'package:covid/components/signin_signup/rounded_button.dart';
import 'package:covid/components/signin_signup/span_text.dart';
import 'package:covid/components/signin_signup/text_field.dart';
import 'package:covid/components/signin_signup/title_builder.dart';
import 'package:covid/screens/personal_details.dart';
import 'package:covid/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  static const String id = 'sign_up';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool usernameAlreadyExist = false;
  bool isLoading = false;
  String username;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTitleBuilder(text: 'Signup'),
                SizedBox(height: 20),
                usernameAlreadyExist
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 35),
                            child: Text(
                              '* User already exists',
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
                        text: 'Signup',
                        ontap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            isLoading = true;
                          });
                          String res;
                          if (username != null && password != null) {
                            res = await API.signup(username, password);
                            print(res);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Enter some thing')));
                          }
                          setState(() {
                            isLoading = false;
                          });
                          if (res == 'signup success') {
                            await SharedPref.addUserToSP(username);
                            Navigator.pushNamed(
                                context, PersonalDetailScreen.id);
                          } else if (res == 'User already exists') {
                            setState(() {
                              usernameAlreadyExist = true;
                            });
                          } else if (res == 'Unable to signup.') {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Try again later')));
                          }
                        },
                      )
                    : CircularProgressIndicator(),
                SizedBox(height: 20),
                CustomSpanText(
                  text: 'Already have an Account ? ',
                  spanText: 'Login',
                  ontap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
