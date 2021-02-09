import 'dart:io';

import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/modal/personal_detail.dart';
import 'package:accurate_doctor/modal/user_detail.dart';
import 'package:accurate_doctor/navigation/NavigationPage.dart';
import 'package:accurate_doctor/provider/localDb.dart';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:accurate_doctor/widget/loading_screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  int pageIndex = 0;
  AjaxCall http;
  PageController pageController = PageController(initialPage: 0);
  bool isLoading = true;
  UserDetail userDetail;

  void InitConfiguration() {
    Configuration.width = MediaQuery.of(context).size.width;
    Configuration.height = MediaQuery.of(context).size.height;
    Configuration.isAndroid = Platform.isAndroid;
  }

  void getNotificationDetail() {
    if (userDetail.UserId != null) {
      this.http.post("Common/GetPendingAppointmentDetails",
          {"DocId": userDetail.UserId}).then((value) {
        if (value != null) {
          List<dynamic> notifications = json.decode(value);
          if (notifications != null && notifications.length > 0) {
            userDetail.notificationCount = notifications.length;
          } else {
            userDetail.notificationCount = 0;
          }
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDetail = UserDetail.instance;
    userDetail.notificationCount = 0;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      http = AjaxCall.getInstance;
      LocalDb db = LocalDb.internal();
      this.InitConfiguration();
      db.initDb().then((value) {
        if (value) {
          print('Checking');
          PersonalDetailModal.userExists().then((value) {
            if (value) {
              print('User exists ID: ${userDetail.UserId}');
              if (userDetail.isDoctor) this.getNotificationDetail();
              Navigator.of(context)
                  .pushReplacementNamed(NavigationPage.Dashboard);
            } else {
              print('User not exists');
              setState(() {
                isLoading = false;
              });
            }
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 40),
                      child: Image.asset(
                        "assets/img/logo.png",
                        width: MediaQuery.of(context).size.width * .5,
                      ),
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            )
          : Stack(
              children: [
                InkWell(
                  onTap: () {
                    this.pageIndex++;
                    if (this.pageIndex <= 3) {
                      this.pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.bounceIn);
                    } else {
                      this.pageIndex = 0;
                      Navigator.of(context)
                          .pushReplacementNamed(NavigationPage.SignIn);
                    }
                  },
                  child: Container(
                    child: PageView(
                      controller: pageController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        OnBoarding(
                          imgpath: "assets/img/On_boarding_screen_3.png",
                          title: 'For Patients',
                          message1: 'The quickest way to get diagnosed and',
                          message2: 'Treated, from the comfort of your home!',
                        ),
                        OnBoarding(
                          imgpath: "assets/img/On_boarding_screen_1.png",
                          title: 'For Doctor',
                          message1:
                              'AccurateDoctor- The fastest way to see your',
                          message2: 'patients virtually',
                        ),
                        OnBoarding(
                          imgpath: "assets/img/On_boarding_screen_2.png",
                          title: 'For Partners',
                          message1:
                              'To provide quality telehealth services to all ',
                          message2: 'including most secluded areas',
                        ),
                        OnBoarding(
                          imgpath: "assets/img/On_boarding_screen_4.png",
                          title: 'Covid-19 healthcare service',
                          message1: 'Extend access to your healthcare service',
                          message2: 'amid covid-19 with AccurateDoctor',
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/img/onboarding_bg.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(NavigationPage.SignIn);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                        left: 20,
                        right: 20,
                      ),
                      child: const Text(
                        'Skip',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  top: 40,
                  right: 10,
                )
              ],
            ),
    );
  }
}
