import 'dart:io';
import 'package:covid/api/api.dart';
import 'package:covid/components/personal_details/age.dart';
import 'package:covid/components/personal_details/height_weight.dart';
import 'package:covid/components/personal_details/male_female.dart';
import 'package:covid/components/signin_signup/rounded_button.dart';
import 'package:covid/screens/questions_screen.dart';
import 'package:covid/screens/sign_in.dart';
import 'package:covid/shared_preferences/shared_preferences.dart' as sp;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalDetailScreen extends StatefulWidget {
  static const String id = 'personal_details';

  @override
  _PersonalDetailScreenState createState() => _PersonalDetailScreenState();
}

class _PersonalDetailScreenState extends State<PersonalDetailScreen> {
  int selectedGender;
  double height;
  double weight;
  int age;
  bool isLoading = false;

  Future<bool> onBack() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: isLoading ? CircularProgressIndicator() : Text('Sure ?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                exit(0);
              },
              child: Text('Exit App'),
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                SharedPreferences instance = await sp.SharedPref.getUsername();
                String currentUsername = instance.getString(sp.user);
                bool res = await API.logout(currentUsername);
                if (res) {
                  Navigator.pushNamed(context, SignIn.id);
                }
                setState(() {
                  isLoading = false;
                });
              },
              child: Text('Logout'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                return false;
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBack,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: Icon(Icons.person, size: 30),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: isLoading
                            ? CircularProgressIndicator()
                            : Text('Log out'),
                        actions: [
                          ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              SharedPreferences instance =
                                  await sp.SharedPref.getUsername();
                              String currentUsername =
                                  instance.getString(sp.user);
                              bool res = await API.logout(currentUsername);
                              if (res) {
                                Navigator.pushNamed(context, SignIn.id);
                              }
                              setState(() {
                                isLoading = false;
                              });
                            },
                            child: Text('Yes'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                MaleFemale(
                  selected: selectedGender,
                  onPressMale: () {
                    setState(() {
                      selectedGender = 0;
                    });
                  },
                  onPressFemale: () {
                    setState(() {
                      selectedGender = 1;
                    });
                  },
                ),
                SizedBox(height: 20),
                Age(
                  onchange: (value) {
                    age = value;
                  },
                ),
                SizedBox(height: 70),
                HeightWeight(
                  onchange: (value) {
                    height = double.parse(value);
                  },
                  hintText: 'Height',
                  extention: 'cm',
                ),
                SizedBox(height: 50),
                HeightWeight(
                  onchange: (value) {
                    weight = double.parse(value);
                  },
                  hintText: 'Weight',
                  extention: 'kg',
                ),
                SizedBox(height: 30),
                CustomRoundedButton(
                  ontap: () {
                    calculateBmi();
                  },
                  text: 'Calculate',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calculateBmi() {
    if (height != null && weight != null) {
      double _height = height / 100;
      print(_height);
      double bmi = weight / (_height * _height);
      String result;
      if (bmi > 30) {
        result = 'Obesity';
      } else if (bmi > 25) {
        result = 'Overweight';
      } else if (bmi > 18.5) {
        result = 'Normal';
      } else {
        result = 'UnderWeight';
      }
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              ElevatedButton(
                onPressed: () {
                  bmi = 0;
                  Navigator.pushNamed(context, QuestionScreen.id);
                },
                child: Text('Ok'),
              ),
            ],
            content: Container(
              height: 50,
              child: Column(
                children: [
                  Text("your result : " + bmi.toStringAsFixed(2)),
                  Text("your status : " + result),
                ],
              ),
            ),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ok'),
              ),
            ],
            content: Text('Enter height and weight '),
          );
        },
      );
    }
  }
}
