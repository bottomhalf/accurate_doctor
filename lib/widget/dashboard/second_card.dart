import '../../modal/Configuration.dart';
import 'package:accurate_doctor/navigation/NavigationPage.dart';
import 'package:flutter/material.dart';

class SecondCard extends StatelessWidget {
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
              'Book Appointment',
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
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: Row(
                  children: [
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
                              child: Image.asset("assets/img/Group_965.png"),
                              radius: 30,
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Center(
                              child: FittedBox(
                                child: const Text('Tele Consultation'),
                              ),
                            )
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
                              child: Image.asset("assets/img/Group_966.png"),
                              radius: 30,
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Center(
                              child: FittedBox(
                                child: const Text('Walk In'),
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
                              .pushNamed(NavigationPage.SecondOpinion);
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              child: Image.asset("assets/img/Group_1010.png"),
                              radius: 30,
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Center(
                              child: const Text('Second Opinion'),
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
