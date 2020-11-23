import 'package:accurate_doctor/modal/map.dart';

import '../../navigation/NavigationPage.dart';
import '../../widget/drawer/drawer_item.dart';
import 'package:flutter/material.dart';

class DoctorMenu extends StatelessWidget {
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
            name: 'Appointments',
            icon: Icons.schedule,
            isSubmenu: true,
            nav: NavigationPage.Dashboard,
            subMunes: [
              KeyMap(key: 'Doctor Calendar', value: null),
              KeyMap(key: 'Completed Consultations', value: null),
              KeyMap(key: 'Upload for Complete Consultation', value: null),
            ],
          ),
          DrawerItem(
            name: 'Billing & Payments',
            icon: Icons.local_hospital,
            nav: NavigationPage.MyHealth,
            isReplaced: false,
          ),
          DrawerItem(
            name: 'Settings',
            icon: Icons.people_outline,
            nav: NavigationPage.Dashboard,
            isSubmenu: true,
            subMunes: [
              KeyMap(key: 'Profile', value: null),
              KeyMap(key: 'Manage Schedule', value: NavigationPage.Reschedule),
              KeyMap(key: 'Change Password', value: null),
            ],
          ),
          DrawerItem(
            name: 'Reports',
            icon: Icons.date_range,
            nav: NavigationPage.Dashboard,
            isSubmenu: true,
            subMunes: [
              KeyMap(key: 'Invoice Report', value: null),
              KeyMap(key: 'Inventory Report', value: null),
              KeyMap(key: 'Appointment Report', value: null),
            ],
          ),
          DrawerItem(
            name: 'My Services',
            icon: Icons.mail,
            nav: NavigationPage.Dashboard,
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
