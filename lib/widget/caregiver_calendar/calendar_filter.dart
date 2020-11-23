import 'package:accurate_doctor/navigation/Constants.dart';
import 'package:flutter/material.dart';

class CalendarFilter extends StatefulWidget {
  @override
  _CalendarFilterState createState() => _CalendarFilterState();
}

class _CalendarFilterState extends State<CalendarFilter> {
  bool today = false;
  bool week = false;
  bool month = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      this.today = true;
      this.week = false;
      this.month = false;
    });
  }

  void getCalenderDetail(CalendarType type) {
    switch (type) {
      case CalendarType.Today:
        setState(() {
          this.today = true;
          this.week = false;
          this.month = false;
        });
        break;
      case CalendarType.Week:
        setState(() {
          this.today = false;
          this.week = true;
          this.month = false;
        });
        break;
      case CalendarType.Month:
        setState(() {
          this.today = false;
          this.week = false;
          this.month = true;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              this.getCalenderDetail(CalendarType.Today);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color:
                    this.today ? Theme.of(context).accentColor : Colors.white,
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                ),
              ),
              child: Text(
                'Today',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color:
                      this.today ? Colors.white : Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              this.getCalenderDetail(CalendarType.Week);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: this.week ? Theme.of(context).accentColor : Colors.white,
                border: Border.symmetric(
                  vertical: BorderSide(color: Colors.black),
                ),
              ),
              child: Text(
                'Week',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color:
                      this.week ? Colors.white : Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              this.getCalenderDetail(CalendarType.Month);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color:
                    this.month ? Theme.of(context).accentColor : Colors.white,
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
              child: Text(
                'Month',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color:
                      this.month ? Colors.white : Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
