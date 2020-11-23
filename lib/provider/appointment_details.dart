import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class AppointmentDetails with ChangeNotifier {
  String fromdate;
  String todate;
  String strfromtime;
  String strtotime;
  int intDoctorId;
  int intAppointmentId;
  String strPatientName;
  String strDate;
  String strTimings;
  String strAppointmentId;
  int intAppointmentStatus;
  String strCMobile;
  String strDName;
  String strBDate;
  String strBTime;
  String strDAddress;
  String strCName;
  String strCMail;
  String strAmount;
  int intCategoryId;
  String strserviceName;
  String strAName;
  String strOrganizationName;

  AppointmentDetails({
    this.fromdate,
    this.todate,
    this.strfromtime,
    this.strtotime,
    this.intDoctorId,
    this.intAppointmentId,
    this.strPatientName,
    this.strDate,
    this.strTimings,
    this.strAppointmentId,
    this.intAppointmentStatus,
    this.strCMobile,
    this.strDName,
    this.strBDate,
    this.strBTime,
    this.strDAddress,
    this.strCName,
    this.strCMail,
    this.strAmount,
    this.intCategoryId,
    this.strserviceName,
    this.strAName,
    this.strOrganizationName,
  });

  factory AppointmentDetails.toJsonList(Map<String, dynamic> data) {
    return AppointmentDetails(
      fromdate: data['fromdate'],
      todate: data['todate'],
      strfromtime: data['strfromtime'],
      strtotime: data['strtotime'],
      intDoctorId: data['intDoctorId'],
      intAppointmentId: data['intAppointmentId'],
      strPatientName: data['strPatientName'],
      strDate: data['strDate'],
      strTimings: data['strTimings'],
      strAppointmentId: data['strAppointmentId'],
      intAppointmentStatus: data['intAppointmentStatus'],
      strCMobile: data['strCMobile'],
      strDName: data['strDName'],
      strBDate: data['strBDate'],
      strBTime: data['strBTime'],
      strDAddress: data['strDAddress'],
      strCName: data['strCName'],
      strCMail: data['strCMail'],
      strAmount: data['strAmount'],
      intCategoryId: data['intCategoryId'],
      strserviceName: data['strserviceName'],
      strAName: data['strAName'],
      strOrganizationName: data['strOrganizationName'],
    );
  }
}
