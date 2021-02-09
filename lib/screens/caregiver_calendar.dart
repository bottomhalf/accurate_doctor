import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/widget/caregiver_calendar/calendar.dart';
import 'package:accurate_doctor/widget/caregiver_calendar/calendar_filter.dart';
import 'package:accurate_doctor/widget/caregiver_calendar/todays_routine_detail.dart';

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
        child: ListView(
          children: [
            Container(
              child: CustomCalendar(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(0),
    );
  }
}
