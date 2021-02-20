import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/modal/user_detail.dart';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:accurate_doctor/widget/caregiver_calendar/calendar_filter.dart';
import 'package:accurate_doctor/widget/caregiver_calendar/todays_routine_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

const double pWidth = 392.7;

class CustomCalendar extends StatefulWidget {
  @override
  CustomCalendarState createState() => CustomCalendarState();
}

class CustomCalendarState extends State<CustomCalendar>
    with TickerProviderStateMixin {
  /// Boolean to handle calendar expansion
  bool _expanded;
  bool _isWeekData = false;
  int _weekCounter = -1;
  bool _isCurrentDayData = false;
  bool _isMonthData = false;

  /// The height of an individual week row
  double collapsedHeightFactor;

  /// The y coordinate of the active week row
  double activeRowYPosition;

  /// The date var that handles the changing months on click
  DateTime displayDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  /// The date that is shown as Month , Year between the arrows
  DateTime showDate;

  /// The row that contains the current week withing the list of rows generated
  int activeRow;

  /// The list that stores the week rows of the month
  List<Widget> calList;

  /// PageController to handle the changing month views on click
  PageController pageController = PageController(initialPage: 0);

  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeInOut);

  /// Animation controller that handles the calendar expansion event and the
  /// expand_more icon rotation event
  ///
  AnimationController _controller;
  DateTime StartDate = DateTime.now();
  DateTime EndDate = DateTime.now();

  /// Animation controller that handles the expand_more icon fading in/out event
  /// based on if the current month is being displayed
  AnimationController _monthController;

  /// The animation for the changing height with the y coordinates in calendar expansion
  Animation<double> _anim;

  /// Color animation for the -> and <- arrows that change the month view
  Animation<Color> _arrowColor;

  /// Animation for the rotating expand_more/less icon
  Animation<double> _iconTurns;

  /// Color animation for the ^ arrow that handles expansion of view
  Animation<Color> _monthColor;

  /// Animation duration
  static const Duration _kExpand = Duration(milliseconds: 300);

  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  // Boolean to handle what to do when calendar is expanded or contracted
  ValueChanged<bool> onExpansionChanged;

  /// Color tween for -> and <- icons
  Animatable<Color> _arrowColorTween =
      ColorTween(begin: Color(0x00FFA68A), end: Color(0xffFFA68A));

  /// Color tween for expand_less icon
  Animatable<Color> _monthColorTween =
      ColorTween(begin: Color(0xffEC520B), end: Color(0x00EC520B));

  int selectedDay = DateTime.now().day;
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;

  AjaxCall http;
  UserDetail userDetail;
  List<dynamic> calendarData = [];
  bool isLoading = true;
  bool completeRefresh = false;

  @override
  void initState() {
    // calendar is not expanded initially
    print('Calenda called');
    _expanded = true;
    showDate = displayDate;
    http = AjaxCall.getInstance;
    userDetail = UserDetail.instance;

    // [returnRowList] called and stored in [rowListReturned] to make use of in the next occurrences
    List<Widget> rowListReturned =
        returnRowList(DateTime(displayDate.year, displayDate.month, 1));

    //Determine the height of one week row
    collapsedHeightFactor = 1 / rowListReturned.length;

    //Determine the y coordinate of the current week row with this formula
    activeRowYPosition =
        ((2 / (rowListReturned.length - 1)) * getActiveRow()) - 1;

    //Initialize animation controllers
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _monthController = AnimationController(duration: _kExpand, vsync: this);
    _anim = _controller.drive(_easeInTween);
    _arrowColor = _controller.drive(_arrowColorTween.chain(_easeInTween));
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _monthColor = _monthController.drive(_monthColorTween.chain(_easeInTween));
    _controller.forward();

    //initial value = false
    _expanded = PageStorage.of(context)?.readState(context) ?? false;
    if (_expanded) _controller.value = 1.0;

    //calList contains the list of week Rows of the displayed month
    calList = [
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: rowListReturned,
      )
    ];

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Configuration.isDoctor)
        _loadCalendarData();
      else
        _loadPatientCalendarData();
    });
    super.initState();
  }

  Future<void> _loadPatientCalendarData() async {
    await http.post("AppointmentDetails/GetCalenderAppointmentDetails", {
      "Start_Date":
          DateFormat('MM/dd/yyyy').format(this.StartDate), // "02/03/2021",
      "EndDate": DateFormat('MM/dd/yyyy').format(this.EndDate),
      "intPatientId": userDetail.UserId
    }).then((calendarResultSet) {
      if (calendarResultSet != null) {
        List<dynamic> result = json.decode(calendarResultSet);
        if (result.length > 0) {
          setState(() {
            calendarData = result.take(4).toList();
            isLoading = false;
            completeRefresh = false;
          });
        } else {
          setState(() {
            calendarData = [];
            isLoading = false;
            completeRefresh = false;
          });
        }
      }
    });
  }

  Future<void> _loadCalendarData() async {
    await http.post("Common/GetCalenderAppointmentDetails", {
      "Start_Date":
          DateFormat('MM/dd/yyyy').format(this.StartDate), // "02/03/2021",
      "EndDate": DateFormat('MM/dd/yyyy').format(this.EndDate),
      "DocId": userDetail.UserId,
      "intBranchId": userDetail.strOrganization
    }).then((calendarResultSet) {
      if (calendarResultSet != null) {
        List<dynamic> result = json.decode(calendarResultSet);
        if (result.length > 0) {
          setState(() {
            calendarData = result;
            isLoading = false;
            completeRefresh = false;
          });
        } else {
          setState(() {
            calendarData = [];
            isLoading = false;
            completeRefresh = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _monthController.dispose();
    super.dispose();
  }

  void filterType(bool isToday, bool isWeek, bool isMonth) {
    DateTime _startDate = null;
    DateTime _endDate = null;
    if (isToday) {
      _startDate = this.StartDate;
      _endDate = this.StartDate;
    } else if (isWeek) {
      _startDate = this.StartDate;
      _endDate = this.StartDate.add(Duration(days: 6));
    } else if (isMonth) {
      _startDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
      _endDate = this.StartDate.add(Duration(
          days:
              (DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day) -
                  1));
    }
    setState(() {
      completeRefresh = true;
      _isWeekData = isWeek;
      _isCurrentDayData = isToday;
      _isMonthData = isMonth;
      this.StartDate = _startDate;
      this.EndDate = _endDate;
      calList = [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: returnRowList(
            DateTime(_startDate.year, _startDate.month, 1),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: returnRowList(
            DateTime(_startDate.year, _startDate.month + 1, 1),
          ),
        ),
      ];
      //Increment showDate by a month
      showDate = DateTime(_startDate.year, _startDate.month, 1);
    });
    _loadCalendarData();
    Fluttertoast.showToast(msg: 'Please select date');
  }

  @override
  Widget build(BuildContext context) {
    double scaleFactor = Configuration.width / pWidth;
    double calendarWidth = Configuration.width;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: Configuration.pagePadding),
          child: CalendarFilter(filterType: this.filterType),
        ),
        completeRefresh
            ? Container(
                margin: EdgeInsets.only(
                  top: 50,
                ),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                padding: EdgeInsets.all(Configuration.pagePadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 80,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 8 * scaleFactor,
                          bottom: 8 * scaleFactor,
                          left: 0,
                          right: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: IconButton(
                                enableFeedback: _expanded,
                                splashRadius: _expanded ? 15.0 : 0.001,
                                icon: AnimatedBuilder(
                                  animation: _arrowColor,
                                  builder:
                                      (BuildContext context, Widget child) =>
                                          Icon(
                                    FontAwesome.chevron_left,
                                    size: Configuration.width * .04,
                                    color: Theme.of(context).dividerColor,
                                  ),
                                ),
                                onPressed: () {
                                  DateTime curr = showDate;
                                  setState(() {
                                    //set calList to previous month to showDate and showDate
                                    calList = [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        mainAxisSize: MainAxisSize.min,
                                        children: returnRowList(
                                          DateTime(showDate.year,
                                              showDate.month - 1, 1),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        mainAxisSize: MainAxisSize.min,
                                        children: returnRowList(
                                          DateTime(
                                              showDate.year, showDate.month, 1),
                                        ),
                                      ),
                                    ];
                                    //Decrement the showDate by 1 month
                                    showDate = DateTime(
                                        showDate.year, showDate.month - 1, 1);
                                  });

                                  //Fade in/out the expand icon if current month is not displayed month
                                  if (areMonthsSame(curr, DateTime.now())) {
                                    _monthController.forward();
                                    Future.delayed(Duration(milliseconds: 1),
                                        () {
                                      setState(() {});
                                    });
                                  } else if (areMonthsSame(
                                      showDate, DateTime.now())) {
                                    _monthController.reverse();
                                    Future.delayed(_kExpand, () {
                                      setState(() {});
                                    });
                                  }
                                  pageController.jumpToPage(1);
                                  pageController.previousPage(
                                      duration: _kExpand,
                                      curve: Curves.easeInOut);
                                },
                              ),
                            ),
                            // Displayed Month, Displayed Year
                            Text(
                              formatDate(showDate),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              textScaleFactor: scaleFactor,
                            ),
                            Material(
                              color: Colors.transparent,
                              child: IconButton(
                                enableFeedback: _expanded,
                                splashRadius: _expanded ? 15.0 : 0.001,
                                icon: AnimatedBuilder(
                                  animation: _arrowColor,
                                  builder:
                                      (BuildContext context, Widget child) =>
                                          Icon(
                                    FontAwesome.chevron_right,
                                    size: Configuration.width * .04,
                                    color: Theme.of(context).dividerColor,
                                  ),
                                ),
                                onPressed: () {
                                  DateTime curr = showDate;
                                  setState(() {
                                    //set calList to showDate and showDate incremented by 1 month
                                    calList = [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        mainAxisSize: MainAxisSize.min,
                                        children: returnRowList(
                                          DateTime(
                                              showDate.year, showDate.month, 1),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        mainAxisSize: MainAxisSize.min,
                                        children: returnRowList(
                                          DateTime(showDate.year,
                                              showDate.month + 1, 1),
                                        ),
                                      ),
                                    ];
                                    //Increment showDate by a month
                                    showDate = DateTime(
                                        showDate.year, showDate.month + 1, 1);
                                  });

                                  //Fade in/out the expand icon if current month is not displayed month
                                  if (areMonthsSame(curr, DateTime.now())) {
                                    _monthController.forward();
                                    Future.delayed(Duration(milliseconds: 1),
                                        () {
                                      setState(() {});
                                    });
                                  } else if (areMonthsSame(
                                      showDate, DateTime.now())) {
                                    _monthController.reverse();
                                    Future.delayed(_kExpand, () {
                                      setState(() {});
                                    });
                                  }
                                  pageController.jumpToPage(0);
                                  pageController.nextPage(
                                      duration: _kExpand,
                                      curve: Curves.easeInOut);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _controller.view,
                      builder: (BuildContext context, Widget child) =>
                          Container(
                        child: Container(
                          width: Configuration.width,
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                          height: calendarWidth * 0.6,
                          child: PageView(
                            controller: pageController,
                            scrollDirection: Axis.horizontal,
                            children: calList,
                            //the pageview is not swipable as this affects the changing months
                            physics: NeverScrollableScrollPhysics(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        completeRefresh
            ? Container()
            : isLoading
                ? Container(
                    padding: EdgeInsets.only(
                      left: Configuration.fieldGap * 2,
                    ),
                    child: Row(
                      children: [
                        CircularProgressIndicator(),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Loading ...',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : TodaysRoutineDetail(
                    calendarData: calendarData,
                    selectedDate: StartDate,
                  ),
      ],
    );
  }

  //Format the received date into full month and year format
  String formatDate(DateTime date) => new DateFormat("MMMM yyyy").format(date);

  // Used to handle calendar expansion and icon rotation events
/*  void _handleTap() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        print('forward');
        _controller.forward();
      } else {
        print('reversed');
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _expanded);
    });
    if (onExpansionChanged != null) onExpansionChanged(_expanded);
  }*/

  //Get the current week row from the list of all the rows per current month
  int getActiveRow() {
    List<List<int>> rowValueList =
        generateMonth(DateTime(displayDate.year, displayDate.month, 1));
    for (int i = 0; i < rowValueList.length; i++) {
      for (int j = i; j < rowValueList[i].length; j++) {
        if (displayDate.month == DateTime.now().month &&
            rowValueList[i].contains(DateTime.now().day) &&
            monthChecks(i, rowValueList[i][j])) {
          activeRow = i + 1;
        }
      }
    }
    return activeRow;
  }

  //checks to ensure that the dates used to generate active row dont use prev. or next. month's dates
  bool monthChecks(int i, int value) {
    if (i <= 1 && value <= 14) {
      return true;
    } else if (i >= 4 && value > 7) {
      return true;
    } else if (i < 4 || i > 1) {
      return true;
    } else {
      return false;
    }
  }

  ///Generate a month given the start date of month as a list of list of integers
  /// e.g. [[30, 1, 2, 3, 4, 5, 6], [7, 8, 9, 10, 11, 12, 13],..]. Weeks start
  /// from Monday.
  List<List<int>> generateMonth(DateTime firstOfMonth) {
    List<List<int>> rowValueList = [];

    //Adding the first week
    DateTime endWeek =
        firstOfMonth.add(Duration(days: 7 - firstOfMonth.weekday));
    DateTime startWeek = endWeek.subtract(Duration(days: 6));
    List<int> first = [];
    for (DateTime j = startWeek;
        j.compareTo(endWeek) <= 0;
        j = j.add(Duration(days: 1))) {
      first.add(j.day);
    }
    rowValueList.add(first);

    //Moving the counters
    int i = endWeek.day + 1;
    endWeek = endWeek.add(Duration(days: 7));

    //Looping to add the other weeks inside the month
    while (endWeek.month == firstOfMonth.month) {
      List<int> temp = [];
      for (int j = i; j <= endWeek.day; j++) {
        temp.add(j);
      }
      rowValueList.add(temp);
      i = 1 + endWeek.day;
      endWeek = endWeek.add(Duration(days: 7));
    }

    //Adding the last week
    if (endWeek.day < 7) {
      List<int> last = [];
      startWeek = endWeek.subtract(Duration(days: 6));
      for (DateTime j = startWeek;
          j.compareTo(endWeek) <= 0;
          j = j.add(Duration(days: 1))) {
        last.add(j.day);
      }
      rowValueList.add(last);
    }
    //print(rowValueList);
    return rowValueList;
  }

  Color _getColor(int day, int month, int year, int i) {
    Color currentColor = Colors.transparent;
    if (day == selectedDay &&
        month == selectedMonth &&
        year == selectedYear &&
        !((i == 0 && day > 7) || (i >= 4 && day < 7))) {
      if (_isWeekData) _weekCounter = 0;
      currentColor = Color(0xffFFA68A);
    } else {
      if (_isWeekData && _weekCounter < 6 && _weekCounter >= 0) {
        currentColor = Configuration.ColorFromHex('#b5eeff');
        if (_weekCounter == 5) currentColor = Color(0xffFFA68A);
        _weekCounter++;
      } else {
        currentColor = Colors.transparent;
      }
    }
    return currentColor;
  }

  // Returns a list of Rows containing the weeks of a month
  List<Widget> returnRowList(DateTime start) {
    print('Month: ${start.month}, State month: $selectedMonth');
    List<Widget> rowList = <Widget>[
      Padding(
        //do not change this padding
        padding: EdgeInsets.only(
          bottom: 22,
          left: 0,
          right: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            calendarWeekday('Mon'),
            calendarWeekday('Tue'),
            calendarWeekday('Wed'),
            calendarWeekday('Thu'),
            calendarWeekday('Fri'),
            calendarWeekday('Sat'),
            calendarWeekday('Sun'),
          ],
        ),
      ),
    ];
    List<List<int>> rowValueList = generateMonth(start);
    for (int i = 0; i < rowValueList.length; i++) {
      List<Widget> itemList = [];
      for (int j = 0; j < rowValueList[i].length; j++) {
        itemList.add(
          Expanded(
            child: InkWell(
              onTap: () {
                DateTime endDate =
                    DateTime(start.year, start.month, rowValueList[i][j]);
                if (_isWeekData) {
                  endDate = endDate.add(Duration(days: 7));
                }
                setState(() {
                  selectedDay = rowValueList[i][j];
                  selectedMonth = start.month;
                  selectedYear = start.year;
                  StartDate =
                      DateTime(start.year, start.month, rowValueList[i][j]);
                  EndDate = endDate;
                  isLoading = true;
                  calList = [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: returnRowList(
                        DateTime(start.year, start.month, 1),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: returnRowList(
                        DateTime(start.year, start.month + 1, 1),
                      ),
                    ),
                  ];
                  //Increment showDate by a month
                  showDate = DateTime(start.year, start.month, 1);
                });

                _loadCalendarData();
              },
              child: Container(
                height: 22,
                width: 22,
                decoration: BoxDecoration(
                  //shape: BoxShape.circle,
                  color:
                      _getColor(rowValueList[i][j], start.month, start.year, i),
                ),
                child: Center(
                  child: Text(
                    rowValueList[i][j].toString(),
                    style: (rowValueList[i][j] == selectedDay &&
                                start.month == start.month &&
                                start.year == start.year) &&
                            !((i == 0 && rowValueList[i][j] > 7) ||
                                (i >= 4 && rowValueList[i][j] < 7))
                        ? TextStyle(
                            fontWeight: FontWeight.bold,
                          )
                        //Grey out the previous month's and next month's values or dates
                        : TextStyle(
                            fontWeight: FontWeight.normal,
                            color: ((i == 0 && rowValueList[i][j] > 7) ||
                                    (i >= 4 && rowValueList[i][j] < 7))
                                ? Colors.grey
                                : Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        );
      }
      Widget temp = Padding(
        //this padding seems important
        padding: EdgeInsets.only(bottom: 12, left: 0, right: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: itemList,
        ),
      );
      rowList.add(temp);
    }
    return rowList;
  }

  //Return a Text with Style according to input String, used for the days
  Widget calendarWeekday(String day) {
    return Text(
      day,
      style: TextStyle(fontSize: 11, color: Color(0xff828282)),
    );
  }

  // Utility functions to compare Dates:
  bool areDaysSame(DateTime a, DateTime b) {
    return areMonthsSame(a, b) && a.day == b.day;
  }

  bool areMonthsSame(DateTime a, DateTime b) {
    return areYearsSame(a, b) && a.month == b.month;
  }

  bool areYearsSame(DateTime a, DateTime b) {
    return a.year == b.year;
  }
}
