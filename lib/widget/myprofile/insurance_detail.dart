import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/modal/user_detail.dart';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class InsuranceDetail extends StatefulWidget {
  dynamic personalDetail;
  InsuranceDetail({this.personalDetail});
  @override
  _InsuranceDetailState createState() => _InsuranceDetailState();
}

class _InsuranceDetailState extends State<InsuranceDetail> {
  final _form = GlobalKey<FormState>();
  final _licenseNo = FocusNode();
  final _policyNo = FocusNode();
  final _policyType = FocusNode();
  final _policyId = FocusNode();
  final _policyIndicator = FocusNode();
  final _companyName = FocusNode();
  final _memberName = FocusNode();
  final _paymentMode = FocusNode();
  final _playType = FocusNode();
  final _secondPolicyId = FocusNode();
  bool isSubmiting = false;
  bool isLoading = true;
  AjaxCall http;
  UserDetail userDetail;

  var insuranceDetail;
  void _submitInsuranceDetail() {
    final status = _form.currentState.validate();
    _form.currentState.save();

    if (status) {
      insuranceDetail['IntInsCustomerId'] = userDetail.UserId.toString();
      insuranceDetail['CreatedBy'] = userDetail.UserId.toString();
      insuranceDetail['createdOn'] =
          DateFormat('MM/dd/yyyy').format(DateTime.now());
      http
          .post("Registration/InsertInsuranceDetails", insuranceDetail)
          .then((value) {
        if (value != null) {
          Fluttertoast.showToast(msg: 'Insurance added successfully');
        }
      });
    } else {
      Fluttertoast.showToast(msg: 'Please check invalid fields');
    }

    setState(() {
      insuranceDetail = insuranceDetail;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _licenseNo.dispose();
    _policyNo.dispose();
    _policyType.dispose();
    _policyId.dispose();
    _policyIndicator.dispose();
    _companyName.dispose();
    _memberName.dispose();
    _paymentMode.dispose();
    _playType.dispose();
    _secondPolicyId.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    http = AjaxCall.getInstance;
    userDetail = UserDetail.instance;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      http.post("Registration/GetInsuranceDetails",
          {"IntInsCustomerId": userDetail.UserId}).then((value) {
        Map<String, dynamic> insuranceData = {
          "intInsuranceUnique_Id": "0",
          "IntInsCustomerId": "",
          "intLicenseNO": "",
          "strCompanyname": "",
          "intPolicyId": "",
          "intPolicyNO": "",
          "strMembername": "",
          "intPolicyType": "",
          "intHealthPlanType": "",
          "intSourceofPayment": "",
          "intSecondaryPolicyIndicator": "",
          "intSecondaryPolicyId": "",
          "HealthCardDetailsImgPath": "",
          "CreatedBy": "",
          "createdOn": "",
          "ModifyBy": "",
          "ModifyOn": "",
          "IsActive": "1"
        };

        if (value != null) {
          var data = json.decode(value);
          if (data != null && data.length > 0) {
            insuranceData = data[0];
          } else {
            Fluttertoast.showToast(msg: 'No record found');
          }
        }

        setState(() {
          insuranceDetail = insuranceData;
          isLoading = false;
        });
      });
    });
  }

