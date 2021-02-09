import '../../modal/Configuration.dart';
import 'package:accurate_doctor/navigation/NavigationPage.dart';
import 'package:flutter/material.dart';

class DoctorSecondCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            transform: Matrix4.translationValues(0, 16, 0),
            padding: EdgeInsets.symmetric(
              horizontal: Configuration.pagePadding + 5,
              vertical: 0,
            ),
            alignment: Alignment.bottomLeft,
            child: Text(
              'Order & Calendar',
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(Configuration.pagePadding),
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              NavigationPage.Reschedule,
                              arguments: "");
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              child: Image.asset(
                                "assets/img/active_order.png",
                                width: 22,
                              ),
                              radius: 30,
                              backgroundColor:
                                  Configuration.ColorFromHex('#9de7fa'),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            FittedBox(
                              child: Center(
                                child: const Text('Active Orders'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              NavigationPage.Appointment,
                              arguments: "");
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              child: Image.asset(
                                "assets/img/order_history.png",
                                width: 25,
                              ),
                              radius: 30,
                              backgroundColor:
                                  Configuration.ColorFromHex('#9de7fa'),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Center(
                              child: FittedBox(
                                child: const Text('Order History'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(NavigationPage.CaregiverCalendar);
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              child: Image.asset(
                                "assets/img/caregiver.png",
                                width: 25,
                              ),
                              radius: 30,
                              backgroundColor:
                                  Configuration.ColorFromHex('#9de7fa'),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            FittedBox(
                              child: Center(
                                child: const Text('Caregiver Calendar'),
                              ),
                            )
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
