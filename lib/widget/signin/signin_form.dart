import 'package:flutter/material.dart';
import '../../navigation/NavigationPage.dart';

class SignInForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _password = FocusNode();
  final double _fieldGap = 12;
  bool privacyPolicyFlag = false;
  double pageHeight = 0;

  void togglePolicy(bool policyFlag) {
    privacyPolicyFlag = policyFlag;
  }

  void _signInUser() {
    _form.currentState.validate();
    _form.currentState.save();

    print(email.text);
    print(password.text);
    //Navigator.of(context).pushReplacementNamed(NavigationPage.Dashboard);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
