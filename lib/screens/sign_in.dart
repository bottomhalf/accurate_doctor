import 'package:accurate_doctor/modal/personal_detail.dart';
import 'package:accurate_doctor/provider/localDb.dart';
import 'package:accurate_doctor/widget/myprofile/personal_detail.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';

import '../widget/common/transparent_loader.dart';
import '../modal/user_detail.dart';
import '../services/ajax_call.dart';
import '../modal/Configuration.dart';
import 'dart:io';
import '../navigation/NavigationPage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_icons/flutter_icons.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isFormSubmitted = false;
  final _form = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _password = FocusNode();
  final double _fieldGap = 12;
  bool privacyPolicyFlag = false;
  double pageHeight = 0;
  AjaxCall http;
  LocalDb db;
  bool isViewPassword = false;

  void togglePolicy(bool policyFlag) {
    privacyPolicyFlag = policyFlag;
  }

  @override
  void initState() {
    setState(() {
      isFormSubmitted = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      http = AjaxCall.getInstance;
      db = LocalDb.internal();
      db.initDb().then((value) {
        if (value) {
          print('Checking');
          PersonalDetailModal.userExists().then((value) {
            if (value) {
              print('User exists');
              Navigator.of(context)
                  .pushReplacementNamed(NavigationPage.Dashboard);
            } else {
              print('User not exists');
              setState(() {
                isFormSubmitted = false;
              });
            }
          });
        }
      });
    });
  }

  void showInvalidMesssage(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 25,
            color: Theme.of(context).accentColor,
          ),
        ),
        content: Text(message),
        actions: [
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  void _signInUser() {
    UserDetail userDetail = UserDetail.instance;
    FocusScope.of(context).unfocus();
    final status = _form.currentState.validate();
    _form.currentState.save();
    if (status) {
      setState(() {
        isFormSubmitted = !isFormSubmitted;
      });
      this.http.post("Customerservice/CustomerLogingIn", {
        "email": email.text.trim(),
        "password": password.text.trim()
      }).then((value) {
        userDetail = UserDetail.fromJson(json.decode(value));

        userDetail.isDoctor = true;

        if (userDetail.statusCode != 200) {
          setState(() {
            isFormSubmitted = !isFormSubmitted;
          });
          this.showInvalidMesssage(
              'Login error', 'Incorrect username or password.');
          return;
        } else {
          PersonalDetailModal personalDetail;
          print('Getting Profile detail...');
          http
              .get("PatientProfile/GetPatientProfileInfo/${userDetail.UserId}")
              .then((value) {
            if (value != null) {
              var data = json.decode(value);
              personalDetail = PersonalDetailModal.fromJson(data);

              String values = ''' values(
            ${userDetail.UserId},
            '${personalDetail.strFirstName}',
            '${personalDetail.strLastName}',
            '${personalDetail.strGender}',
            '${personalDetail.strDOB}',
            '${personalDetail.strMobileNo}',
            '${personalDetail.strEmail}',
            '${personalDetail.strExperience}',
            '${personalDetail.strImagePath}',
            '${personalDetail.strUserName}',
            ${personalDetail.intRoleId},
            '${personalDetail.strTitle}',
            '${personalDetail.strMiddleName}',
            '${personalDetail.strAddress}',
            '${personalDetail.strZipCode}',
            '${userDetail.customerId}',
            ${userDetail.isDoctor ? 1 : 0}) ''';

              personalDetail
                  .insertValue(values, userDetail.UserId)
                  .then((value) {
                if (value) {
                  Future.delayed(const Duration(seconds: 0), () {
                    PersonalDetailModal.userExists().then((value) {
                      if (value) {
                        print('User exists');
                        Navigator.of(context)
                            .pushReplacementNamed(NavigationPage.Dashboard);
                      } else {
                        print('User not exists');
                        setState(() {
                          isFormSubmitted = false;
                        });
                      }
                    });
                  });
                } else {
                  Fluttertoast.showToast(
                      msg: 'Server error. Please contact admin.');
                }
              });
            }
          });
        }
      });
    }
  }

  void InitConfiguration() {
    Configuration.width = MediaQuery.of(context).size.width;
    Configuration.height = MediaQuery.of(context).size.height;
    Configuration.isAndroid = Platform.isAndroid;
    pageHeight = Configuration.height - 10;
  }

  @override
  Widget build(BuildContext context) {
    InitConfiguration();
    return Stack(
      children: [
        Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(
              top: 40,
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
                    Container(
                      margin: EdgeInsets.only(bottom: 12),
                      child: Center(
                        child: Image.asset(
                          "assets/img/logo.png",
                          width: Configuration.width * .5,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Sign In',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Please sign in to enter into app',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: _fieldGap),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          isDense: true,
                          prefixIcon: Icon(
                            Icons.mail,
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
                        controller: email,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(this._password);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Email is madatory field';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          email.text = value;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: _fieldGap),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          isDense: true,
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Theme.of(context).accentColor,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                this.isViewPassword = !this.isViewPassword;
                              });
                            },
                            icon: Icon(FontAwesome.eye_slash),
                            color: Theme.of(context).accentColor,
                            iconSize: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                        ),
                        controller: password,
                        obscureText: !isViewPassword,
                        textAlign: TextAlign.start,
                        focusNode: _password,
                        keyboardType: TextInputType.visiblePassword,
                        onFieldSubmitted: (_) {},
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password is madatory field';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          password.text = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: _fieldGap,
                    ),
                    RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Colors.white,
                      child: const Text(
                        'Sign In',
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
                      onPressed: _signInUser,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        children: [
                          FlatButton(
                            child: Text(
                              'Forgot password ?',
                              style: TextStyle(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(NavigationPage.ForgotPassword);
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                  color: Theme.of(context).dividerColor,
                                ),
                              ),
                              MaterialButton(
                                minWidth: 0,
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      NavigationPage.SignUp);
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          SizedBox(
                            height: _fieldGap,
                          ),
                          Center(
                            child: Text(
                              'Enter via social networks',
                              style: TextStyle(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: _fieldGap,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: RaisedButton(
                                  child: Container(
                                    height: 42,
                                    child: Icon(AntDesign.googleplus),
                                  ),
                                  color: Colors.redAccent,
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: RaisedButton(
                                  child: Container(
                                    height: 42,
                                    child: Icon(FontAwesome.facebook_f),
                                  ),
                                  color: Configuration.ColorFromHex('#3898ab'),
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                      color:
                                          Configuration.ColorFromHex('#3898ab'),
                                    ),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        isFormSubmitted ? TransparentLoader() : Container(),
      ],
    );
  }
}
