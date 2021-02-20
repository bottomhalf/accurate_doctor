import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/modal/user_detail.dart';
import 'package:accurate_doctor/navigation/Constants.dart';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:accurate_doctor/widget/common/expandable_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

const Booked = "booked";
const Done = "done";

class VisitCard extends StatelessWidget {
  var appointmentDetail;
  AjaxCall http = AjaxCall.getInstance;
  UserDetail userDetail;
  VisitCard({this.appointmentDetail});

  void _cancelAppointment() {
    userDetail = UserDetail.instance;
    http.post("AppointmentDetails/OrderCancelnonorgAppointmentDetails", {
      "strOrderNo": appointmentDetail['strOrderNo'],
      "intmodifiedby": userDetail.UserId,
      "strName": appointmentDetail['strName'],
      "strEmail": appointmentDetail['strEmail'],
      "strMobileNo": appointmentDetail['strMobileNo'],
      "strCustomerEmailId": userDetail.Email,
      "strCustomerMobileNo": userDetail.MobileNo,
      "strCustomerName": appointmentDetail['strCustomerName'],
      "strBookTime": appointmentDetail['strBookTime'],
      "strScheduleDate": "02/10/2020",
      "intCategoryId": appointmentDetail['intCategoryId'],
      "straddress": "Dayanand clinic,Hyderabad"
    }).then((value) {
      if (value != null) {
        Fluttertoast.showToast(msg: "Appointment cancelled successfully");
      } else {
        Fluttertoast.showToast(msg: ServerError);
      }
    });
  }

  Future<void> _startZoomMeeting() async {
    Fluttertoast.showToast(msg: "Loading meeting detail...");
    const url = 'AppointmentsCommon/InitiateMeeting/pay_GUOL6QAYfQl5xI';
    http.get(url).then((zoomResult) {
      if (zoomResult != null) {
        dynamic result = json.decode(zoomResult);
        if (result['Join_url'] != null && result['Join_url'] != "") {
          _launceInBrowser(result['Join_url']);
        }
      }
    });
  }

  Future<void> _launceInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: "Fail t open");
    }
  }

  bool isActiveZoom(String status) {
    if (status != null && status.trim() != "") {
      String lStatus = status.toLowerCase();
      return lStatus == Booked || lStatus == Done;
    }
    return false;
  }

  bool isActivePrescription(String status) {
    if (status != null && status.trim() != "") {
      String lStatus = status.toLowerCase();
      return lStatus == Done;
    }
    return false;
  }

  void _findAttachmentByOrderId(String orderId) {
    Fluttertoast.showToast(msg: "Loading detail...");
    if (orderId != null && orderId.trim() != "") {
      try {
        int currentOrderId = int.parse(orderId);
        http.post("AppointmentsCommon/GetMiniConsultationDetails", {
          "intAppointmentId": currentOrderId,
          "intCustomerId": 0
        }).then((apptDetail) {
          Fluttertoast.showToast(
              msg: "Please wait. Trying to fetch your data...");
          if (apptDetail != null) {
            List<dynamic> apptOrderDetail = json.decode(apptDetail);
            if (apptOrderDetail != null && apptOrderDetail.length > 0) {
              int consultationId = apptOrderDetail[0]['intConsultationId'];
              if (consultationId > 0) {
                http
                    .get(
                        "Common/GetPatientConsultationDetails/${consultationId}",
                        true)
                    .then((appt) {
                  if (appt != null) {
                    dynamic consltDetail = json.decode(appt);
                    if (consltDetail != null) {
                      var linkedFileUrl = consltDetail['strdocumentfullpath'];
                      _launceInBrowser(linkedFileUrl);
                    }
                  }
                });
              }
            }
          }
        });
      } catch (e) {
        print(
            'Got error before [AppointmentsCommon/GetMiniConsultationDetails]');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 14,
      ),
      child: ExpandableCard(
        cardTitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [
                Text(
                  'Provider: ',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '${this.appointmentDetail['strName']} [ ${this.appointmentDetail['strOrderNo']} #]',
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
                  'Type of visit:',
                  style: TextStyle(
                    color: Theme.of(context).dividerColor,
                    fontSize: 10,
                  ),
                ),
                Text(
                  this.appointmentDetail['strServiceType'],
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
                  'Order Date:',
                  style: TextStyle(
                    color: Theme.of(context).dividerColor,
                    fontSize: 10,
                  ),
                ),
                Text(
                  this.appointmentDetail['strOrderDate'],
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
                        'Service Provider',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      Text(
                        'Type of Visit',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        this.appointmentDetail['strName'],
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        this.appointmentDetail['strServiceType'],
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Appointment No.#',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      Text(
                        'Booked by',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        this.appointmentDetail['strOrderNo'],
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        this.appointmentDetail['BookedBy'],
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
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
                        'Schedule Date',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        this.appointmentDetail['strOrderDate'],
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        this.appointmentDetail['strScheduleDate'],
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
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
                        'Status',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        this.appointmentDetail['strBookTime'],
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        this.appointmentDetail['strStatus'],
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Make Payment',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      Text(
                        'Video Chat',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        this.appointmentDetail['strPrice'],
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        this.appointmentDetail['strPrice'],
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Prescription Detail',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Prescribed July 15, 2020',
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      /*Row(
                        children: [
                          Text(
                            'Approved by',
                            style: TextStyle(
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Dr Divya',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),*/
                    ],
                  ),
                  alignment: Alignment.bottomLeft,
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Zoom Link',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      isActiveZoom(this.appointmentDetail['strStatus'])
                          ? InkWell(
                              onTap: () {
                                _startZoomMeeting();
                              },
                              child: Container(
                                width: 24,
                                child: Configuration.getImage(
                                    "http://seniorcare1.healthygx.com/Content/img/VideoChat.png"),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Attached Prescription',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      isActivePrescription(this.appointmentDetail['strStatus'])
                          ? InkWell(
                              onTap: () {
                                _findAttachmentByOrderId(
                                    this.appointmentDetail['strOrderNo']);
                              },
                              child: Container(
                                width: 24,
                                child: Icon(FontAwesome.file_photo_o),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(right: 4),
                          width: double.infinity,
                          child: RaisedButton(
                            onPressed: () {},
                            color: Theme.of(context).accentColor,
                            child: Text(
                              'Rescheduled',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 4),
                          width: double.infinity,
                          child: RaisedButton(
                            elevation: 4,
                            color: Colors.white,
                            onPressed: () {
                              _cancelAppointment();
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
