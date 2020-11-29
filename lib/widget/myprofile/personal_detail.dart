import 'dart:io';

import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/modal/personal_detail.dart';
import 'package:accurate_doctor/navigation/Constants.dart';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../widget/signup/gender_modal.dart';
import '../../modal/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class PersonalDetail extends StatefulWidget {
  dynamic personalDetail;
  PersonalDetail({this.personalDetail});
  @override
  _PersonalDetailState createState() => _PersonalDetailState();
}

class _PersonalDetailState extends State<PersonalDetail> {
  final _form = GlobalKey<FormState>();
  final _dateOfBirth = FocusNode();
  final _gender = FocusNode();
  final _email = FocusNode();
  final _mobileNo = FocusNode();
  final _address1 = FocusNode();
  final _pincode = FocusNode();
  final _state = FocusNode();
  final _country = FocusNode();
  final _city = FocusNode();

  bool isPrivacyPolicyFlagEnabled = false;
  TextEditingController selectedDate = TextEditingController();
  TextEditingController selectedGender = TextEditingController();
  final double _fieldGap = 12;
  bool isSubmiting = false;
  AjaxCall http;
  double pageHeight = 0;
  UserDetail userDetail = UserDetail.instance;
  List<dynamic> states = [];
  List<dynamic> cities = [];
  bool isLoading = true;
  PersonalDetailModal personalDetail;
  File _filePath;
  bool isPictureAval = false;

  @override
  void dispose() {
    _dateOfBirth.dispose();
    _gender.dispose();
    _email.dispose();
    _mobileNo.dispose();
    _address1.dispose();
    _pincode.dispose();
    _state.dispose();
    _country.dispose();
    _city.dispose();
    super.dispose();
  }

  void privacyPolicyStatus(bool privacyFlag) {
    isPrivacyPolicyFlagEnabled = privacyFlag;
  }

