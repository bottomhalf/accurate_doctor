import '../../navigation/NavigationPage.dart';
import '../../widget/drawer/drawer_item.dart';
import 'package:flutter/material.dart';

class PatientMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 40,
      ),
      height: MediaQuery.of(context).size.height * .8,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          DrawerItem(
            name: 'Dashboard',
            icon: Icons.dashboard,
            nav: NavigationPage.Dashboard,
          ),
          DrawerItem(
            name: 'Schedule a visit',
            icon: Icons.schedule,
            nav: NavigationPage.Appointment,
            args: '',
            isReplaced: false,
          ),
          DrawerItem(
            name: 'My health',
            icon: Icons.local_hospital,
            nav: NavigationPage.MyHealth,
          ),
          DrawerItem(
            name: 'Second opinion',
            icon: Icons.people_outline,
            nav: NavigationPage.SecondOpinion,
          ),
          DrawerItem(
            name: 'My visits',
            icon: Icons.date_range,
            nav: NavigationPage.Appointment,
            args: '',
            isReplaced: false,
          ),
          DrawerItem(
            name: 'Messaging',
            icon: Icons.mail,
            nav: NavigationPage.Messaging,
          ),
          DrawerItem(
            name: 'Billing & Payments',
            icon: Icons.receipt,
            nav: NavigationPage.BillingAndPayment,
            isReplaced: false,
          ),
          DrawerItem(
            name: 'Help Center',
            icon: Icons.help_outline,
            nav: NavigationPage.HelpCenter,
          ),
          DrawerItem(
            name: 'Logout',
            icon: Icons.exit_to_app,
            nav: NavigationPage.SignIn,
          ),
        ],
      ),
    );
  }
}
