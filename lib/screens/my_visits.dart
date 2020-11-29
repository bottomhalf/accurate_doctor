import 'package:accurate_doctor/modal/user_detail.dart';
import 'package:accurate_doctor/navigation/Constants.dart';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:accurate_doctor/widget/common/bottom_navigation.dart';
import 'package:accurate_doctor/widget/common/page_appbar.dart';
import 'package:accurate_doctor/widget/my_visits/visit_card.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class MyVisit extends StatefulWidget {
  @override
  _MyVisitState createState() => _MyVisitState();
}

class _MyVisitState extends State<MyVisit> {
  AjaxCall http;
  UserDetail userDetail;
  bool isLoading = true;
  List<dynamic> result = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      userDetail = UserDetail.instance;
      http = AjaxCall.getInstance;
      http.post("AppointmentsCommon/GetPatientOrdersDetail", {
        "intPatientId": userDetail.UserId,
        "intServiceTypeId": 0,
        "intStatusId": 0,
        "strOrderDate": null,
        "strScheduleDate": null
      }).then((value) {
        if (value != null) {
          try {
            result = json.decode(value);
          } catch (e) {
            Fluttertoast.showToast(msg: FailtoLoad);
          }
          Fluttertoast.showToast(msg: LoadedSuccessfully);
        } else {
          Fluttertoast.showToast(msg: ServerError);
        }

        setState(() {
          result = result;
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        pageTitle: 'My Visits',
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : DefaultTabController(
              length: 2,
              child: Column(
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints.expand(height: 40),
                    child: TabBar(
                      tabs: [
                        Tab(text: "Active Order"),
                        Tab(text: "Order History"),
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
                      child: TabBarView(children: [
                        Container(
                          child: Container(
                            //padding: EdgeInsets.all(Configuration.pagePadding),
                            child: ListView.builder(
                                itemCount: result.length,
                                itemBuilder: (context, index) {
                                  return VisitCard(
                                    appointmentDetail: result.elementAt(index),
                                  );
                                }),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Container(
                              child: Text('Order history page'),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigation(Tabs.TeleHealth.index),
    );
  }
}
