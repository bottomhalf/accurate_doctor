import 'package:accurate_doctor/modal/map.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
              KeyMap(
                  key: 'Doctor Calendar',
                  value: NavigationPage.CaregiverCalendar),
              KeyMap(
                  key: 'Completed Consultations',
                  value: NavigationPage.CompletedConsultation),
              KeyMap(
                  key: 'Upload for Complete Consultation',
                  value: NavigationPage.CompletedConsultation),
            ],
          ),
          DrawerItem(
            name: 'Billing & Payments',
            icon: Icons.local_hospital,
            nav: NavigationPage.BillingAngPaymentPage,
            isReplaced: false,
          ),
          DrawerItem(
            name: 'Settings',
            icon: Icons.people_outline,
            nav: NavigationPage.Dashboard,
            isSubmenu: true,
            subMunes: [
              KeyMap(key: 'Profile', value: NavigationPage.MyProfile),
              KeyMap(
                  key: 'Manage Schedule',
                  value: NavigationPage
                      .ManageSchedule), //NavigationPage.Reschedule),
              KeyMap(
                  key: 'Change Password',
                  value: NavigationPage.GenerateNewPassword),
            ],
          ),
          DrawerItem(
            name: 'Reports',
            icon: Icons.date_range,
            nav: NavigationPage.Dashboard,
            isSubmenu: true,
            subMunes: [
              KeyMap(
                  key: 'Invoice Report', value: NavigationPage.InvoiceReport),
              //KeyMap(key: 'Inventory Report', value: null),
              KeyMap(
                  key: 'Appointment Report', value: NavigationPage.Reschedule),
            ],
          ),
          DrawerItem(
            name: 'My Services',
            icon: Icons.mail,
            nav: NavigationPage.MyService,
            isReplaced: false,
          ),
          DrawerItem(
            name: 'Logout',
            icon: FontAwesome.power_off,
            nav: NavigationPage.SignIn,
            isReplaced: false,
          ),
        ],
      ),
    );
  }
}
