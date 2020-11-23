import 'package:accurate_doctor/widget/drawer/app_drawer.dart';

import '../widget/secondopinion/view_secondopinion.dart';
import '../widget/secondopinion/create_opinion.dart';
import '../navigation/Constants.dart';
import '../widget/common/bottom_navigation.dart';
import '../widget/common/page_appbar.dart';
import 'package:flutter/material.dart';

class SecondOpinion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        pageTitle: 'Second Opinion',
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(height: 40),
              child: TabBar(
                tabs: [
                  Tab(text: "Create a request for second opinion"),
                  Tab(text: "View second opinion"),
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: TabBarView(children: [
                  Container(
                    child: CreateNewOpinion(),
                  ),
                  Container(
                    child: ViewSecondOpinion(),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
      //drawer: AppDrawer(),
      bottomNavigationBar: BottomNavigation(Tabs.SecondOpinion.index),
    );
  }
}
