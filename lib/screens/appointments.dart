import 'dart:convert';
import '../services/ajax_call.dart';
import '../navigation/Constants.dart';
import '../navigation/NavigationPage.dart';
import '../provider/appointment_details.dart';
import 'package:flutter/widgets.dart';

import '../modal/Configuration.dart';
import '../widget/common/bottom_navigation.dart';
import '../widget/dashboard/app_bar.dart';
import '../widget/drawer/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Appointment extends StatefulWidget {
  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  List<dynamic> appointmentDetails = [];
  bool isLoadingCompleted = true;
  String searchString = '';
  String args;
  AjaxCall http;

  Future<void> showInvalidMesssage(String title, String message) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 25,
            color: Theme.of(context).accentColor,
          ),
        ),
        content: Text(message),
        actions: [
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> loadData(String searchValue) async {
    if (searchValue.isNotEmpty) {
      setState(() {
        isLoadingCompleted = true;
      });
      FocusScope.of(context).unfocus();
      http = AjaxCall.getInstance;
      var response = await http.post(
        'AppointmentsCommon/GetDoctorsWithSearchCriteriaforGooglemap_1_4',
        {
          "dayPart": "Morning",
          "strPreferredDate": null,
          "intLocationId": null,
          "intSpecialityId": null,
          "intCityId": null,
          "strSpeciality": searchValue,
          "strlongitude": null,
          "strlatitude": null,
          "intMinDisatnce": null,
          "intMaxDisatnce": null,
          "intMinCost": 0,
          "intMaxCost": 99999,
          "intMinExp": null,
          "intMaxExp": 30,
          "FromTime": null,
          "ToTime": null,
          "pageno": 1,
          "fldSponsorCookie": null,
          "fldEmpanelledCookie": null,
          "fldElseCookie": null,
          "intUserId": 0,
          "intSymptomId": 0,
          "intLanguageId": 0,
          "strGender": "M"
        },
      );

      if (response != null) {
        //print(response);
        //var result = json.decode(response);
        //print('Doc urs' + result[0]['strSpeciality']);
        setState(() {
          appointmentDetails = json.decode(response);
          searchString = searchValue;
          isLoadingCompleted = false;
        });
        //print('Doc urs' + appointmentDetails[0]['strSpeciality']);
      } else {
        showInvalidMesssage('Appointment status',
                'Unable to get the result please try again else contact to admin.')
            .then((value) {
          setState(() {
            appointmentDetails = [];
            isLoadingCompleted = false;
          });
        });
      }
    } else {
      print('empty search data');
      setState(() {
        appointmentDetails = [];
        isLoadingCompleted = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      args = ModalRoute.of(context).settings?.arguments as String;
      print('Filter data: $args');
      if (args.isNotEmpty) {
        setState(() {
          isLoadingCompleted = true;
        });
        this.loadData(args);
      } else {
        setState(() {
          isLoadingCompleted = true;
        });
        this.loadData('');
      }
    });
  }

  Future<void> _pullRefreshedData() async {
    this.appointmentDetails = [];
    await loadData(this.searchString);
  }

  Widget _getImage(String imageUrl) {
    CachedNetworkImage image;
    try {
      image = CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Image.network(
            "http://imobicloud1.healthygx.com/Images/users/83588-1593068015553_3-512.png"),
      );

      return image;
    } catch (e) {
      return Image.network(
          "http://imobicloud1.healthygx.com/Images/users/83588-1593068015553_3-512.png");
    }
  }

  void fetchData(String searchValue) {
    if (searchValue != null && searchValue.isNotEmpty) {
      setState(() {
        isLoadingCompleted = true;
      });
      this.loadData(searchValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(
        appBarHeader: 'Appointment',
        searchResult: fetchData,
      ),
      body: RefreshIndicator(
        onRefresh: _pullRefreshedData,
        child: isLoadingCompleted
            ? Center(
                child: CircularProgressIndicator(),
              )
            : this.appointmentDetails.length == 0
                ? Center(
                    child: Container(
                      width: Configuration.width * .6,
                      child: Text(
                        'No data found, please use search to filter.',
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(Configuration.pagePadding),
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: appointmentDetails.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Configuration.pagePadding,
                              vertical: 10,
                            ),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        NavigationPage.DoctorProfile,
                                        arguments: appointmentDetails
                                            .elementAt(index)['intUserId']);
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: ListTile(
                                          contentPadding: EdgeInsets.all(0),
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            child: _getImage(
                                                appointmentDetails.elementAt(
                                                    index)['strImagePath']),
                                          ),
                                          title: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    appointmentDetails
                                                            .elementAt(index)[
                                                        'strDoctorName'],
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                              ),
                                              Text(
                                                appointmentDetails.elementAt(
                                                    index)['strSpeciality'],
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .dividerColor,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                '${appointmentDetails.elementAt(index)['strDoctorExp']} exprience',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                'Madhpur',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .dividerColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              NavigationPage.BookAppointment,
                                              arguments:
                                                  appointmentDetails.elementAt(
                                                      index)['intUserId']);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(12),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color:
                                                  Theme.of(context).accentColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            'Tele Consultation',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                          padding: EdgeInsets.all(12),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Walk in Visit',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor),
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color:
                                                  Theme.of(context).accentColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
      ),
      //drawer: AppDrawer(),
      bottomNavigationBar: BottomNavigation(Tabs.TeleHealth.index),
    );
  }
}
