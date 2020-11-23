import 'package:accurate_doctor/modal/booking_request.dart';
import 'package:accurate_doctor/modal/user_detail.dart';
import 'package:accurate_doctor/navigation/NavigationPage.dart';
import 'package:accurate_doctor/widget/book_appointment/booking_type.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../services/ajax_call.dart';
import '../../widget/book_appointment/build_slots.dart';
import 'package:flutter/painting.dart';
import '../../modal/Configuration.dart';
import '../../widget/book_appointment/about_and_rating.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class BookSlot extends StatefulWidget {
  List<dynamic> slots;
  var doctorDetail;
  DateTime bookingOn;
  BookSlot({@required this.slots, this.doctorDetail, this.bookingOn});

  @override
  _BookSlotState createState() => _BookSlotState();
}

class _BookSlotState extends State<BookSlot> {
  final _form = GlobalKey<FormState>();
  final _describeIssue = FocusNode();
  List<dynamic> bindingSlots;
  AjaxCall http;
  String bookingSlot = "";
  bool isForFamily = false;
  String symptom = "";
  String issueDescription = "";
  BookingSlotModal bookingSlotModal;
  UserDetail userDetail;
  bool isSubmiting = false;

  void _bookAppointment() {
    final state = _form.currentState.validate();
    _form.currentState.save();
    FocusScope.of(context).unfocus();

    if (state) {
      if (this.bookingSlotModal.strBookTime.isEmpty) {
        Fluttertoast.showToast(msg: 'Please select time slot');
        return null;
      }

      if (this.bookingSlotModal.strReasonForVisit.isEmpty) {
        Fluttertoast.showToast(msg: 'Please enter symptoms');
        return null;
      }

      setState(() {
        isSubmiting = true;
      });

      Future.delayed(Duration(seconds: 1)).then((value) {
        this.http.post("AppointmentDetails/InsertAppointmentDetails", {
          "intDoctorId": this.bookingSlotModal.intDoctorId,
          "intPatientId": this.userDetail.UserId,
          "ConsultationFee": this.bookingSlotModal.ConsultationFee,
          "dBookDate":
              DateFormat('yyyy-MM-dd').format(this.bookingSlotModal.dBookDate),
          "intSlotNo": this.bookingSlotModal.intSlotNo,
          "strBookTime": this.bookingSlotModal.strBookTime,
          "strReasonForVisit": this.bookingSlotModal.strReasonForVisit,
          "intAppointmentStatus": 5,
          "strEmail": this.bookingSlotModal.strEmail,
          "strName": this.bookingSlotModal.strName,
          "strAge": this.bookingSlotModal.strAge,
          "strGender": this.bookingSlotModal.strGender,
          "strBookedBy": this.bookingSlotModal.strEmail,
          "strDoctorEmailId": this.bookingSlotModal.strDoctorEmailId,
          "strDoctorName": this.bookingSlotModal.strDoctorName,
          "strSourceOne": this.bookingSlotModal.strSourceOne,
          "intCreatedBy": this.bookingSlotModal.intCreatedBy,
          "intBranchId": this.bookingSlotModal.intBranchId,
          "strOrganizationName": this.bookingSlotModal.strOrganizationName,
          "intCategoryId": this.bookingSlotModal.intCategoryId
        }).then((response) {
          if (response != null) {
            var responseData = json.decode(response);
            if (responseData['intappointmentid'] > 0) {
              showMessage(
                      'Appointment created successfully. Your appointment id is: ${responseData['intappointmentid'].toString()}')
                  .then((value) {
                print('Fee: ${this.bookingSlotModal.ConsultationFee}');
                Navigator.of(context)
                    .pushNamed(NavigationPage.BillingAndPayment, arguments: {
                  "fees": this.bookingSlotModal.ConsultationFee,
                  "appointmentId": responseData['intappointmentid'].toString(),
                  "doctor": this.bookingSlotModal.strDoctorName,
                  "date": DateFormat.yMMMd()
                      .format(this.bookingSlotModal.dBookDate),
                  "time": this.bookingSlotModal.strBookTime,
                  "location": this.bookingSlotModal.WorkDetails
                });
              });
            } else {
              showMessage('Fail to create appointment. Please contact admin.');
            }
          } else {
            showMessage('Server error. Please contact admin.');
          }

          setState(() {
            isSubmiting = false;
          });
        });
      });
    } else {
      Fluttertoast.showToast(msg: 'Please enter value correctly');
    }
  }

