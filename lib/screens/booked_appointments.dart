import 'package:accurate_doctor/modal/RescheduleDataModal.dart';
import 'package:accurate_doctor/navigation/Constants.dart';
import 'package:accurate_doctor/widget/common/bottom_navigation.dart';
import 'package:accurate_doctor/widget/reschedule/widget_stepper.dart';
import '../widget/common/page_appbar.dart';
import '../widget/reschedule/my_orders.dart';
import '../widget/reschedule/order_history.dart';
import 'package:flutter/material.dart';

class ManageReschedule extends StatefulWidget {
  @override
  _ManageRescheduleState createState() => _ManageRescheduleState();
}

class _ManageRescheduleState extends State<ManageReschedule> {
  RescheduleDataModal rescheduleDataModal;

  @override
  void initState() {
    rescheduleDataModal = RescheduleDataModal('', false, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        pageTitle: 'Appointments',
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              child: TabBar(
                tabs: [
                  Tab(
                    text: 'My Order',
                  ),
                  Tab(
                    text: 'Order History',
                  ),
                ],
                labelColor: Theme.of(context).accentColor,
                labelStyle: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: TabBarView(
                  children: [
                    Container(
                      child: WidgetStepper(
                        items: rescheduleDataModal.getBuildModal(true),
                        isMyOrder: true,
                      ),
                    ),
                    //OrderHistory(),
                    WidgetStepper(
                      items: rescheduleDataModal.getBuildModal(false),
                      isMyOrder: false,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(Tabs.TeleHealth.index),
    );
  }
}
