import 'package:accurate_doctor/widget/health_summary/health_issue_body.dart';
import 'package:accurate_doctor/widget/health_summary/medication.dart';

import '../modal/Configuration.dart';
import '../widget/health_summary/allergies.dart';
import '../widget/health_summary/immunization.dart';
import '../widget/reschedule/medication.dart';
import '../widget/common/bottom_navigation.dart';
import '../widget/common/page_appbar.dart';
import 'package:flutter/material.dart';

class HealthSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        pageTitle: 'Health Summary',
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            Container(
              height: Configuration.height * .08,
              child: TabBar(
                isScrollable: true,
                tabs: [
                  Tab(
                    child: Text('Current health issues'),
                  ),
                  Tab(
                    child: Text('Medications'),
                  ),
                  Tab(
                    child: Text('Allergies'),
                  ),
                  Tab(
                    child: Text('Immunizations'),
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
              flex: 3,
              child: Container(
                //height: Configuration.height * .6,
                child: TabBarView(
                  children: [
                    HealthIssueBody(),
                    Medications(),
                    Allergies(),
                    Immunizations(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(2),
    );
  }
}
