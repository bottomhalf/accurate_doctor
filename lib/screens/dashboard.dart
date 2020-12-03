import '../navigation/Constants.dart';
import '../widget/dashboard/app_bar.dart';
import '../widget/dashboard/dashboard_body.dart';
import 'package:flutter/widgets.dart';

import '../widget/common/bottom_navigation.dart';
import '../widget/drawer/app_drawer.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void didUpdateWidget(Dashboard oldWidget) {
    FocusScope.of(context).unfocus();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(
        appBarHeader: 'Dashboard',
        defaultSearchText: '',
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color.fromRGBO(186, 174, 202, 1),
              width: .8,
            ),
          ),
        ),
        padding: const EdgeInsets.only(
          top: 0,
          left: 0,
          right: 0,
          bottom: 10,
        ),
        child: ListView(
          children: [
            DashboardBody(),
          ],
        ),
      ),
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavigation(Tabs.TeleHealth.index),
    );
  }
}
