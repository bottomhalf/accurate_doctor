import 'dart:convert';

import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/modal/relative_detail.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/ajax_call.dart';
import '../../widget/signup/gender_modal.dart';
import '../../modal/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyFamily extends StatefulWidget {
  @override
  _MyFamilyState createState() => _MyFamilyState();
}

class _MyFamilyState extends State<MyFamily> {
  final _form = GlobalKey<FormState>();
  final _dateOfBirth = FocusNode();
  final _gender = FocusNode();
  final _email = FocusNode();
  final _mobileNo = FocusNode();
  final _password = FocusNode();
  final _lastName = FocusNode();
  final _relation = FocusNode();

  bool isPrivacyPolicyFlagEnabled = false;
  TextEditingController selectedDate = TextEditingController();
  TextEditingController selectedGender = TextEditingController();
  final double _fieldGap = 12;
  RelativeDetail relativeDetail;
  double pageHeight = 0;
  UserDetail userDetail;
  bool isSubmitting = false;
  bool isLoading = false;

  @override
  void initState() {
    userDetail = UserDetail.instance;
    setState(() {
      isLoading = true;
    });
    super.initState();
    AjaxCall http = AjaxCall.getInstance;
    http
        .get("Common/GetDependentDetailsById/${userDetail.UserId}")
        .then((value) {
      if (value != null) {
        List<dynamic> response = json.decode(value);
        if (response.length > 0) {
          relativeDetail = RelativeDetail.fromJson(response[0]);
          print('IsUpdate: ${relativeDetail.isUpdate}');
          if (relativeDetail.strgender.isNotEmpty) {
            selectedGender.text =
                relativeDetail.strgender == "0" ? "Male" : "Female";
          }
          if (relativeDetail.strdob != null) {
            try {
              selectedDate.text = DateFormat.yMMMd()
                  .format(DateTime.parse(relativeDetail.strdob));
              print('Date: ${selectedDate.text}');
            } catch (e) {
              print('Unable to cast date of birth');
            }
          }
        } else
          relativeDetail = RelativeDetail();
        setState(() {
          this.relativeDetail = relativeDetail;
          isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _dateOfBirth.dispose();
    _gender.dispose();
    _email.dispose();
    _mobileNo.dispose();
    _password.dispose();
    super.dispose();
  }

  void privacyPolicyStatus(bool privacyFlag) {
    isPrivacyPolicyFlagEnabled = privacyFlag;
  }

  void _onFormSubmitted() {
    final state = _form.currentState.validate();
    _form.currentState.save();

    FocusScope.of(context).unfocus();
    if (state) {
      setState(() {
        isSubmitting = true;
      });

      try {
        Future.delayed(Duration(milliseconds: 500)).then((value) {
          AjaxCall http = AjaxCall.getInstance;
          if (relativeDetail.isUpdate) {
            print(
                'Updating record: ${relativeDetail.strGCMID}, UserId: ${relativeDetail.intCustid}');
            http.post("Registration/PatientRegistration", {
              "intUserId": relativeDetail.intCustid,
              "strFirstName": relativeDetail.strname,
              "strLastName": relativeDetail.strlname,
              "strGender": relativeDetail.strgender,
              "intModifiedBy": DateFormat('dd/MM/yyyy').format(DateTime.now()),
              "strEmail": null, //relativeDetail.stremail,
              "strDOB": relativeDetail.strdob,
              "intRoleId": 3,
              "CH_Unique_ID": "",
              "intRelation": 25,
              "Globalid": relativeDetail.strGCMID,
              "strPassword": "idigitalplatform",
              "strSourceOne": "M"
            }).then((value) {
              if (value != null) {
                var response = json.decode(value);
                if (response['code'] == null || response['code'] == "0") {
                  Fluttertoast.showToast(msg: response['strMessage']);
                } else {
                  Fluttertoast.showToast(msg: 'Updated successfully');
                }
              }
              setState(() {
                isSubmitting = false;
              });
            });
          } else {
            http.post("Registration/PatientRegistration", {
              "strFirstName": relativeDetail.strname,
              "strLastName": relativeDetail.strlname,
              "strGender": relativeDetail.strgender,
              "strDOB": relativeDetail.strdob,
              "intRoleId": 3,
              "strPassword": "healthygx",
              "strSourceOne": "M",
              "strEmail": relativeDetail.stremail,
              "HealthyGx_Unique_ID": relativeDetail.strGCMID,
              "Globalid": "",
              "intRelation": 25
            }).then((value) {
              if (value != null) {
                var response = json.decode(value);
                if (response['strMessage'] != null &&
                    response['strMessage'].toString().toLowerCase() ==
                        "successfully") {
                  Fluttertoast.showToast(
                      msg: 'Member added/updated successfully');
                } else {
                  Fluttertoast.showToast(msg: response['Status']);
                }
              } else {
                Fluttertoast.showToast(msg: 'Server error. Contact admin.');
              }
              setState(() {
                isSubmitting = false;
              });
            });
          }
        });
      } catch (e) {
        setState(() {
          isSubmitting = false;
        });
      }
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
    relativeDetail.strgender = selectedGender.text;
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
      selectedDate.text = DateFormat('dd/MM/yyyy').format(selectedDateTime);
      relativeDetail.strdob = selectedDate.text;
    }
  }

  int getRelation(String relation) {
    int value = 0;
    if (relation != null) {
      switch (relation.toLowerCase()) {
        case "wife":
          value = 29;
          break;
        case "husband":
          value = 31;
          break;
        case "son":
          value = 27;
          break;
        case "daughter":
          value = 28;
          break;
        case "brother":
          value = 25;
          break;
        case "sister":
          value = 26;
          break;
        case "mother":
          value = 35;
          break;
        case "father":
          value = 37;
          break;
        case "other-dependent":
          value = 30;
          break;
        default:
          value = 0;
          break;
      }
    }
    return value;
  }

  String getDob() {
    print('Dob ${this.relativeDetail.strdob}');
    if (this.relativeDetail.strdob != null) {
      try {
        selectedDate.text = DateFormat('dd/MM/yyyy')
            .format(DateTime.parse(this.relativeDetail.strdob));
      } catch (e) {
        print('Dob cast error');
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          )
        : Container(
            child: Form(
              key: _form,
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    height: 120,
                    child: FittedBox(
                      child: Configuration.getImage(null),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: _fieldGap),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Frist name',
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
                      initialValue: relativeDetail.strname,
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
                        relativeDetail.strlname = value;
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
                      initialValue: relativeDetail.strlname,
                      focusNode: _lastName,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(this._relation);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Last name is madatory field';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        relativeDetail.strlname = value;
                      },
                    ),
                  ),
                  Container(
                    height: 48,
                    margin: EdgeInsets.only(top: _fieldGap),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'Relation',
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
                      focusNode: _relation,
                      value: getRelation(this.relativeDetail.strrelation),
                      onChanged: (value) {
                        print(value);
                      },
                      items: [
                        DropdownMenuItem(
                          child: Text('Relation'),
                          value: 0,
                        ),
                        DropdownMenuItem(
                          child: Text('Wife'),
                          value: 29,
                        ),
                        DropdownMenuItem(
                          child: Text('Husband'),
                          value: 31,
                        ),
                        DropdownMenuItem(
                          child: Text('Son'),
                          value: 27,
                        ),
                        DropdownMenuItem(
                          child: Text('Daughter'),
                          value: 28,
                        ),
                        DropdownMenuItem(
                          child: Text('Brother'),
                          value: 25,
                        ),
                        DropdownMenuItem(
                          child: Text('sister'),
                          value: 26,
                        ),
                        DropdownMenuItem(
                          child: Text('Mother'),
                          value: 35,
                        ),
                        DropdownMenuItem(
                          child: Text('Father'),
                          value: 37,
                        ),
                        DropdownMenuItem(
                          child: Text('Other-Dependent'),
                          value: 30,
                        ),
                      ],
                      validator: (value) {
                        return null;
                      },
                      onSaved: (value) {
                        relativeDetail.relation = "Brother";
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: _fieldGap),
                    child: TextFormField(
                      onTap: getDatePicker,
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
                      initialValue: getDob(),
                      controller: selectedDate,
                      keyboardType: null,
                      readOnly: true,
                      focusNode: _dateOfBirth,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(this._gender);
                      },
                      validator: (value) {
                        return null;
                      },
                      onSaved: (value) {},
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
                      //initialValue: relativeDetail.strgender,
                      textAlign: TextAlign.start,
                      focusNode: _gender,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(this._email);
                      },
                      validator: (value) {
                        if (value.isEmpty) return "Gender is mandatory";
                        return null;
                      },
                      onSaved: (value) {
                        if (value.isNotEmpty) relativeDetail.strgender = value;
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
                      initialValue: relativeDetail.stremail,
                      focusNode: _email,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(this._mobileNo);
                      },
                      validator: (value) {
                        if (value.isEmpty) return "Email is mandatory";
                        return null;
                      },
                      onSaved: (value) {
                        if (value.isNotEmpty) relativeDetail.stremail = value;
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
                      //initialValue: relativeDetail.mobile,
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(this._password);
                      },
                      validator: (value) {
                        //if (value.isEmpty) return "Mobile is mandatory";
                        return null;
                      },
                      onSaved: (value) {
                        if (value.isNotEmpty) relativeDetail.mobile = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: MaterialButton(
                      color: Theme.of(context).accentColor,
                      textColor: Colors.white,
                      child: isSubmitting
                          ? Center(
                              child: Container(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                            )
                          : const Text(
                              'Add Family Member',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                      onPressed: () {
                        _onFormSubmitted();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
