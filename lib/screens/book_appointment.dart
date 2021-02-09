import 'dart:convert';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:accurate_doctor/widget/book_appointment/about_and_rating.dart';
import 'package:accurate_doctor/widget/book_appointment/book_appointment_header.dart';
import 'package:accurate_doctor/widget/book_appointment/book_slot.dart';
import '../modal/Configuration.dart';
import '../navigation/Constants.dart';
import 'package:flutter/widgets.dart';
import '../widget/common/bottom_navigation.dart';
import '../widget/common/page_appbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookAppointment extends StatefulWidget {
  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  int userId;
  bool isDataAvailable = false;
  AjaxCall http;
  List<dynamic> bindingSlot;
  List<dynamic> presentDateAvailableSlots;
  List<dynamic> tomorrowsAvailableSlots;
  List<dynamic> dayAfterTomorrowsAvailableSlots;
  var userData;
  int slotForDay = 0;
  DateTime bookingSlotDate;

  void _loadUserData() async {
    if (http == null) {
      http = AjaxCall.getInstance;
    }

    final data =
        await http.get('AppointmentsCommon/GetDoctorDetails/${this.userId}');
    if (data != null) {
      List<dynamic> result = json.decode(data);
      if (result != null && result.length > 0) {
        userData = result[0];
        userData['intDoctorId'] = this.userId;
        final slotsDetail =
            await http.post('AppointmentsCommon/GetDoctorTimeSlots', {
          "intDoctorId": this.userId,
          "strBookDate": DateFormat('yyyy-MM-dd').format(bookingSlotDate),
        });
        if (slotsDetail != null) {
          presentDateAvailableSlots = List<dynamic>();
          tomorrowsAvailableSlots = List<dynamic>();
          dayAfterTomorrowsAvailableSlots = List<dynamic>();

          DateTime now = DateTime.now();
          DateTime currentDay = DateTime(now.year, now.month, now.day);
          List<dynamic> slots = json.decode(slotsDetail);
          if (slots != null) {
            int index = 0;
            int days = 0;
            while (index < slots.length) {
              days = currentDay
                  .difference(
                      DateTime.parse(slots.elementAt(index)['AvailableDate']))
                  .inDays;

              slots.elementAt(index)['index'] = index;
              slots.elementAt(index)['IsEnabled'] = false;
              if (days == 0) {
                presentDateAvailableSlots.add(slots.elementAt(index));
              } else if (days == -1) {
                tomorrowsAvailableSlots.add(slots.elementAt(index));
              } else if (days == -2) {
                dayAfterTomorrowsAvailableSlots.add(slots.elementAt(index));
              }
              index++;
            }
          }

          setState(() {
            bindingSlot = presentDateAvailableSlots;
            presentDateAvailableSlots = presentDateAvailableSlots;
            tomorrowsAvailableSlots = tomorrowsAvailableSlots;
            dayAfterTomorrowsAvailableSlots = dayAfterTomorrowsAvailableSlots;
            userData = userData;
            isDataAvailable = true;
            bookingSlotDate = DateTime.now();
          });
        } else {
          setState(() {
            presentDateAvailableSlots = [];
            tomorrowsAvailableSlots = [];
            dayAfterTomorrowsAvailableSlots = [];
            userData = userData;
            isDataAvailable = true;
            bookingSlotDate = DateTime.now();
          });
        }
      }
    } else {
      setState(() {
        presentDateAvailableSlots = [];
        tomorrowsAvailableSlots = [];
        dayAfterTomorrowsAvailableSlots = [];
        userData = userData;
        isDataAvailable = true;
        bookingSlotDate = DateTime.now();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      int param = ModalRoute.of(context).settings.arguments as int;
      bookingSlotDate = DateTime.now();
      if (param != null) {
        setState(() {
          userId = param;
        });
        _loadUserData();
      }
    });
  }

  Future<void> _refreshPage() async {
    await this._loadUserData();
  }

  Widget getWaitOrFailedWidget(var result) {
    if (result != null) {
      return Container(
        width: Configuration.width * .7,
        child: Text(
          'Fail to get data. Please contact to admin else pull to retry again',
          style: TextStyle(
            color: Theme.of(context).accentColor,
          ),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  void updateSlotList(String day) {
    int selectedIndex = 0;
    setState(() {
      bindingSlot = [];
    });

    Future.delayed(Duration(seconds: 1)).then((value) {
      List<dynamic> updatedSlots;
      switch (day) {
        case 'today':
          updatedSlots = this.presentDateAvailableSlots;
          bookingSlotDate = DateTime.now();
          slotForDay = 0;
          break;
        case 'tomorrow':
          updatedSlots = this.tomorrowsAvailableSlots;
          bookingSlotDate = DateTime.now().add(Duration(days: 1));
          slotForDay = 1;
          break;
        case 'dayaftertomorrow':
          updatedSlots = this.dayAfterTomorrowsAvailableSlots;
          bookingSlotDate = DateTime.now().add(Duration(days: 2));
          slotForDay = 2;
          break;
        default:
          updatedSlots = [];
          break;
      }

      int index = 0;
      while (index < updatedSlots.length) {
        if (updatedSlots.elementAt(index)['index'] == selectedIndex) {
          updatedSlots.elementAt(index)['index'] = true;
        } else {
          updatedSlots.elementAt(index)['index'] = false;
        }
        index++;
      }

      setState(() {
        bindingSlot = updatedSlots;
        isDataAvailable = false;
        slotForDay = slotForDay;
        bookingSlotDate = bookingSlotDate;
      });

      _loadUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(pageTitle: 'Book Appointment'),
      body: RefreshIndicator(
        onRefresh: _refreshPage,
        child: !isDataAvailable
            ? Center(
                child: this.getWaitOrFailedWidget(userData),
              )
            : SingleChildScrollView(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: Configuration.pagePadding),
                  child: Column(
                    children: [
                      BookAppointmentHeader(
                        userData: userData,
                        updateSlotList: updateSlotList,
                      ),
                      BookSlot(
                        slots: this.bindingSlot,
                        doctorDetail: userData,
                        bookingOn: bookingSlotDate,
                      ),
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: BottomNavigation(Tabs.TeleHealth.index),
    );
  }
}
