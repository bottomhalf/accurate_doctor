import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/navigation/NavigationPage.dart';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';

class GeneratePassword extends StatefulWidget {
  @override
  _GeneratePasswordState createState() => _GeneratePasswordState();
}

class _GeneratePasswordState extends State<GeneratePassword> {
  final _form = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _oldPassword = TextEditingController();
  final double _fieldGap = 12;
  bool privacyPolicyFlag = false;
  double boxSize = 50;
  final _reenterPassword = FocusNode();
  final _enterPassword = FocusNode();
  final _email = FocusNode();
  double pageHeight = Configuration.height - 10;
  void _sendOTP() {}
  int userId = 0;
  bool isSubmitted = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _oldPassword.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      userId = ModalRoute.of(context).settings?.arguments as int;
      print('userid: $userId');
      setState(() {
        userId = userId;
      });
    });
  }

  void submitChangePassword() {
    final state = _form.currentState.validate();
    _form.currentState.save();

    if (state) {
      FocusScope.of(context).unfocus();
      setState(() {
        isSubmitted = true;
      });
      AjaxCall http = AjaxCall.getInstance;
      http.post("PatientProfile/ChangePassword", {
        "intUserId": userId,
        "strPassword": _oldPassword.text,
        "strNewPassword": _confirmpasswordController.text
      }).then((value) {
        var result = json.decode(value);
        if (result['code'] != "0") {
          Fluttertoast.showToast(msg: 'Password changed successfully');
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.of(context).pushReplacementNamed(NavigationPage.SignIn);
        } else {
          Fluttertoast.showToast(msg: result['Status']);
          setState(() {
            isSubmitted = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            alignment: Alignment.center,
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
                  'Create New Password',
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
                  'Please enter the OTP that has been sent to your email ID',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: _fieldGap),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Old Password',
                      isDense: true,
                      prefixIcon: Icon(
                        Icons.vpn_key,
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
                    focusNode: _email,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    controller: _oldPassword,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_enterPassword);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Old password is mandatory';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ),
                SizedBox(
                  height: _fieldGap,
                ),
                Container(
                  margin: EdgeInsets.only(top: _fieldGap),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter new password',
                      isDense: true,
                      prefixIcon: Icon(
                        Icons.security,
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
                    controller: _passwordController,
                    obscureText: true,
                    focusNode: _enterPassword,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_reenterPassword);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Email is mandatory';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ),
                SizedBox(
                  height: _fieldGap,
                ),
                Container(
                  margin: EdgeInsets.only(top: _fieldGap),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Re-enter new password',
                      isDense: true,
                      prefixIcon: Icon(
                        Icons.contact_mail,
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
                    obscureText: true,
                    focusNode: _reenterPassword,
                    controller: _confirmpasswordController,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (_) {},
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Email is mandatory';
                      } else if (value != _passwordController.text) {
                        return 'Password miss match';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ),
                SizedBox(
                  height: _fieldGap,
                ),
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                  child: isSubmitted
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
                          'Reset Password',
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
                  onPressed: submitChangePassword,
                ),
                SizedBox(
                  height: _fieldGap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
