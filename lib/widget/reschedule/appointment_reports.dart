import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/modal/user_detail.dart';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class AppointmentReports extends StatefulWidget {
  Function onSave;
  Function onSaveAndPrint;
  Function MoveTo;
  AppointmentReports({this.onSave, this.onSaveAndPrint, this.MoveTo});

  @override
  _AppointmentReportsState createState() => _AppointmentReportsState();
}

class _AppointmentReportsState extends State<AppointmentReports> {
  int appointments = 4;
  AjaxCall http;
  UserDetail userDetail;
  bool isAppointmentLoaded = false;
  List<dynamic> appointmentResult = [];
  List<dynamic> statusValues = [];
  List<dynamic> locationValues = [];

  final _form = GlobalKey<FormState>();
  final _fromDate = FocusNode();
  final _toDate = FocusNode();
  DateTime fromDate;
  DateTime toDate;

  TextEditingController selectedFromDate = TextEditingController();
  TextEditingController selectedToDate = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController location = TextEditingController();

  @override
  void initState() {
    super.initState();
    http = AjaxCall.getInstance;
    userDetail = UserDetail.instance;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadData();
      this.statusValues = List<dynamic>();
      this.locationValues = List<dynamic>();

      this.statusValues.add({"strStatus": "Status", "intStatusId": -1});
      this.locationValues.add({"strLocation": "Location", "intLocationId": -1});
      setState(() {
        this.statusValues = statusValues;
        this.locationValues = locationValues;
      });
    });
  }

  Future<void> _loadData() async {
    await http.post("Common/GetCompleteConsultationsList", {
      "strFromDate":
          DateFormat("yyyy-MM-dd").format(DateTime.now()), //"2020-01-07",
      "strToDate": DateFormat("yyyy-MM-dd").format(DateTime.now()),
      "intBranchId": userDetail.strOrganization,
      "intUserId": userDetail.UserId,
      "strPatientName": "",
      "strMRNNo": "",
      "strMobileNo": ""
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
        onPressed: widget.onSaveAndPrint,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Configuration.pagePadding),
      child: Column(
        children: [
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
          Container(
            height: 48,
            margin: EdgeInsets.only(
              top: Configuration.fieldGap,
              bottom: Configuration.fieldGap,
            ),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              value: -1,
              items: this
                  .statusValues
                  .map((e) => DropdownMenuItem(
                        child: Text(
                          e['strStatus'],
                          style: TextStyle(
                            color: e['intStatusId'] == -1
                                ? Theme.of(context).dividerColor
                                : Colors.black,
                          ),
                        ),
                        value: e['intStatusId'],
                      ))
                  .toList(),
              validator: (value) {
                if (value == null || value == -1) {
                  Fluttertoast.showToast(msg: 'Service type is mandatory');
                }
                return null;
              },
              onChanged: (value) {
                //print(value);
                //this.personalDetail.strStateName = value;
              },
              onSaved: (value) {
                //filterRequest["intServiceTypeId"] = value;
              },
            ),
          ),
          Container(
            height: 48,
            margin: EdgeInsets.only(
              top: Configuration.fieldGap,
              bottom: Configuration.fieldGap,
            ),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              value: -1,
              items: this
                  .locationValues
                  .map((e) => DropdownMenuItem(
                        child: Text(
                          e['strLocation'],
                          style: TextStyle(
                            color: e['intLocationId'] == -1
                                ? Theme.of(context).dividerColor
                                : Colors.black,
                          ),
                        ),
                        value: e['intLocationId'],
                      ))
                  .toList(),
              validator: (value) {
                if (value == null || value == -1) {
                  Fluttertoast.showToast(msg: 'Service type is mandatory');
                }
                return null;
              },
              onChanged: (value) {
                //print(value);
                //this.personalDetail.strStateName = value;
              },
              onSaved: (value) {
                // filterRequest["intServiceTypeId"] = value;
              },
            ),
          ),
          this.actionButtons(context),
          (isAppointmentLoaded && appointmentResult.length > 0)
              ? Column(
                  children: this._getAppointmentCard(context),
                )
              : Container(
                  child: Text('No record found'),
                ),
        ],
      ),
    );
  }
}
