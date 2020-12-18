import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/modal/user_detail.dart';
import 'package:accurate_doctor/widget/drawer/doctor_menu.dart';

import '../../navigation/NavigationPage.dart';
import '../../widget/drawer/patient_menu.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  UserDetail userDetail;
  AppDrawer() {
    userDetail = UserDetail.instance;
  }

  Widget BuildMenu() {
    print('Is Doctor: ${Configuration.isDoctor}');
    if (Configuration.isDoctor)
      return DoctorMenu();
    else
      return PatientMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: Container(
            child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .2,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Theme.of(context).accentColor,
                    Theme.of(context).textTheme.headline1.color,
                  ],
                ),
                color: Theme.of(context).accentColor,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(NavigationPage.MyProfile);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  maxRadius: 40,
                                  child: Configuration.getImage(
                                      userDetail.imagePath),
                                ),
                                Positioned(
                                  bottom: 5,
                                  left: 15,
                                  width: 100,
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor:
                                        Theme.of(context).accentColor,
                                    child: CircleAvatar(
                                      radius: 9,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.edit,
                                        color: Theme.of(context).accentColor,
                                        size: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Edit profile',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Configuration.isDoctor
                                    ? 'Name'
                                    : 'Patient Name',
                                style: TextStyle(color: Colors.white70),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                '${userDetail.firstName} ${userDetail?.lastName}',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                Configuration.isDoctor
                                    ? 'Provider Id'
                                    : 'Patient Id',
                                style: TextStyle(color: Colors.white70),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                userDetail.uniqueId == 'null'
                                    ? 'NA'
                                    : userDetail.uniqueId,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            this.BuildMenu(),
          ],
        )),
      ),
    );
  }
}
