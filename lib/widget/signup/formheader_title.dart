import 'package:flutter/material.dart';

class FormHeaderTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Sign Up',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Please sign up to enter into app',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
