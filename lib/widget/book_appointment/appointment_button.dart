import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppointmentButton extends StatelessWidget {
  final String text;
  final int index;
  final double minWidth;
  Color bgColor;
  Color textColor;
  final EdgeInsetsGeometry paddingGeometry;
  final EdgeInsetsGeometry marginGeometry;
  Color borderColor;
  bool isEnabled;
  Function onSelected;
  bool isAvaible;

  AppointmentButton({
    @required this.text,
    @required this.bgColor,
    @required this.textColor,
    this.index,
    this.marginGeometry,
    this.paddingGeometry,
    this.minWidth,
    this.borderColor,
    @required this.isEnabled,
    this.onSelected,
    this.isAvaible,
  }) {
    if (this.borderColor == null) this.borderColor = Colors.blueGrey;
  }

  void selectCurrent() {
    if (this.isAvaible)
      this.onSelected(index);
    else {
      Fluttertoast.showToast(msg: 'Slot not available');
    }
  }

  Color getColor(BuildContext context) {
    Color color = Configuration.ColorFromHex('#F7F7F7');
    this.textColor = Configuration.ColorFromHex('#B9ABAB');
    this.bgColor = Configuration.ColorFromHex('#D5CCCC');
    if (this.isAvaible) {
      if (this.isEnabled) {
        color = Theme.of(context).accentColor;
        this.textColor = Colors.white;
        this.bgColor = Theme.of(context).accentColor;
      } else {
        color = Colors.white;
        this.textColor = Theme.of(context).dividerColor;
        this.bgColor = Theme.of(context).accentColor;
      }
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        this.selectCurrent();
      },
      child: Container(
        decoration: BoxDecoration(
          color: getColor(context),
          border: Border.all(
            color: this.bgColor,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: this.paddingGeometry,
        margin: this.marginGeometry,
        child: Text(
          this.text,
          style: TextStyle(
            color: this.textColor,
          ),
        ),
      ),
    );
  }
}
