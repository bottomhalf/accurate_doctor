import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/modal/user_detail.dart';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class CompletedAppointment extends StatefulWidget {
  Function onSave;
  Function onSaveAndPrint;
  Function MoveTo;
  CompletedAppointment({this.onSave, this.onSaveAndPrint, this.MoveTo});

  @override
  _CompletedAppointmentState createState() => _CompletedAppointmentState();
}

class _CompletedAppointmentState extends State<CompletedAppointment> {
  int appointments = 4;
  AjaxCall http;
  UserDetail userDetail;
  bool isAppointmentLoaded = false;
  List<dynamic> appointmentResult = [];

  final _form = GlobalKey<FormState>();
  final _fromDate = FocusNode();
  final _toDate = FocusNode();
  final _name = FocusNode();
  final _mobileNumber = FocusNode();
  final _uhid = FocusNode();
  DateTime fromDate;
  DateTime toDate;

  TextEditingController selectedFromDate = TextEditingController();
  TextEditingController selectedToDate = TextEditingController();
  TextEditingController patientName = TextEditingController();
  TextEditingController mobileNum = TextEditingController();
  TextEditingController uhid = TextEditingController();

  @override
  void initState() {
    super.initState();
    http = AjaxCall.getInstance;
    userDetail = UserDetail.instance;
    _fromDate.addListener(() {
      FocusScope.of(context).unfocus();
      if (_fromDate.hasFocus) {
        Configuration.getDatePicker(context).then((date) {
          if (date != null) {
            this.fromDate = date;
            selectedFromDate.text = DateFormat.yMd().format(date);
          }
        });
      }
    });

    _toDate.addListener(() {
      FocusScope.of(context).unfocus();
      if (_toDate.hasFocus) {
        Configuration.getDatePicker(context).then((date) {
          if (date != null) {
            this.toDate = date;
            selectedToDate.text = DateFormat.yMd().format(date);
          }
        });
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      patientName.text = "";
      mobileNum.text = "";
      uhid.text = "";
      //_loadData();
    });
  }

  @override
  void dispose() {
    _fromDate.dispose();
    _toDate.dispose();
    _name.dispose();
    _mobileNumber.dispose();
    _uhid.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    print('Fromdate: $fromDate & Todate: $toDate');
    await http.post("Common/GetCompleteConsultationsList", {
      "strFromDate":
          DateFormat("yyyy-MM-dd").format(this.fromDate), //"2020-01-07",
      "strToDate": DateFormat("yyyy-MM-dd").format(this.toDate),
      "intBranchId": userDetail.strOrganization,
      "intUserId": userDetail.UserId,
      "strPatientName": patientName.text,
      "strMRNNo": "",
      "strMobileNo": mobileNum.text
    }).then((result) {
      if (result != null) {
        List<dynamic> resultSet = json.decode(result);
        if (resultSet.length > 0) {
          List<dynamic> subResultSet = [];
          int i = 0;
          while (i < resultSet.length) {
            subResultSet.add(resultSet[i]);
            i++;
            if (i == 10) break;
          }
          setState(() {
            appointmentResult = subResultSet;
            isAppointmentLoaded = true;
          });
        }
        Fluttertoast.showToast(msg: "Order History loaded successfully.");
      } else {
        Fluttertoast.showToast(msg: "Fail to laod Order History.");
        setState(() {
          isAppointmentLoaded = true;
        });
      }
    });
  }

  List<Widget> _getAppointmentCard(BuildContext context) {
    List<Widget> cards = List<Widget>();
    int i = 0;
    while (i < appointmentResult.length) {
      cards.add(Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 14,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Container(
                      width: Configuration.width * .25,
                      margin: EdgeInsets.only(
                        right: 10,
                        bottom: 8,
                      ),
                      child: Text(
                        'Patient Name',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(appointmentResult[i]['strPatientName']),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Container(
                      width: Configuration.width * .25,
                      margin: EdgeInsets.only(
                        right: 10,
                        bottom: 8,
                      ),
                      child: Text(
                        'Age',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(appointmentResult[i]['strAge']),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: Configuration.width * .25,
                    margin: EdgeInsets.only(
                      right: 10,
                      bottom: 8,
                    ),
                    child: Text(
                      'Gender',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(appointmentResult[i]['strGender']),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Container(
                      width: Configuration.width * .25,
                      margin: EdgeInsets.only(
                        right: 10,
                        bottom: 8,
                      ),
                      child: Text(
                        'Consult Date',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(appointmentResult[i]['ConsultationDate']),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Container(
                      width: Configuration.width * .25,
                      margin: EdgeInsets.only(
                        right: 10,
                        bottom: 8,
                      ),
                      child: Text(
                        'Diagnosis',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(appointmentResult[i]['Diagnosis']),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Container(
                      width: Configuration.width * .25,
                      margin: EdgeInsets.only(
                        right: 10,
                        bottom: 8,
                      ),
                      child: Text(
                        'View',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Wrap(children: [
                      Text('Detail'),
                      Text(' | '),
                      Text('EMR'),
                      Text(' | '),
                      Text('View Assessment'),
                      Text(' | '),
                      Text('Reports'),
                    ]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
      i++;
    }
    return cards;
  }

  Widget actionButtons(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: RaisedButton(
        color: Theme.of(context).accentColor,
        textColor: Colors.white,
        child: const Text(
          'Search',
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
        onPressed: _loadData,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Configuration.pagePadding),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: Configuration.fieldGap),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Name',
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
              controller: patientName,
              keyboardType: TextInputType.text,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_mobileNumber);
              },
              validator: (value) {
                if (value != null && value != "")
                  return null;
                else
                  return "Patient name is required field";
              },
              onSaved: (value) {
                print(value);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Configuration.fieldGap),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter Mobile Number',
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
              keyboardType: TextInputType.number,
              controller: mobileNum,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_uhid);
              },
              validator: (value) {
                if (value != null && value != "")
                  return null;
                else
                  return "Mobile number is required field";
              },
              onSaved: (value) {
                print(value);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Configuration.fieldGap),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'UHID',
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
              keyboardType: TextInputType.text,
              onFieldSubmitted: (_) {
                //FocusScope.of(context).requestFocus(_testCode);
              },
              validator: (value) {
                return null;
              },
              onSaved: (value) {
                print(value);
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(top: Configuration.fieldGap),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter From Date',
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    focusNode: _fromDate,
                    controller: selectedFromDate,
                    readOnly: true,
                    textAlign: TextAlign.start,
                    keyboardType: null,
                    onFieldSubmitted: (_) {
                      //FocusScope.of(context).requestFocus(_testCode);
                    },
                    validator: (value) {
                      return null;
                    },
                    onSaved: (value) {
                      print(value);
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(top: Configuration.fieldGap),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter To Date',
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    focusNode: _toDate,
                    controller: selectedToDate,
                    readOnly: true,
                    textAlign: TextAlign.start,
                    keyboardType: null,
                    onFieldSubmitted: (_) {
                      //FocusScope.of(context).requestFocus(_testCode);
                    },
                    validator: (value) {
                      return null;
                    },
                    onSaved: (value) {
                      print(value);
                    },
                  ),
                ),
              ),
            ],
          ),
          this.actionButtons(context),
          (isAppointmentLoaded && appointmentResult.length > 0)
              ? Column(
                  children: this._getAppointmentCard(context),
                )
              : Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    'No record found',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
