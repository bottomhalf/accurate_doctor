import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/widget/common/expandable_card.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';

import '../navigation/Constants.dart';
import '../widget/common/bottom_navigation.dart';
import '../widget/common/page_appbar.dart';
import 'package:flutter/material.dart';

class InvoiceReport extends StatelessWidget {
  final _orderDate = TextEditingController();
  final _scheduleDate = TextEditingController();

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
    return Scaffold(
      appBar: PageAppBar(
        pageTitle: 'Completed Consultation',
      ),
      body: Container(
        padding: EdgeInsets.all(Configuration.pagePadding),
        child: ListView(
          children: [
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
                        labelText: 'From date',
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
                        labelText: 'To date',
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
            Container(
              margin: EdgeInsets.only(top: Configuration.fieldGap),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Location',
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
                onFieldSubmitted: (_) {},
                validator: (value) {
                  return null;
                },
                onSaved: (value) {},
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: Configuration.fieldGap),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Status',
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
                onFieldSubmitted: (_) {},
                validator: (value) {
                  return null;
                },
                onSaved: (value) {},
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: Configuration.fieldGap),
              width: double.infinity,
              child: OutlineButton(
                onPressed: () {},
                child: Text('Search'),
              ),
            ),
            SizedBox(
              height: Configuration.fieldGap * 2,
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
            ),
            InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(top: Configuration.fieldGap * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(FontAwesome.print),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Print',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(Tabs.TeleHealth.index),
    );
  }
}
