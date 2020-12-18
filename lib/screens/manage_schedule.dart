import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/modal/RescheduleDataModal.dart';
import 'package:accurate_doctor/widget/common/bottom_navigation.dart';
import 'package:accurate_doctor/widget/manage_doctor/manage_schedule.dart';
import '../widget/common/page_appbar.dart';
import 'package:flutter/material.dart';

class ManageSchedulePage extends StatelessWidget {
  RescheduleDataModal rescheduleDataModal =
      RescheduleDataModal('', false, false);

  @override
  void initState() {
    rescheduleDataModal = RescheduleDataModal('', false, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        pageTitle: 'Manage',
      ),
      body: Container(
        padding: EdgeInsets.only(top: Configuration.pagePadding),
        child: ManageSchedule(
          items: rescheduleDataModal.getManageDoctor(),
        ),
      ),
      bottomNavigationBar: BottomNavigation(0),
    );
  }
}
