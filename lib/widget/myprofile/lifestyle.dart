import '../common/inputformfield.dart';
import 'package:flutter/material.dart';

class LifeStyle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 20,
            ),
            height: 80,
            child: Center(
              child: Text(
                'Add Detail',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blueGrey,
                ),
              ),
              child: Text(
                'Smoking Habits',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
          InkWell(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blueGrey,
                ),
              ),
              child: Text(
                'Alcohol Consumption',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
          InkWell(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blueGrey,
                ),
              ),
              child: Text(
                'Activity Level',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
          InkWell(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blueGrey,
                ),
              ),
              child: Text(
                'Food Preference',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
          InkWell(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blueGrey,
                ),
              ),
              child: Text(
                'Occupation',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
