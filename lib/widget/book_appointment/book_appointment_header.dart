import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/widget/book_appointment/appointment_button.dart';
import 'package:intl/intl.dart';

import '../../services/ajax_call.dart';
import 'package:flutter/material.dart';

class BookAppointmentHeader extends StatefulWidget {
  var userData;
  Function updateSlotList;

  BookAppointmentHeader({this.userData, this.updateSlotList});

  @override
  _BookAppointmentHeaderState createState() => _BookAppointmentHeaderState();
}

class _BookAppointmentHeaderState extends State<BookAppointmentHeader> {
  AjaxCall http = AjaxCall.getInstance;
  String dayAfterNextDate = DateFormat('EEEE').format(DateTime.now());
  bool isForToday = true;
  bool isForTomorrow = false;
  bool isForDayAfterTomorrow = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Configuration.getImage(widget.userData['strDoctorImage']),
              radius: 50,
            ),
            title: Text(
              widget.userData['strDoctorName'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).accentColor,
              ),
            ),
            subtitle: Text(
              widget.userData['strDoctorSpecialityName'],
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ListTile(
                  title: Center(
                    child: Text(
                      '2k',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  subtitle: Center(
                    child: Text('PATIENTS'),
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 20,
                color: Colors.grey,
              ),
              Expanded(
                child: ListTile(
                  title: Center(
                    child: Text(
                      '5',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  subtitle: Center(
                    child: Text('EXPRIENCE'),
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 20,
                color: Colors.grey,
              ),
              Expanded(
                child: ListTile(
                  title: Center(
                    child: Text(
                      '4.5',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  subtitle: Center(
                    child: Text('RATING'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isForDayAfterTomorrow = false;
                      isForTomorrow = false;
                      isForToday = true;
                    });
                    widget.updateSlotList('today');
                  },
                  child: ClipRRect(
                    child: Container(
                      alignment: Alignment.center,
                      width: Configuration.width * .3,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Today, ${DateFormat('d MMM').format(DateTime.now())}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'No slots available',
                            style: TextStyle(
                              color: isForToday
                                  ? Colors.black
                                  : Theme.of(context).dividerColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isForDayAfterTomorrow = false;
                      isForTomorrow = true;
                      isForToday = false;
                    });
                    widget.updateSlotList('tomorrow');
                  },
                  child: ClipRRect(
                    child: Container(
                      alignment: Alignment.center,
                      width: Configuration.width * .3,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Tomorrow, ${DateFormat('d MMM').format(DateTime.now().add(Duration(days: 1)))}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'No slots available',
                            style: TextStyle(
                              color: isForTomorrow
                                  ? Colors.black
                                  : Theme.of(context).dividerColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isForDayAfterTomorrow = true;
                      isForTomorrow = false;
                      isForToday = false;
                    });
                    widget.updateSlotList('dayaftertomorrow');
                  },
                  child: ClipRRect(
                    child: Container(
                      alignment: Alignment.center,
                      width: Configuration.width * .3,
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${dayAfterNextDate}, ${DateFormat('d MMM').format(DateTime.now().add(Duration(days: 2)))}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'No slots available',
                            style: TextStyle(
                              color: isForDayAfterTomorrow
                                  ? Colors.black
                                  : Theme.of(context).dividerColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
