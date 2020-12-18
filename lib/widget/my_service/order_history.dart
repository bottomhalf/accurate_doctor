import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/modal/user_detail.dart';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:accurate_doctor/widget/common/expandable_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class ServiceOrderHistory extends StatefulWidget {
  @override
  _ServiceOrderHistoryState createState() => _ServiceOrderHistoryState();
}

class _ServiceOrderHistoryState extends State<ServiceOrderHistory> {
  final _form = GlobalKey<FormState>();
  final _orderDate = TextEditingController();
  final _scheduleDate = TextEditingController();
  UserDetail userDetail = UserDetail.instance;
  AjaxCall http;
  List<dynamic> orderHistoryList;
  bool isFiltering = false;
  List<dynamic> serviceTypes = [
    {"strServiceType": 'All Service', "intServiceTypeId": -1}
  ];
  List<dynamic> booked = [
    {"strStatus": 'Booked', "intStatusId": -1}
  ];

  var filterRequest = {
    "intPatientId": -1,
    "intServiceTypeId": 0,
    "intStatusId": 0,
    "strOrderDate": "",
    "strScheduleDate": ""
  };

  @override
  void initState() {
    super.initState();
    http = AjaxCall.getInstance;
    filterRequest = {
      "intPatientId": -1,
      "intServiceTypeId": 0,
      "intStatusId": 0,
      "strOrderDate": "",
      "strScheduleDate": ""
    };
    //this.loadData();
  }

  Future<void> _getDatePicker(BuildContext context, bool isOrderDate) async {
    final selectedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 100 * 365)),
      lastDate: DateTime.now(),
    );

    if (selectedDateTime != null) {
      if (isOrderDate)
        this._orderDate.text =
            DateFormat('MM/dd/yyyy').format(selectedDateTime);
      else
        this._scheduleDate.text =
            DateFormat('MM/dd/yyyy').format(selectedDateTime);
    }
  }

  void loadData() {
    filterRequest["intPatientId"] = 511; // userDetail.UserId;
    http
        .post("AppointmentsCommon/GetPatientOrdersDetail", filterRequest)
        .then((value) {
      if (value != null) {
        orderHistoryList = json.decode(value);
        if (orderHistoryList == null && orderHistoryList.length <= 0) {
          orderHistoryList = [];
        }
      }

      setState(() {
        this.orderHistoryList = orderHistoryList;
        this.isFiltering = false;
      });
    });
  }

  void _submitForm() {
    final status = this._form.currentState.validate();
    this._form.currentState.save();

    if (status) {
      setState(() {
        isFiltering = true;
      });
      this.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Configuration.pagePadding),
      child: Form(
        key: _form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    margin: EdgeInsets.only(
                      top: Configuration.fieldGap,
                      bottom: Configuration.fieldGap,
                      right: 10,
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
                          .serviceTypes
                          .map((e) => DropdownMenuItem(
                                child: Text(
                                  e['strServiceType'],
                                  style: TextStyle(
                                    color: e['intServiceTypeId'] == -1
                                        ? Theme.of(context).dividerColor
                                        : Colors.black,
                                  ),
                                ),
                                value: e['intServiceTypeId'],
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null || value == -1) {
                          Fluttertoast.showToast(
                              msg: 'Service type is mandatory');
                        }
                        return null;
                      },
                      onChanged: (value) {
                        //print(value);
                        //this.personalDetail.strStateName = value;
                      },
                      onSaved: (value) {
                        filterRequest["intServiceTypeId"] = value;
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 48,
                    margin: EdgeInsets.only(
                      top: Configuration.fieldGap,
                      bottom: Configuration.fieldGap,
                      right: 10,
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
                      onChanged: (value) {
                        //print(value);
                        //this.personalDetail.strStateName = value;
                      },
                      value: -1,
                      items: this
                          .booked
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
                        if (value == null || value == -1)
                          Fluttertoast.showToast(msg: 'Status is mandatory');
                        return null;
                      },
                      onSaved: (value) {
                        filterRequest["intStatusId"] = value;
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: Configuration.fieldGap,
                      bottom: Configuration.fieldGap,
                      right: 10,
                    ),
                    child: TextFormField(
                      readOnly: true,
                      onTap: () {
                        this._getDatePicker(context, true);
                      },
                      controller: _orderDate,
                      decoration: InputDecoration(
                        labelText: 'Order date',
                        isDense: true,
                        suffixIcon: IconButton(
                          icon: Icon(FontAwesome.calendar),
                          onPressed: () {},
                          iconSize: Configuration.width * .04,
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
                      onFieldSubmitted: (_) {},
                      validator: (value) {
                        if (value == null || value == "")
                          return "Order date is mandatory";
                        return null;
                      },
                      onSaved: (value) {
                        filterRequest["strOrderDate"] = _orderDate.text;
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: Configuration.fieldGap,
                      bottom: Configuration.fieldGap,
                      right: 10,
                    ),
                    child: TextFormField(
                      controller: _scheduleDate,
                      readOnly: true,
                      onTap: () {
                        this._getDatePicker(context, false);
                      },
                      decoration: InputDecoration(
                        labelText: 'Schedule date',
                        isDense: true,
                        suffixIcon: IconButton(
                          icon: Icon(FontAwesome.calendar),
                          onPressed: () {},
                          iconSize: Configuration.width * .04,
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
                      onFieldSubmitted: (_) {},
                      validator: (value) {
                        if (value == null || value == "")
                          return "Schedule date is mandatory";
                        return null;
                      },
                      onSaved: (value) {
                        filterRequest["strScheduleDate"] = _scheduleDate.text;
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: Configuration.fieldGap,
                      bottom: Configuration.fieldGap,
                      right: 10,
                    ),
                    child: RaisedButton(
                      onPressed: () {
                        _submitForm();
                      },
                      color: Theme.of(context).accentColor,
                      child: isFiltering
                          ? SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              ),
                            )
                          : Text(
                              'Go',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: Configuration.fieldGap,
                      bottom: Configuration.fieldGap,
                      right: 10,
                    ),
                    child: OutlineButton(
                      onPressed: () {},
                      child: Text(
                        'Reset',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Configuration.fieldGap,
            ),
            Text(
              'Upcoming Appointment',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
