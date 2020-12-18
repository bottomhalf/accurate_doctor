import 'package:accurate_doctor/modal/Configuration.dart';

import '../../widget/signup/gender_modal.dart';
import '../../modal/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoctorProfileManage extends StatefulWidget {
  @override
  _DoctorProfileManageState createState() => _DoctorProfileManageState();
}

class _DoctorProfileManageState extends State<DoctorProfileManage> {
  final _form = GlobalKey<FormState>();
  final _dateOfBirth = FocusNode();
  final _gender = FocusNode();
  final _email = FocusNode();
  final _mobileNo = FocusNode();
  final _didNo = FocusNode();
  final _extNo = FocusNode();
  bool isPrivacyPolicyFlagEnabled = false;
  TextEditingController selectedDate = TextEditingController();
  TextEditingController selectedGender = TextEditingController();
  final double _fieldGap = 12;

  double pageHeight = 0;
  UserDetail userDetail;

  @override
  void initState() {
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
    _extNo.dispose();
    _didNo.dispose();
    super.dispose();
  }

  void privacyPolicyStatus(bool privacyFlag) {
    isPrivacyPolicyFlagEnabled = privacyFlag;
  }

  void _onFormSubmitted() {
    _form.currentState.validate();
    _form.currentState.save();

    print(userDetail.FullName);
    print(userDetail.DateOfBirth);
    print(userDetail.Email);
    print(userDetail.Password);
    print(userDetail.MobileNo);
    //Navigator.of(context).pushNamed(NavigationPage.OTPVarification);
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
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 1000),
      ),
    );

    userDetail.DateOfBirth = selectedDateTime;
    selectedDate.text = DateFormat.yMd().format(selectedDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 20,
            ),
            height: 120,
            child: FittedBox(
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://cdn4.vectorstock.com/i/1000x1000/07/33/tiny-cute-cartoon-patient-man-character-broken-vector-25530733.jpg'),
                radius: 40,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: _fieldGap),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'First Name',
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
                FocusScope.of(context).requestFocus(this._dateOfBirth);
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Full name is madatory field';
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
                labelText: 'Last Name',
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
                FocusScope.of(context).requestFocus(this._dateOfBirth);
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Full name is madatory field';
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
                FocusScope.of(context).requestFocus(this._didNo);
              },
              validator: (value) {
                return null;
              },
              onSaved: (value) {
                userDetail.MobileNo = value;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: Configuration.fieldGap * 2,
            ),
            child: Text(
              'DID No.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: _fieldGap),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'DID No.#',
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              textAlign: TextAlign.start,
              focusNode: _didNo,
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
          Container(
            padding: EdgeInsets.only(
              top: Configuration.fieldGap * 2,
            ),
            child: Text(
              'EXT No.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: _fieldGap),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'EXT No.#',
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              textAlign: TextAlign.start,
              focusNode: _didNo,
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
          SizedBox(
            height: Configuration.fieldGap * 2,
          ),
          Row(
            children: [
              MaterialButton(
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                child: const Text(
                  'Save',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40),
              ),
              SizedBox(
                width: 10,
              ),
              OutlineButton(
                borderSide: BorderSide(color: Colors.blueGrey),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
