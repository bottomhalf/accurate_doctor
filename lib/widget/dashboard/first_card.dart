import 'package:accurate_doctor/modal/user_detail.dart';
import 'package:accurate_doctor/navigation/Constants.dart';
import 'package:accurate_doctor/navigation/NavigationPage.dart';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../modal/Configuration.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class FirstCard extends StatefulWidget {
  @override
  _FirstCardState createState() => _FirstCardState();
}

class _FirstCardState extends State<FirstCard> {
  UserDetail userDetail;
  AjaxCall http;
  List<dynamic> result = [];
  bool isLoading = false;
  dynamic myvisitResultSet = null;
  dynamic currentAppt = null;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      userDetail = UserDetail.instance;
      http = AjaxCall.getInstance;
      _loadLatestVisits();
    });
  }

  void _loadLatestVisits() {
    userDetail = UserDetail.instance;
    http = AjaxCall.getInstance;
    http.post("AppointmentsCommon/GetPatientOrdersDetail", {
      "intPatientId": userDetail.UserId,
      "intServiceTypeId": 0,
      "intStatusId": 0,
      "strOrderDate": null,
      "strScheduleDate": null
    }).then((value) {
      if (value != null) {
        try {
          result = json.decode(value);
        } catch (e) {
          Fluttertoast.showToast(msg: FailtoLoad);
        }
        filterUpcomingAppointment(result);
      } else {
        Fluttertoast.showToast(msg: ServerError);
      }

      setState(() {
        result = result;
        isLoading = false;
      });
    });
  }

  void filterUpcomingAppointment(dynamic resultSet) {
    DateTime scheduleDate = null;
    int upComingApptIndex = -1;
    DateTime now =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    if (resultSet != null && resultSet.length > 0) {
      int i = 0;
      int dayDiff = 0;
      while (i < resultSet.length) {
        currentAppt = resultSet.elementAt(i);
        if (currentAppt['strStatus'] == "Booked" &&
            currentAppt['strScheduleDate'] != null) {
          try {
            scheduleDate = DateTime.parse(currentAppt['strScheduleDate']);
            scheduleDate = DateTime(
                scheduleDate.year, scheduleDate.month, scheduleDate.day);
            dayDiff = scheduleDate.difference(now).inDays;
            if (upComingApptIndex == -1 ||
                dayDiff >= 0 && dayDiff < upComingApptIndex) {
              upComingApptIndex = i;
            }
          } catch (e) {
            print('Invalid date');
          }
        }
        i++;
      }

      if (upComingApptIndex != -1) {
        currentAppt = resultSet.elementAt(upComingApptIndex);
        setState(() {
          this.myvisitResultSet = currentAppt;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            transform: Matrix4.translationValues(0, 16, 0),
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 0,
            ),
            alignment: Alignment.bottomLeft,
            child: Text(
              'Upcoming Appointment',
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
              top: 20,
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 25.0,
                  spreadRadius: -35,
                  color: Configuration.ColorFromHex('#6E4AFA'),
                ),
              ],
            ),
            width: double.infinity,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: myvisitResultSet == null
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              'No upcoming appointment available',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(NavigationPage.MyVisits);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                top: 10,
                              ),
                              width: double.infinity,
                              alignment: Alignment.bottomRight,
                              child: const Text(
                                'View My Visit Page',
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      FontAwesome.video_camera,
                                      color: Colors.cyan,
                                      size: Configuration.width * .05,
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                          child: Text(
                                            'Start with Dr. ${myvisitResultSet['strName']}',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '${myvisitResultSet['strBookTime']} hrs, ${myvisitResultSet['strScheduleDate']}',
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.event_note,
                                    color: Theme.of(context).accentColor,
                                    size: Configuration.width * .05,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  FittedBox(
                                    child: const Text(
                                      'Reschedule',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Theme.of(context).accentColor,
                                      size: Configuration.width * .05,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                          child: Text(
                                            'Start with ${myvisitResultSet['strName']}',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '${myvisitResultSet['strBookTime']} hrs, ${myvisitResultSet['strScheduleDate']}',
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.event_note,
                                    color: Theme.of(context).accentColor,
                                    size: Configuration.width * .05,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  FittedBox(
                                    child: const Text(
                                      'Reschedule',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(NavigationPage.MyVisits);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                top: 10,
                              ),
                              width: double.infinity,
                              alignment: Alignment.bottomRight,
                              child: const Text(
                                'View ALL',
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
