import 'package:accurate_doctor/modal/user_detail.dart';
import 'package:accurate_doctor/services/ajax_call.dart';

import '../widget/myprofile/manage_demographic.dart';
import '../widget/myprofile/manage_profession.dart';
import '../widget/myprofile/manage_qualification.dart';
import '../widget/myprofile/doctor_profile_manage.dart';
import '../modal/Configuration.dart';
import '../navigation/Constants.dart';
import '../widget/myprofile/lifestyle.dart';
import '../widget/myprofile/my_family.dart';
import '../widget/common/bottom_navigation.dart';
import '../widget/myprofile/personal_detail.dart';
import '../widget/common/page_appbar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  var personalDetail;
  bool isLoading = true;
  List<Widget> list = [
    Tab(icon: Icon(Icons.card_travel)),
    Tab(icon: Icon(Icons.add_shopping_cart)),
  ];

  int _selectedIndex = 0;

  void getPatientDetail() {}

  @override
  void initState() {
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: list.length, vsync: this);
    UserDetail userDetail = UserDetail.instance;
    AjaxCall http = AjaxCall.getInstance;
    http
        .get("PatientProfile/GetPatientProfileInfo/${userDetail.UserId}")
        .then((value) {
      if (value != null) {
        personalDetail = json.decode(value);
      }

      setState(() {
        isLoading = false;
      });
    });

    _controller.addListener(() {
      /* setState(() {
        _selectedIndex = _controller.index;
      });*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(pageTitle: 'My Profile'),
      body: isLoading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : DefaultTabController(
              length: Configuration.isDoctor ? 4 : 3,
              child: Column(
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints.expand(height: 40),
                    child: TabBar(
                      tabs: Configuration.isDoctor
                          ? [
                              Tab(text: "Personal"),
                              Tab(text: "Demographics"),
                              Tab(text: "Qualification"),
                              Tab(text: "Profession"),
                            ]
                          : [
                              Tab(text: "Personal"),
                              Tab(text: "Lifestyle"),
                              Tab(text: "My family"),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Configuration.isDoctor
                          ? TabBarView(
                              children: [
                                Container(
                                  child: DoctorProfileManage(),
                                ),
                                Container(
                                  child: Demographic(),
                                ),
                                Container(
                                  child: Qualification(),
                                ),
                                Container(
                                  child: Profession(),
                                ),
                              ],
                            )
                          : TabBarView(
                              children: [
                                Container(
                                  child: PersonalDetail(
                                    personalDetail: this.personalDetail,
                                  ),
                                ),
                                Container(
                                  child: LifeStyle(),
                                ),
                                Container(
                                  child: MyFamily(),
                                ),
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
