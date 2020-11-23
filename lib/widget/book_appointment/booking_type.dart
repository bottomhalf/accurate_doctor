import '../../modal/booking_request.dart';
import '../../modal/Configuration.dart';
import '../../widget/book_appointment/appointment_button.dart';
import 'package:flutter/material.dart';

class BookingType extends StatefulWidget {
  BookingSlotModal modal;

  BookingType({modal});

  @override
  _BookingTypeState createState() => _BookingTypeState();
}

class _BookingTypeState extends State<BookingType> {
  bool isForFamily = false;
  void onPatientSelected(int position) {
    print(position);
    setState(() {
      isForFamily = position == -1 ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          AppointmentButton(
            index: -1,
            text: 'For me',
            textColor: Colors.white,
            bgColor: Theme.of(context).accentColor,
            isEnabled: !this.isForFamily,
            paddingGeometry: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            marginGeometry:
                EdgeInsets.only(top: 10, left: 0, right: 5, bottom: 10),
            minWidth: Configuration.width * .3,
            borderColor: Theme.of(context).accentColor,
            isAvaible: true,
            onSelected: this.onPatientSelected,
          ),
          AppointmentButton(
            index: -2,
            text: 'For family member',
            textColor: Theme.of(context).accentColor,
            bgColor: Colors.white,
            isEnabled: this.isForFamily,
            paddingGeometry: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            marginGeometry:
                EdgeInsets.only(top: 10, left: 5, right: 0, bottom: 10),
            minWidth: Configuration.width * .3,
            isAvaible: true,
            borderColor: Theme.of(context).accentColor,
            onSelected: this.onPatientSelected,
          ),
        ],
      ),
    );
  }
}
