import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/navigation/NavigationPage.dart';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import '../widget/common/inputformfield.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _form = GlobalKey<FormState>();
  final email = TextEditingController();
  final double _fieldGap = 12;
  bool privacyPolicyFlag = false;
  bool isSubmited = false;
  double pageHeight = 0;
  double boxSize = 50;

  void verifyUserEmail() {
    final state = _form.currentState.validate();
    _form.currentState.save();

    if (state) {
      AjaxCall http = AjaxCall.getInstance;
      FocusScope.of(context).unfocus();
      setState(() {
        isSubmited = !isSubmited;
      });
      Future.delayed(Duration(seconds: 1)).then((value) {
        http.post("Login/PatientForgotPassword", {
          "strEmail": email.text.trim(),
          "mailto": email.text.trim()
        }).then((value) {
          var userDetail = json.decode(value);
          setState(() {
            isSubmited = !isSubmited;
          });
          if (userDetail['intUserId'] > 0) {
            Configuration.showPopup(context, 'Forgot Password Status', [
              'A reset email has been sent to your registered mail id',
            ]).then((value) => Navigator.of(context).pop());
          } else {
            Configuration.showPopup(context, 'Forgot Password Status', [
              'Fail to verify your email id',
              'Please contact to admin'
            ]).then((value) => print('working'));
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    pageHeight = MediaQuery.of(context).size.height - 10;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
          bottom: 10,
        ),
        child: Form(
          key: _form,
          child: Container(
            height: pageHeight,
            width: double.infinity,
            child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Accurate Doctor',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                Text(
                  '(Logo required)',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 5 * _fieldGap,
                ),
                Text(
                  'Forgot Password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: _fieldGap,
                ),
                Text(
                  'Reset your password, you will receive an OTP to your registered email ID',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: _fieldGap),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter your email ID',
                      isDense: true,
                      prefixIcon: Icon(
                        Icons.email,
                        color: Theme.of(context).accentColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    textAlign: TextAlign.start,
                    controller: email,
                    keyboardType: null,
                    focusNode: null,
                    validator: (value) {
                      if (value == "" || !Configuration.isValidEmail(value)) {
                        return "Invalid email";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: _fieldGap,
                ),
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                  child: isSubmited
                      ? Center(
                          child: Container(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        )
                      : const Text(
                          'Reset',
                        ),
                  padding: EdgeInsets.only(
                    top: 15,
                    bottom: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: BorderSide(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  onPressed: () {
                    this.verifyUserEmail();
                  },
                ),
                SizedBox(
                  height: _fieldGap,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Want to go back again?',
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
