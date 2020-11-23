import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/navigation/NavigationPage.dart';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:accurate_doctor/widget/signup/formheader_title.dart';
import 'package:accurate_doctor/widget/signup/gender_modal.dart';
import 'package:accurate_doctor/widget/signup/socialmedial_options.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../modal/user_detail.dart';
import 'package:flutter/material.dart';
import '../../widget/common/radio_button.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class SignUpForm extends StatefulWidget {
  final bool isDoctor;
  SignUpForm({Key key, this.isDoctor}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _form = GlobalKey<FormState>();
  final _dateOfBirth = FocusNode();
  final _gender = FocusNode();
  final _email = FocusNode();
  final _mobileNo = FocusNode();
  final _password = FocusNode();
  final _lastName = FocusNode();

  bool isPrivacyPolicyFlagEnabled = false;
  TextEditingController selectedDate = TextEditingController();
  TextEditingController selectedGender = TextEditingController();
  final double _fieldGap = 12;
  AjaxCall http;
  bool isSubmitting = false;
  bool showPassword = true;

  double pageHeight = 0;
  UserDetail userDetail;

  @override
  void initState() {
    _dateOfBirth.addListener(() {
      FocusScope.of(context).unfocus();
      if (_dateOfBirth.hasFocus) this.getDatePicker();
    });
    http = AjaxCall.getInstance;
    userDetail = UserDetail.instance;
    userDetail.Gender = "Male";
    super.initState();
  }

  @override
  void dispose() {
    _dateOfBirth.dispose();
    _gender.dispose();
    _email.dispose();
    _mobileNo.dispose();
    _password.dispose();
    _lastName.dispose();
    super.dispose();
  }

  void privacyPolicyStatus(bool privacyFlag) {
    isPrivacyPolicyFlagEnabled = privacyFlag;
  }

  void showPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Registration status',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w700,
              color: Theme.of(context).accentColor,
              fontStyle: FontStyle.normal,
              fontSize: 20,
            ),
          ),
          content: Wrap(
            children: [
              Container(
                child: Text(
                  'Welcome to Accurate Doctor',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              Container(
                child: Text('Registration completed successfully.'),
              ),
            ],
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(NavigationPage.SignIn);
              },
              child: Text(
                'Ok',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onFormSubmitted() {
    String firstName = "";
    String lastName = "";
    FocusScope.of(context).unfocus();
    final state = _form.currentState.validate();
    _form.currentState.save();
    if (state) {
      List<String> completeName = userDetail.FullName.split(" ");
      if (completeName.length > 1) {
        firstName = completeName.elementAt(0);
        lastName = completeName.skip(1).join(" ");
      } else {
        firstName = userDetail.FullName;
      }
      setState(() {
        isSubmitting = true;
      });

      this.http.post("Customerservice/CustomerRegistration", {
        "strDOB": DateFormat('yyyy-MM-dd').format(userDetail.DateOfBirth),
        "strEmail": userDetail.Email,
        "strFirstName": userDetail.FullName,
        "strGender": userDetail.Gender,
        "strLastName": userDetail.FullName,
        "strMobileNo": userDetail.MobileNo.toString(),
        "strPassword": userDetail.Password,
        "strSourceOne": "",
        "intLocationId": "0",
        "intCityId": "0"
      }).then((value) {
        print(value);
        if (value.toString().isNotEmpty) {
          var result = json.decode(value);
          if (result["code"] == "200") {
            showPopup();
          } else {
            setState(() {
              this.isSubmitting = false;
            });

            final snackBar = SnackBar(
              content: Text(result["Status"]),
              action: SnackBarAction(
                label: '',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            );

            // Find the Scaffold in the widget tree and use
            // it to show a SnackBar.
            Scaffold.of(context).showSnackBar(snackBar);
          }
        } else {
          Fluttertoast.showToast(msg: 'Fail to register. Contact admin.');
        }
      });
    } else {
      Fluttertoast.showToast(msg: 'Entered value is invalid.');
    }
  }

  void handlerSelectedGender(int gender) {
    if (gender == 1) {
      selectedGender.text = 'Male';
    } else if (gender == 2) {
      selectedGender.text = 'Female';
    } else {
      selectedGender.text = 'Other';
    }
    userDetail.Gender = selectedGender.text;
  }

  void getGenderPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Choose Gender',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w700,
              color: Theme.of(context).accentColor,
              fontStyle: FontStyle.normal,
              fontSize: 20,
            ),
          ),
          content: GenderModal(handlerSelectedGender),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Ok',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> getDatePicker() async {
    final selectedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 100 * 365)),
      lastDate: DateTime.now(),
    );

    if (selectedDateTime != null) {
      userDetail.DateOfBirth = selectedDateTime;
      selectedDate.text = DateFormat.yMd().format(selectedDateTime);
    } else {
      userDetail.DateOfBirth = DateTime.now();
      selectedDate.text = DateFormat.yMd().format(userDetail.DateOfBirth);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _form,
        child: Column(
          children: [
            FormHeaderTitle(),
            Container(
              margin: EdgeInsets.only(top: _fieldGap),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'First name',
                  isDense: true,
                  prefixIcon: Icon(
                    Icons.person,
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
                keyboardType: TextInputType.text,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(this._lastName);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'First name is madatory field';
                  }
                  return null;
                },
                onSaved: (value) {
                  userDetail.FullName = value;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: _fieldGap),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Last name',
                  isDense: true,
                  prefixIcon: Icon(
                    Icons.person,
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
                keyboardType: TextInputType.text,
                focusNode: _lastName,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(this._dateOfBirth);
                },
                validator: (value) {
                  return null;
                },
                onSaved: (value) {
                  if (value.isNotEmpty) userDetail.FullName += " " + value;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: _fieldGap),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Date of birth',
                  isDense: true,
                  prefixIcon: Icon(
                    Icons.calendar_today,
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
                controller: selectedDate,
                keyboardType: null,
                focusNode: _dateOfBirth,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(this._gender);
                },
                validator: (value) {
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: _fieldGap),
              child: TextFormField(
                onTap: getGenderPicker,
                decoration: InputDecoration(
                  labelText: 'Gender',
                  isDense: true,
                  prefixIcon: Icon(
                    Icons.all_inclusive,
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
                readOnly: true,
                controller: selectedGender,
                textAlign: TextAlign.start,
                focusNode: _gender,
                keyboardType: TextInputType.text,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(this._email);
                },
                validator: (value) {
                  return null;
                },
                onSaved: (value) {
                  userDetail.Gender = "Male";
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: _fieldGap),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  isDense: true,
                  prefixIcon: Icon(
                    Icons.mobile_screen_share,
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
                keyboardType: TextInputType.text,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(this._mobileNo);
                },
                validator: (value) {
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value);
                  if (!emailValid) {
                    return "Invalid email id.";
                  }
                  return null;
                },
                onSaved: (value) {
                  userDetail.Email = value;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: _fieldGap),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mobile number',
                  isDense: true,
                  prefixIcon: Icon(
                    Icons.mobile_screen_share,
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
                focusNode: _mobileNo,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(this._password);
                },
                validator: (value) {
                  if (value.trim().length != 10) {
                    return "Invalid mobile no.";
                  }
                  return null;
                },
                onSaved: (value) {
                  userDetail.MobileNo = value;
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
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    child: Icon(
                      Icons.remove_red_eye,
                      color: Theme.of(context).accentColor,
                    ),
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
                obscureText: showPassword,
                focusNode: _password,
                keyboardType: TextInputType.visiblePassword,
                onFieldSubmitted: (_) {},
                validator: (value) {
                  return null;
                },
                onSaved: (value) {
                  userDetail.Password = value;
                },
              ),
            ),
            widget.isDoctor
                ? Container(
                    margin: EdgeInsets.only(top: _fieldGap),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Speciality',
                        isDense: true,
                        prefixIcon: Icon(
                          Icons.local_hospital,
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
                      focusNode: _password,
                      keyboardType: TextInputType.visiblePassword,
                      onFieldSubmitted: (_) {},
                      validator: (value) {
                        return null;
                      },
                      onSaved: (value) {
                        userDetail.Password = value;
                      },
                    ),
                  )
                : Container(),
            widget.isDoctor
                ? Container(
                    margin: EdgeInsets.only(top: _fieldGap),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Medical Registration Number',
                        isDense: true,
                        prefixIcon: Icon(
                          Icons.healing,
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
                      focusNode: _password,
                      keyboardType: TextInputType.visiblePassword,
                      onFieldSubmitted: (_) {},
                      validator: (value) {
                        return null;
                      },
                      onSaved: (value) {
                        userDetail.Password = value;
                      },
                    ),
                  )
                : Container(),
            widget.isDoctor
                ? Container(
                    margin: EdgeInsets.only(top: _fieldGap),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Referral Code',
                        isDense: true,
                        prefixIcon: Icon(
                          Icons.perm_camera_mic,
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
                      focusNode: _password,
                      keyboardType: TextInputType.visiblePassword,
                      onFieldSubmitted: (_) {},
                      validator: (value) {
                        return null;
                      },
                      onSaved: (value) {
                        userDetail.Password = value;
                      },
                    ),
                  )
                : Container(),
            SizedBox(
              height: 10,
            ),
            RadioButton(
              title: 'I agree with Privacy Policy',
              privacyPolicyStatus: privacyPolicyStatus,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                child: isSubmitting
                    ? SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      )
                    : const Text(
                        'Sign Up',
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
                onPressed: _onFormSubmitted,
              ),
            ),
            SocialMedialOptions(),
          ],
        ),
      ),
    );
  }
}
