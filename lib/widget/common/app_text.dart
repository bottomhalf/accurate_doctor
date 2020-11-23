import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  String message;
  AppText(this.message);
  @override
  Widget build(BuildContext context) {
    return Text(
      this.message,
      style: TextStyle(
        color: Theme.of(context).accentColor,
      ),
    );
  }
}