  void BindDropdown(PersonalDetailModal data) {
    http = AjaxCall.getInstance;
    http.get("Common/GetCity/1").then((value) {
      if (value != null) {
        cities = json.decode(value);
        if (cities == null) cities = List<dynamic>();
        cities.add({
          "intStateId": -1,
          "intCityId": -1,
          "strCityName": "City",
        });

        setState(() {
          cities = cities;
          states = states == null ? [] : states;
        });
      }
    });

    http.get("Common/GetState/1").then((value) {
      if (value != null) {
        states = json.decode(value);
        if (states == null) states = List<dynamic>();
        states.add({
          "intCountryId": -1,
          "intStateId": -1,
          "strStateName": "State",
        });

        setState(() {
          this.personalDetail = data;
          states = states;
          this.isLoading = false;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.personalDetail != null) {
      personalDetail = PersonalDetailModal.fromJson(widget.personalDetail);
    } else
      personalDetail = PersonalDetailModal();
    this.BindDropdown(personalDetail);
  }

  String _getGenderInitialValue() {
    this.convertGenderType(personalDetail.strGender);
    return null;
  }

  void _onFormSubmitted() {
    final state = _form.currentState.validate();
    _form.currentState.save();

    if (state) {
      setState(() {
        isSubmiting = true;
      });

      try {
        http = AjaxCall.getInstance;
        http.post("Registration/PatientRegistration", {
          "intUserId": userDetail.UserId,
          "strTitle": "Mr",
          "strFirstName": this.personalDetail.strFirstName,
          "strLastName": this.personalDetail.strLastName,
          "strMiddleName": "",
          "strGender": this.personalDetail.strGender,
          "intLocationId": 0,
          "strAddress": null,
          "strZipCode": null,
          "intCityId": 0,
          "strMobileNo": this.personalDetail.strMobileNo,
          "strPhoneNo": null,
          "strpassword": null,
          "intBloodGroup": null,
          "intMaritalStatus": 0,
          "intIdProofTypeId": 0,
          "strIdProofPath": null,
          "strImagePath":
              "511_1200px-Tango_style_insert-signature_icon.svg.png",
          "intEmploymentTypeId": 0,
          "intEducation": 0,
          "strLanguages": null,
          "intModifiedBy": null,
          "strDOB": DateFormat('MM/dd/yyyy')
              .format(DateTime.parse(this.personalDetail.strDOB)),
          "intRoleId": 3,
          "strEmail": this.personalDetail.strEmail,
          "boolNewDoc": false
        }).then((value) {
          if (value != null) {
            var response = json.decode(value);
            if (response['strMessage']
                .toString()
                .toLowerCase()
                .contains('successfully')) {
              Fluttertoast.showToast(msg: 'Profile updated successfully');

              http.post("PatientProfile/InsertupdateCustomerAddress", {
                "AddressID": this.personalDetail.intAddrId,
                "strAdress": this.personalDetail.strAddress,
                "PateintID": userDetail.UserId,
                "intLocationID": 3685,
                "intCityD": this.personalDetail.intCityId,
                "intstateID": this.personalDetail.intStateId,
                "intZipcode": this.personalDetail.strZipCode,
                "strAdresstype": "Home Address"
              }).then((addrvalue) {
                if (addrvalue != null) {
                  var addrResponse = json.decode(addrvalue);
                } else {
                  Fluttertoast.showToast(msg: "Unable to update address");
                }
              });
            } else {
              Fluttertoast.showToast(msg: 'Fail to update');
            }

            setState(() {
              isSubmiting = false;
            });
          }
        });
      } catch (ex) {
        setState(() {
          isSubmiting = false;
        });
        print('Error on form submission: ${ex}');
      }
    } else {
      Fluttertoast.showToast(msg: 'Please check mandatory fields');
    }
  }

  void handlerSelectedGender(MappedGender gender) {
    if (gender == MappedGender.Male) {
      selectedGender.text = 'Male';
      this.personalDetail.strGender = MappedGender.Male.index.toString();
    } else if (gender == MappedGender.Female) {
      selectedGender.text = 'Female';
      this.personalDetail.strGender = MappedGender.Female.index.toString();
    } else {
      selectedGender.text = 'Other';
      this.personalDetail.strGender = MappedGender.Other.index.toString();
    }
  }

  void convertGenderType(String gender) {
    if (gender == 'M' || gender == '2') {
      selectedGender.text = 'Male';
      this.personalDetail.strGender = MappedGender.Male.index.toString();
    } else if (gender == 'F' || gender == '1') {
      selectedGender.text = 'Female';
      this.personalDetail.strGender = MappedGender.Female.index.toString();
    } else {
      selectedGender.text = 'Other';
      this.personalDetail.strGender = MappedGender.Other.index.toString();
    }
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

    userDetail.DateOfBirth = selectedDateTime;
    selectedDate.text = DateFormat.yMd().format(selectedDateTime);
  }

  String getInitDob() {
    String dateValue = null;
    if (this.personalDetail.strDOB != null) {
      try {
        selectedDate.text = DateFormat('dd/MM/yyyy')
            .format(DateTime.parse(this.personalDetail.strDOB));
        dateValue = selectedDate.text;
      } catch (e) {
        print('Unable to cast DOB');
      }
    }

    return null;
  }

  String getvalue(var value) {
    String data = null;
    if (value != null) data = value;
    return data;
  }

  int getDropdownValue(int input, bool isState) {
    int value = -1;
    if (input != null) {
      try {
        if (isState) {
          dynamic result = this
              .states
              .firstWhere((element) => element['intStateId'] == input);
          value = result['intStateId'];
        } else {
          dynamic result = this
              .cities
              .firstWhere((element) => element['intCityId'] == input);
          value = result['intCityId'];
        }
      } catch (e) {
        value = -1;
      }
    }
    return value;
  }

  Future<void> _getPicture() async {
    try {
      ImagePicker _picker = ImagePicker();
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      String base64Data;
      pickedFile.readAsBytes().then((value) {
        List<int> imageBytes = value;
        base64Data = base64Encode(imageBytes);
        print('Image: $base64Data');
      });

      setState(() {
        isPictureAval = true;
        _filePath = File(pickedFile.path);
      });
    } catch (e) {
      print(e);
    }
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
                  InkWell(
                    onTap: () {
                      _getPicture();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      height: 120,
                      child: FittedBox(
                        child: this.isPictureAval
                            ? Image.file(
                                _filePath,
                              )
                            : Configuration.getImage(
                                this.personalDetail.strImagePath),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: _fieldGap),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Full name',
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
                      initialValue: this.personalDetail.strFirstName,
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
                        if (value != null)
                          this.personalDetail.strFirstName = value.trim();
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
                      initialValue: getInitDob(),
                      controller: selectedDate,
                      keyboardType: null,
                      readOnly: true,
                      focusNode: _dateOfBirth,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(this._gender);
                      },
                      validator: (value) {
                        if (value.isEmpty) return 'DOB is mandatory';
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
                      initialValue: _getGenderInitialValue(),
                      controller: selectedGender,
                      textAlign: TextAlign.start,
                      focusNode: _gender,
                      keyboardType: null,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(this._email);
                      },
                      validator: (value) {
                        if (value.isEmpty) return 'Gender is mandatory';
                        return null;
                      },
                      onSaved: (value) {},
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
                      initialValue: this.personalDetail.strEmail,
                      focusNode: _email,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(this._mobileNo);
                      },
                      validator: (value) {
                        if (value.isEmpty) return 'Email is mandatory';
                        return null;
                      },
                      onSaved: (value) {
                        if (value.isNotEmpty)
                          this.personalDetail.strEmail = value.trim();
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
                      initialValue: this.personalDetail.strMobileNo,
                      focusNode: _mobileNo,
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(this._address1);
                      },
                      validator: (value) {
                        if (value.isEmpty) return 'Mobile is mandatory';
                        return null;
                      },
                      onSaved: (value) {
                        if (value != null)
                          this.personalDetail.strMobileNo = value.trim();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MaterialButton(
                        color: Theme.of(context).accentColor,
                        textColor: Colors.white,
                        child: const Text(
                          'Home',
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
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              size: 16,
                              color: Theme.of(context).accentColor,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              'New Address',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: _fieldGap),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Address',
                        isDense: true,
                        prefixIcon: Icon(
                          Icons.location_on,
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
                      initialValue: this.personalDetail.strAddress,
                      focusNode: _address1,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(this._pincode);
                      },
                      validator: (value) {
                        return null;
                      },
                      onSaved: (value) {
                        if (value.isNotEmpty)
                          this.personalDetail.strAddress = value.trim();
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: _fieldGap),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Pincode',
                        isDense: true,
                        prefixIcon: Icon(
                          Icons.location_on,
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
                      initialValue: this.personalDetail.strZipCode,
                      focusNode: _pincode,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(this._city);
                      },
                      validator: (value) {
                        return null;
                      },
                      onSaved: (value) {
                        if (value.isNotEmpty)
                          this.personalDetail.strZipCode = value.trim();
                      },
                    ),
                  ),
                  Container(
                    height: 48,
                    margin: EdgeInsets.only(top: _fieldGap),
                    child: DropdownButtonFormField<dynamic>(
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Icon(
                          Icons.location_on,
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
                      focusNode: _city,
                      value:
                          getDropdownValue(this.personalDetail.intCityId, true),
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      onChanged: (value) {
                        //this.personalDetail.strCityName = value;
                      },
                      items: this
                          .cities
                          .map((e) => DropdownMenuItem(
                                child: Text(
                                  e['strCityName'],
                                  style: TextStyle(
                                    color: e['intCityId'] == -1
                                        ? Theme.of(context).dividerColor
                                        : Colors.black,
                                  ),
                                ),
                                value: e['intCityId'],
                              ))
                          .toList(),
                      validator: (value) {
                        return null;
                      },
                      onSaved: (value) {
                        this.personalDetail.intCityId = value;
                      },
                    ),
                  ),
                  Container(
                    height: 48,
                    margin: EdgeInsets.only(top: _fieldGap),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Icon(
                          Icons.location_on,
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
                      focusNode: _state,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      value: getDropdownValue(
                          this.personalDetail.intStateId, true),
                      onChanged: (value) {
                        //print(value);
                        //this.personalDetail.strStateName = value;
                      },
                      items: this
                          .states
                          .map((e) => DropdownMenuItem(
                                child: Text(
                                  e['strStateName'],
                                  style: TextStyle(
                                    color: e['intStateId'] == -1
                                        ? Theme.of(context).dividerColor
                                        : Colors.black,
                                  ),
                                ),
                                value: e['intStateId'],
                              ))
                          .toList(),
                      validator: (value) {
                        return null;
                      },
                      onSaved: (value) {
                        this.personalDetail.intStateId = value;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: _fieldGap),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Country',
                        isDense: true,
                        prefixIcon: Icon(
                          Icons.location_on,
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
                      textAlign: TextAlign.left,
                      initialValue: this.personalDetail.strCountryName,
                      focusNode: _country,
                      validator: (value) {
                        return null;
                      },
                      onSaved: (value) {
                        if (value.isNotEmpty)
                          this.personalDetail.strCountryName = value.trim();
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: _fieldGap),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: RaisedButton(
                      onPressed: () {
                        _onFormSubmitted();
                      },
                      color: Theme.of(context).accentColor,
                      child: isSubmiting
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
                          : Text(
                              'Update',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
