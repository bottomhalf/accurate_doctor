import 'package:accurate_doctor/modal/user_detail.dart';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:accurate_doctor/widget/common/expandable_card.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../../modal/Configuration.dart';
import '../../modal/RescheduleDataModal.dart';
import 'package:flutter/material.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  int _currentPage = 0;
  List<RescheduleDataModal> rescheduleModal;
  List<dynamic> serviceTypes = [
    {"strServiceType": 'All Service', "intServiceTypeId": -1}
  ];
  List<dynamic> booked = [
    {"strStatus": 'Booked', "intStatusId": -1}
  ];
  final _form = GlobalKey<FormState>();
  final _orderDate = TextEditingController();
  final _scheduleDate = TextEditingController();
  UserDetail userDetail = UserDetail.instance;
  bool isUpcomingApptAvailable = true;
  AjaxCall http;
  List<dynamic> orderHistoryList;
  bool isFiltering = false;

  @override
  void initState() {}

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(Configuration.pagePadding),
        child: Container(
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
                          onSaved: (value) {},
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
                              Fluttertoast.showToast(
                                  msg: 'Status is mandatory');
                            return null;
                          },
                          onSaved: (value) {},
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
                          onSaved: (value) {},
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
                          onSaved: (value) {},
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
                            //_submitForm();
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
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: Configuration.fieldGap),
                  child: Text(
                    'Upcoming Appointment',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  child: ExpandableCard(
                    body: Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Patient Name: ',
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text('L Sai Harsha'),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Age: ',
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text('23 Years'),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Gender: ',
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text('Male'),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Reason For Visit: ',
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text('Fever'),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Appointment Time: ',
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text('09:00'),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Action: ',
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                    'Consultant | Prev Consultation | Reschedule | Cancel | EMR | Video Consultation'),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    cardTitle: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text('Patient Name: '),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'L Sai Harsha',
                                      style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Text('Scheduled At:'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '12th Dec, 2020 09:00 AM',
                                      style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Icon(FontAwesome.caret_down),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
