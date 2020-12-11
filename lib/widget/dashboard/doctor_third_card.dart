import '../../modal/Configuration.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DoctorThirdCard extends StatelessWidget {
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
              'Total Appointments',
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(
              Configuration.pagePadding,
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
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              child: Center(
                                child: Text(
                                  '120',
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              radius: 25,
                              backgroundColor:
                                  Configuration.ColorFromHex('#9de7fa'),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            FittedBox(
                              child: Center(
                                child: Text(
                                  'Appointments',
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              child: Center(
                                child: Text(
                                  '80',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              radius: 25,
                              backgroundColor:
                                  Configuration.ColorFromHex('#9de7fa'),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            FittedBox(
                              child: Center(
                                child: Text(
                                  'Rescheduled',
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              child: Center(
                                child: Text(
                                  '70',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              radius: 25,
                              backgroundColor:
                                  Configuration.ColorFromHex('#9de7fa'),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            FittedBox(
                              child: Center(
                                child: Text(
                                  'Cancelled',
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              child: Center(
                                child: Text(
                                  '50',
                                  style: TextStyle(
                                    color: Colors.orangeAccent,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              radius: 25,
                              backgroundColor:
                                  Configuration.ColorFromHex('#9de7fa'),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            FittedBox(
                              child: Center(
                                child: Text(
                                  'Booked',
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
