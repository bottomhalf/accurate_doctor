import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/widget/common/circular_wizard_box.dart';
import 'package:accurate_doctor/widget/common/expandable_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MyOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(Configuration.pagePadding),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: Configuration.height * .15,
              child: CircularWizardBox(
                radius: 30,
                goToIndexedWizard: null,
                index: 0,
                title: 'Today\'s Patient List',
                righttWing: 0,
                leftWing: 0,
                isCompleted: true,
                isInProgress: false,
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.only(
                top: Configuration.fieldGap * 2,
                bottom: Configuration.fieldGap,
              ),
              child: Text(
                'Online Appointment',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
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
            ),
            Container(
              margin: EdgeInsets.only(
                top: Configuration.fieldGap * 2,
              ),
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {},
                child: Text(
                  'Add Appointment',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Theme.of(context).accentColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
