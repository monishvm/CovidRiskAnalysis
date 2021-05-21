import 'package:covid/api/api.dart';
import 'package:covid/components/questions/questions_list.dart';
import 'package:covid/components/questions/tab_bar/question_option.dart';
import 'package:covid/components/questions/tab_bar/tab_label.dart';
import 'package:covid/screens/sign_in.dart';
import 'package:covid/shared_preferences/shared_preferences.dart' as sp;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionScreen extends StatefulWidget {
  static const String id = 'question_screen';
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: Questions.ques.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              :Text('Log out'),
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
                          child:  Text('Yes'),
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
        child: Column(
          children: [
            Container(
              height: 32,
              color: Colors.grey.shade800,
              child: TabBar(
                controller: tabController,
                tabs: List.generate(Questions.ques.length,
                    (index) => CustomTab(label: '${index + 1}')),

                //selected
                indicator: BoxDecoration(color: Colors.black),
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: TextStyle(fontSize: 30),

                //un selected
                unselectedLabelColor: Colors.black,
                unselectedLabelStyle: TextStyle(fontSize: 20),
              ),
            ),
            // tab view - questions
            Expanded(
              child: Container(
                child: TabBarView(
                  controller: tabController,
                  children: List.generate(
                    Questions.ques.length,
                    (index) => QuesOptionBuilder(
                      indexofQues: index,
                      question: Questions.ques[index]['ques'],
                      options: Questions.ques[index]['op'],
                      tabController: tabController,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
