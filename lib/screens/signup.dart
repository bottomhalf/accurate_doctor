import 'package:accurate_doctor/modal/Configuration.dart';

import '../widget/signup/formheader_title.dart';
import '../widget/signup/socialmedial_options.dart';

import '../widget/signup/signup_form.dart';
import 'package:flutter/widgets.dart';
import '../navigation/NavigationPage.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool privacyPolicyFlag = false;
  final double _fieldGap = 12;
  double pageHeight = 0;
  void togglePolicy(bool policyFlag) {
    privacyPolicyFlag = policyFlag;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
          top: 20,
        ),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                height: Configuration.height * .1,
                child: TabBar(
                  tabs: [
                    Tab(
                      text: "Patient",
                      icon: Icon(Icons.perm_identity),
                    ),
                    Tab(
                      text: "Doctor",
                      icon: Icon(Icons.supervisor_account),
                    ),
                  ],
                  labelColor: Theme.of(context).accentColor,
                  labelStyle: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 10,
                  ),
                  height: Configuration.height * .9,
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: TabBarView(
                    children: [
                      Container(
                        height: Configuration.height * .9,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            SignUpForm(
                              isDoctor: false,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: Configuration.height * .9,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            SignUpForm(
                              isDoctor: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
