import 'dart:convert';
import '../services/ajax_call.dart';
import '../widget/book_appointment/about_and_rating.dart';
import '../modal/Configuration.dart';
import '../navigation/Constants.dart';
import 'package:flutter/widgets.dart';
import '../widget/common/bottom_navigation.dart';
import '../widget/common/page_appbar.dart';
import 'package:flutter/material.dart';

class DoctorProfile extends StatefulWidget {
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  int userId;
  AjaxCall http;
  var userData;
  bool isDataAvailable = true;

  void _loadUserData() async {
    setState(() {
      isDataAvailable = true;
    });
    if (http == null) {
      http = AjaxCall.getInstance;
    }

    final data =
        await http.get('AppointmentsCommon/GetDoctorDetails/${this.userId}');
    if (data != null) {
      print(data);
      List<dynamic> result = json.decode(data);
      if (result != null && result.length > 0) {
        userData = result[0];
      }
    }

    setState(() {
      isDataAvailable = false;
    });
  }

  @override
  void didChangeDependencies() {
    userId = ModalRoute.of(context).settings.arguments as int;
    if (userId != null) {
      _loadUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return isDataAvailable
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: PageAppBar(pageTitle: 'Profile'),
            body: Container(
              padding: EdgeInsets.all(Configuration.pagePadding),
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: http.getImage(userData['strDoctorImage']),
                      radius: 50,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      userData['strDoctorName'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      userData['strDoctorSpecialityName'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Center(
                            child: Text(
                              '2k',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          subtitle: Center(
                            child: Text('PATIENTS'),
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 20,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: ListTile(
                          title: Center(
                            child: Text(
                              '5',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          subtitle: Center(
                            child: Text('EXPRIENCE'),
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 20,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: ListTile(
                          title: Center(
                            child: Text(
                              '4.5',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          subtitle: Center(
                            child: Text('RATING'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: AboutAndRating(
                        aboutMessage:
                            'A request was made to pop this route. If the route can handle it internally (e.g. because it has its own stack of internal state) then return false, otherwise return true (by returning the value of calling super.didPop).',
                        rating: 4.5),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigation(Tabs.TeleHealth.index),
          );
  }
}
