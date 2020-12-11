import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/modal/user_detail.dart';
import 'package:accurate_doctor/widget/dashboard/doctor_first_card.dart';
import 'package:accurate_doctor/widget/dashboard/doctor_second_card.dart';
import 'package:accurate_doctor/widget/dashboard/doctor_third_card.dart';

import '../../widget/dashboard/second_card.dart';
import '../../widget/dashboard/third_card.dart';
import '../../widget/dashboard/first_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../provider/dashboard_header_menu.dart';
import '../../widget/dashboard/header_navbar.dart';

class DashboardBody extends StatelessWidget {
  var headerMenuItem = [];
  int itemCount;
  UserDetail _userDetail;

  DashboardBody() {
    var dashboardHeaderMenu = DashboardHeaderMenu();
    headerMenuItem = dashboardHeaderMenu.getMenu();
    _userDetail = UserDetail.instance;
    if (headerMenuItem.length > 0)
      itemCount = headerMenuItem.length;
    else
      itemCount = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 20,
              left: 24,
              right: 44,
              bottom: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello ${_userDetail.firstName} ${_userDetail.lastName}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 60,
                  child: Image.asset(
                    "assets/img/Group_1023@2x.png",
                    fit: BoxFit.fitWidth,
                  ),
                )
              ],
            ),
          ),
          Configuration.isDoctor
              ? Container(
                  child: Column(
                    children: [
                      //==========================================  first card ==========================
                      DoctorFirstCard(),
                      //=========================  secornd card ================================
                      DoctorSecondCard(),
                      //=========================  third card ================================
                      DoctorThirdCard(),
                    ],
                  ),
                )
              : Container(
                  child: Column(
                    children: [
                      //==========================================  first card ==========================
                      FirstCard(),
                      //=========================  secornd card ================================
                      SecondCard(),
                      //=========================  third card ================================
                      ThirdCard(),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
