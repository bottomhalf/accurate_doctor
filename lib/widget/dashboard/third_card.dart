import '../../modal/Configuration.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ThirdCard extends StatelessWidget {
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
              'My Fitness',
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
                      child: CircularPercentIndicator(
                        radius: 50.0,
                        lineWidth: 5.0,
                        percent: 0.0,
                        footer: Text("21.99 bmi"),
                        center: Image.asset("assets/img/Group_1022.png"),
                        backgroundColor: Colors.white,
                        progressColor: Colors.green,
                      ),
                    ),
                    Expanded(
                      child: CircularPercentIndicator(
                        radius: 50.0,
                        lineWidth: 5.0,
                        percent: 0.0,
                        footer: Text("77 bpm"),
                        center: Image.asset("assets/img/Group_1021.png"),
                        backgroundColor: Colors.white70,
                        progressColor: Colors.deepPurple,
                      ),
                    ),
                    Expanded(
                      child: CircularPercentIndicator(
                        radius: 50.0,
                        lineWidth: 5.0,
                        percent: 0.0,
                        footer: Text("135 mg/dl"),
                        center: Image.asset("assets/img/Group_1020.png"),
                        backgroundColor: Colors.white,
                        progressColor: Colors.lightBlueAccent,
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
