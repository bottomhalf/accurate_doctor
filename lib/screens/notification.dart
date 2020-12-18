import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/modal/user_detail.dart';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../navigation/Constants.dart';
import '../widget/common/bottom_navigation.dart';
import '../widget/common/page_appbar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Widget> messages = [];
  AjaxCall http;
  List<dynamic> notifications = [];
  bool isLoading = true;
  UserDetail userDetail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    http = AjaxCall.getInstance;
    userDetail = UserDetail.instance;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      this.getNotifications();
    });
  }

  void getNotifications() {
    this.http.post("Common/GetPendingAppointmentDetails",
        {"DocId": userDetail.UserId}).then((value) {
      notifications = json.decode(value);
      setState(() {
        isLoading = false;
      });
    });
  }

  void confirmAppointment(int index) {
    print('Index: $index Total: ${this.notifications.length}');
    var data = this.notifications.elementAt(index);
    if (data != null) {
      setState(() {
        isLoading = true;
      });
      this.http.post("Common/PendingAppointmentStatusUpdation", {
        "intAppointmentId": data['AppointmentID'],
        "strCName": "",
        "strBDate": "",
        "strBTime": "",
        "strCMobile": "",
        "strCMail": "",
        "strDName": data['DoctorName'],
        "strDAddress": "",
        "intAppointmentStatus": 1,
        "strAmount": "",
        "intCategoryId": 1,
        "strserviceName": "",
        "intDoctorId": 1,
        "strAName": ""
      }).then((value) {
        if (value != null) {
          var response = json.decode(value);
          if (response['Status'] != null &&
              response['Status'].toString().indexOf('successfully') != -1) {
            Fluttertoast.showToast(msg: 'Appointment confirmed successfully');
            this.getNotifications();
          } else {
            setState(() {
              isLoading = true;
            });
            Fluttertoast.showToast(msg: 'Fail to confirm.');
          }
        } else {
          setState(() {
            isLoading = true;
          });
        }
      });
    }
  }

  void cancelAppointment(int index) {
    print('Index: $index Total: ${this.notifications.length}');
    var data = this.notifications.elementAt(index);
    if (data != null) {
      setState(() {
        isLoading = true;
      });
      this.http.post("Common/PendingAppointmentStatusUpdation", {
        "intAppointmentId": data['AppointmentID'],
        "strCName": "",
        "strBDate": "",
        "strBTime": "",
        "strCMobile": "",
        "strCMail": "",
        "strDName": data['DoctorName'],
        "strDAddress": "",
        "intAppointmentStatus": 2,
        "strAmount": "",
        "intCategoryId": 1,
        "strserviceName": "",
        "intDoctorId": 1,
        "strAName": ""
      }).then((value) {
        if (value != null) {
          var response = json.decode(value);
          if (response['Status'] != null &&
              response['Status'].toString().indexOf('successfully') != -1) {
            Fluttertoast.showToast(msg: 'Appointment cancelled successfully');
            this.getNotifications();
          } else {
            setState(() {
              isLoading = true;
            });
            Fluttertoast.showToast(msg: 'Fail to confirm.');
          }
        } else {
          setState(() {
            isLoading = true;
          });
        }
      });
    }
  }

  Widget getMessages(var elem, int index) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(Configuration.pagePadding * .5),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerLeft,
                child: CircleAvatar(
                  child: Configuration.getImage(null),
                  radius: 30,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          Configuration.getStringValue(elem['PatientName']),
                          style: TextStyle(
                            color: Configuration.ColorFromHex('#31216F'),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.topRight,
                          child: Icon(
                            FontAwesome.ellipsis_v,
                            color: Colors.grey,
                            size: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Time: ${DateFormat.yMMMd().format(DateTime.parse(elem['start']))} - '
                      '${Configuration.getStringValue(elem['BookTime'])}',
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      '1 hour ago',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: RaisedButton(
                            onPressed: () {
                              this.confirmAppointment(index);
                            },
                            child: Text(
                              'Confirm',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: OutlineButton(
                            onPressed: () {
                              this.cancelAppointment(index);
                            },
                            child: Text('Cancel'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        pageTitle: 'Notification',
      ),
      body: this.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(Configuration.pagePadding),
              child: this.notifications.length == 0
                  ? Center(
                      child: Text(
                        'No notification available',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: this.notifications.length,
                      itemBuilder: (ctx, index) {
                        return this.getMessages(
                            this.notifications.elementAt(index), index);
                      },
                    ),
            ),
      bottomNavigationBar: BottomNavigation(Tabs.TeleHealth.index),
    );
  }
}
