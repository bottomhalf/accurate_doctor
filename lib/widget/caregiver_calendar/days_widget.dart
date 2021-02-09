import 'package:flutter/material.dart';

class DaysWidget extends StatefulWidget {
  int day;
  int month;
  int year;
  Color color;
  TextStyle style;
  DaysWidget({this.day, this.month, this.year, this.color, this.style});

  @override
  _DaysWidgetState createState() => _DaysWidgetState();
}

class _DaysWidgetState extends State<DaysWidget> {
  int selectedDay;
  int selectedMonth;
  int selectedYear;

  @override
  void initState() {
    setState(() {
      selectedDay = DateTime.now().day;
      selectedMonth = DateTime.now().month;
      selectedYear = DateTime.now().year;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: InkWell(
          onTap: () {
            setState(() {
              selectedDay = widget.day;
              selectedMonth = widget.month;
              selectedYear = widget.year;
            });
            print('Working - Day: ${widget.day}, Current:  ${selectedDay}, '
                'Month: ${widget.month}, Current:  ${selectedMonth}, '
                'Year: ${widget.year}, Current:  ${selectedYear}');
          },
          child: Container(
            height: 22,
            width: 22,
            decoration: BoxDecoration(
              //shape: BoxShape.circle,
              color: widget.color,
            ),
            child: Center(
              child: Text(
                widget.day.toString(),
                style: widget.style,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