  Future<void> showMessage(String msg) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Appointment status',
          style: TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 25,
            color: Theme.of(context).accentColor,
          ),
        ),
        content: Text(msg),
        actions: [
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  void buildRequest() {
    this.bookingSlotModal = BookingSlotModal();
    try {
      this.bookingSlotModal.init(
            intDoctorId: widget.doctorDetail['intDoctorId'],
            intPatientId: 0,
            ConsultationFee:
                widget.doctorDetail["strDoctorConsultation"].toString(),
            dBookDate: widget.bookingOn,
            intSlotNo: 0,
            strBookTime: "",
            strReasonForVisit: "",
            intAppointmentStatus: 5,
            strEmail: userDetail.Email,
            strName: userDetail.firstName,
            strAge: userDetail.age,
            strGender: userDetail.Gender,
            strBookedBy: "Self",
            strDoctorEmailId: "",
            strDoctorName: widget.doctorDetail["strDoctorName"],
            strSourceOne: "",
            intCreatedBy: 0,
            intBranchId: 163,
            strOrganizationName: "",
            intCategoryId: 0,
            WorkDetails: widget.doctorDetail["strDoctorLocations"],
          );
    } catch (e) {
      print('Error encountered.');
    }
  }

  @override
  void dispose() {
    _describeIssue.dispose();
    super.dispose();
  }

  @override
  void initState() {
    http = AjaxCall.getInstance;
    userDetail = UserDetail.instance;
    buildRequest();
    setState(() {
      bookingSlotModal = bookingSlotModal;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.slots == null
        ? Center(
            child: const Text('No slot available'),
          )
        : Form(
            key: this._form,
            child: Column(
              children: [
                Container(
                  child: BuildSlots(
                    slots: widget.slots,
                    isMorning: false,
                    modal: bookingSlotModal,
                  ),
                ),
                /*Container(
                  padding: EdgeInsets.all(Configuration.pagePadding),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.wb_sunny),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Morning',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4,
                        ),
                        child: BuildSlots(
                          slots: widget.slots,
                          isMorning: true,
                          modal: bookingSlotModal,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.brightness_4,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Evening',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4,
                        ),
                        child: BuildSlots(
                          slots: widget.slots,
                          isMorning: false,
                          modal: bookingSlotModal,
                        ),
                      ),
                    ],
                  ),
                )*/
                Container(
                  padding: EdgeInsets.all(Configuration.pagePadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'For whom are you booking appointment',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      BookingType(
                        modal: bookingSlotModal,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          'Specify symptoms',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: Configuration.fieldGap),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Enter',
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
                          keyboardType: null,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(this._describeIssue);
                          },
                          validator: (value) {
                            return null;
                          },
                          onSaved: (value) {
                            if (value.isNotEmpty)
                              this.bookingSlotModal.strReasonForVisit = value;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: Configuration.fieldGap),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Describe issue',
                            alignLabelWithHint: true,
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                          ),
                          maxLines: 4,
                          textAlign: TextAlign.start,
                          keyboardType: null,
                          focusNode: _describeIssue,
                          validator: (value) {
                            return null;
                          },
                          onSaved: (value) {
                            /*if (value.isNotEmpty)
                              this.bookingSlotModal.strReasonForVisit = value;*/
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                          top: 10,
                          left: 5,
                          right: 5,
                        ),
                        child: RaisedButton(
                          onPressed: _bookAppointment,
                          child: isSubmiting
                              ? Center(
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  ),
                                )
                              : const Text(
                                  'Book Appointment',
                                  style: TextStyle(color: Colors.white),
                                ),
                          color: Theme.of(context).accentColor,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(Configuration.pagePadding),
                  child: AboutAndRating(
                    aboutMessage:
                        'Some message which will give brief description of the doctor.',
                    rating: 4.0,
                  ),
                ),
              ],
            ),
          );
  }
}
