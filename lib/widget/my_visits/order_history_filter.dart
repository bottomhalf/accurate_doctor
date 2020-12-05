import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/modal/user_detail.dart';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:accurate_doctor/widget/common/expandable_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class OrderHistoryFilter extends StatefulWidget {
  List<dynamic> serviceTypes;
  List<dynamic> booked;

  OrderHistoryFilter({this.serviceTypes, this.booked});

  @override
  _OrderHistoryFilterState createState() => _OrderHistoryFilterState();
}

class _OrderHistoryFilterState extends State<OrderHistoryFilter> {
  final _form = GlobalKey<FormState>();
  final _orderDate = TextEditingController();
  final _scheduleDate = TextEditingController();
  UserDetail userDetail = UserDetail.instance;
  bool isUpcomingApptAvailable = true;
  AjaxCall http;
  List<dynamic> orderHistoryList;
  bool isFiltering = false;

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
    this.loadData();
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
        this.isUpcomingApptAvailable = false;
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

  List<Widget> _bindOrderHistoryCards(BuildContext context) {
    List<Widget> cardWidgets = [];
    int index = 0;
    print('OrderHistory count: ${this.orderHistoryList.length}');
    if (this.orderHistoryList.length <= 0) {
      cardWidgets.add(Container(
        padding: EdgeInsets.only(
          top: 10,
        ),
        child: Text(
          'No history found',
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
      ));
    } else {
      while (index < this.orderHistoryList.length) {
        cardWidgets.add(Container(
          margin: EdgeInsets.symmetric(vertical: Configuration.fieldGap),
          child: ExpandableCard(
            cardTitle: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      Text(
                        'Patient name: ',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${this.orderHistoryList.elementAt(index)['strName']} [ ${this.orderHistoryList.elementAt(index)['strOrderNo']} #]',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Wrap(
                    children: [
                      Text(
                        'Service:',
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        '${this.orderHistoryList.elementAt(index)['strServiceType']}',
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Scheduled On:',
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        '${this.orderHistoryList.elementAt(index)['strScheduleDate']}',
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('View detail'),
                      SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(FontAwesome.caret_down),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: Card(
              elevation: 4,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Patient name',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          Text(
                            this
                                .orderHistoryList
                                .elementAt(index)['strCustomerName'],
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Service Type',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          Text(
                            this
                                .orderHistoryList
                                .elementAt(index)['strServiceType'],
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Mobile no.#',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          Text(
                            this
                                .orderHistoryList
                                .elementAt(index)['strMobileNo'],
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order Date',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          Text(
                            this
                                .orderHistoryList
                                .elementAt(index)['strOrderDate'],
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Schedule Date',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          Text(
                            this
                                .orderHistoryList
                                .elementAt(index)['strScheduleDate'],
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Book Time',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          Text(
                            this
                                .orderHistoryList
                                .elementAt(index)['strBookTime'],
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
        index++;
      }
    }
    return cardWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                          .widget
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
                          .widget
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
            isUpcomingApptAvailable
                ? Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Configuration.fieldGap * 2),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            right: 10,
                            left: 10,
                          ),
                          child: CircularProgressIndicator(),
                        ),
                        Text(
                          'Getting appointments ...',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: this._bindOrderHistoryCards(context),
                  ),
          ],
        ),
      ),
    );
  }
}
