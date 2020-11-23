import 'package:accurate_doctor/navigation/NavigationPage.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../modal/Configuration.dart';
import 'package:flutter/material.dart';

class FirstCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            transform: Matrix4.translationValues(0, 16, 0),
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 0,
            ),
            alignment: Alignment.bottomLeft,
            child: Text(
              'Upcoming Appointment',
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
              top: 20,
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 25.0,
                  spreadRadius: -35,
                  color: Configuration.ColorFromHex('#6E4AFA'),
                ),
              ],
            ),
            width: double.infinity,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                FontAwesome.video_camera,
                                color: Colors.cyan,
                                size: Configuration.width * .05,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    child: const Text(
                                      'Start with Dr. Divya',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '02:00PM, 09/12/2020',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.event_note,
                                color: Theme.of(context).accentColor,
                                size: Configuration.width * .05,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              FittedBox(
                                child: const Text(
                                  'Reschedule',
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Theme.of(context).accentColor,
                                size: Configuration.width * .05,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    child: const Text(
                                      'Start with Dr. Divya',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '11:00AM, 10/11/2020',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.event_note,
                                color: Theme.of(context).accentColor,
                                size: Configuration.width * .05,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              FittedBox(
                                child: const Text(
                                  'Reschedule',
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(NavigationPage.CaregiverCalendar);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 10,
                        ),
                        width: double.infinity,
                        alignment: Alignment.bottomRight,
                        child: const Text(
                          'View ALL',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
