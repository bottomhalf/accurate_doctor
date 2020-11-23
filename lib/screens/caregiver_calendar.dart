import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/widget/caregiver_calendar/calendar.dart';
import 'package:accurate_doctor/widget/caregiver_calendar/calendar_filter.dart';

import '../widget/common/bottom_navigation.dart';
import '../widget/common/page_appbar.dart';
import 'package:flutter/material.dart';

class CaregiverCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        pageTitle: 'Caregiver Calendar',
      ),
      body: Container(
        margin: EdgeInsets.only(
          top: Configuration.pagePadding,
        ),
        padding: EdgeInsets.all(Configuration.pagePadding),
        child: Column(
          children: [
            CalendarFilter(),
            CustomCalendar(),
            Divider(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(0),
    );
  }
}