  Future<void> getDatePicker() async {
    final selectedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 100 * 365)),
      lastDate: DateTime.now(),
    );
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
                    margin: EdgeInsets.only(top: Configuration.fieldGap),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Insurance Company License No.#',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Insurance Company License No.#',
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
                          initialValue: Configuration.getStringValue(
                              insuranceDetail['intLicenseNO']),
                          keyboardType: TextInputType.text,
                          focusNode: _licenseNo,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(this._policyNo);
                          },
                          validator: (value) {
                            return null;
                          },
                          onSaved: (value) {
                            if (value != null)
                              insuranceDetail['intLicenseNO'] = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Configuration.fieldGap),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Policy Number',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Policy Number',
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
                          initialValue: Configuration.getStringValue(
                              insuranceDetail['intPolicyNO']),
                          keyboardType: TextInputType.text,
                          focusNode: this._policyNo,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(this._policyType);
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'Madatory field';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            if (value != null)
                              insuranceDetail['intPolicyNO'] = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Configuration.fieldGap),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Policy Type',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Policy Type',
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
                          initialValue: Configuration.getStringValue(
                              insuranceDetail['intPolicyType']),
                          keyboardType: TextInputType.text,
                          focusNode: this._policyType,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(this._policyId);
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'Madatory field';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            if (value != null)
                              insuranceDetail['intPolicyType'] = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Configuration.fieldGap),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Policy Id',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Policy Id',
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
                          initialValue: Configuration.getStringValue(
                              insuranceDetail['intPolicyId']),
                          keyboardType: TextInputType.text,
                          focusNode: this._policyId,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(this._policyIndicator);
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'Madatory field';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            if (value != null)
                              insuranceDetail['intPolicyId'] = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Configuration.fieldGap),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Secondary Policy Indicator',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Secondary Policy Indicator',
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
                          initialValue: Configuration.getStringValue(
                              insuranceDetail['intSecondaryPolicyIndicator']),
                          keyboardType: TextInputType.text,
                          focusNode: this._policyIndicator,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(this._companyName);
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'Madatory field';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            if (value != null)
                              insuranceDetail['intSecondaryPolicyIndicator'] =
                                  value;
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Configuration.fieldGap),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Insurance Company Name',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Insurance Company Name',
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
                          initialValue: Configuration.getStringValue(
                              insuranceDetail['strCompanyname']),
                          keyboardType: TextInputType.text,
                          focusNode: this._companyName,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(this._memberName);
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'Madatory field';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            if (value != null)
                              insuranceDetail['strCompanyname'] = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Configuration.fieldGap),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Member Name',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Member Name',
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
                          initialValue: Configuration.getStringValue(
                              insuranceDetail['strMembername']),
                          keyboardType: TextInputType.text,
                          focusNode: this._memberName,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(this._playType);
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'Madatory field';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            if (value != null)
                              insuranceDetail['strMembername'] = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Configuration.fieldGap),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Health Plan Type',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Health Plan Type',
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
                          initialValue: Configuration.getStringValue(
                              insuranceDetail['intHealthPlanType']),
                          keyboardType: TextInputType.text,
                          focusNode: this._playType,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(this._paymentMode);
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'Madatory field';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            if (value != null)
                              insuranceDetail['intHealthPlanType'] = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Configuration.fieldGap),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Source of Payment',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Source of Payment',
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
                          initialValue: Configuration.getStringValue(
                              insuranceDetail['intSourceofPayment']),
                          keyboardType: TextInputType.text,
                          focusNode: this._paymentMode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(this._secondPolicyId);
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'Madatory field';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            if (value != null)
                              insuranceDetail['intSourceofPayment'] = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Configuration.fieldGap),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Secondary Policy Id',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Secondary Policy Id',
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
                          initialValue: Configuration.getStringValue(
                              insuranceDetail['intSecondaryPolicyId']),
                          keyboardType: TextInputType.text,
                          focusNode: this._secondPolicyId,
                          onFieldSubmitted: (_) {
                            this._submitInsuranceDetail();
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'Madatory field';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            if (value != null)
                              insuranceDetail['intSecondaryPolicyId'] = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Configuration.fieldGap * 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Health Card Detail',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: ButtonTheme(
                            minWidth: double.infinity,
                            child: OutlineButton(
                              highlightedBorderColor:
                                  Theme.of(context).accentColor,
                              child: Text('Add Document'),
                              textColor: Theme.of(context).accentColor,
                              onPressed: () {},
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Configuration.fieldGap),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: RaisedButton(
                      onPressed: () {
                        _submitInsuranceDetail();
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
