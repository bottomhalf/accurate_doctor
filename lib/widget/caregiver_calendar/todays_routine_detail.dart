import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';

class TodaysRoutineDetail extends StatelessWidget {
  List<Widget> routine;
  List<dynamic> calendarData;
  DateTime selectedDate;

  TodaysRoutineDetail({this.calendarData, this.selectedDate}) {
    this.getTodaysList();
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.only(
        bottom: 10,
        top: 10,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12),
        ),
        color: Colors.lightBlue,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Column(
                children: [
                  Text(DateFormat('EEE').format(selectedDate).toUpperCase()),
                  Container(
                    padding: EdgeInsets.all(6),
                    margin: EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      color: Configuration.ColorFromHex('#31216F'),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Text(
                      selectedDate.day <= 9
                          ? '0${selectedDate.day}'
                          : '${selectedDate.day}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: EdgeInsets.only(
                left: 10,
              ),
              child: Text(
                '${this.calendarData.length} Clinic Appointments',
                style: TextStyle(
                  color: Configuration.ColorFromHex('#31216F'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getTodaysList() {
    routine = [];
    int i = 0;
    routine.add(_buildHeader());
    if (this.calendarData.length > 0) {
      while (i < this.calendarData.length) {
        routine.add(Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black12,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.black12,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Center(
                    child: Text(
                      '${this.calendarData.elementAt(i)['BookTime']}',
                      style: TextStyle(
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${this.calendarData.elementAt(i)['strAppointmentStatus']}',
                        style: TextStyle(
                          color: Configuration.ColorFromHex('#31216F'),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            bottom: Configuration.fieldGap * .25),
                        child: Wrap(
                          children: [
                            Text(
                              'Reason: ',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              '${this.calendarData.elementAt(i)['ReasonforVisit']}',
                              style: TextStyle(
                                color: Configuration.ColorFromHex('#31216F'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            bottom: Configuration.fieldGap * .25),
                        child: Wrap(
                          children: [
                            Text(
                              'Patient Name: ',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              '${this.calendarData.elementAt(i)['PatientName']}',
                              style: TextStyle(
                                color: Configuration.ColorFromHex('#31216F'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
        i++;
      }
    } else {
      routine.add(
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 20),
          child: Text('No appointment found.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: this.routine,
      ),
    );
  }
}
