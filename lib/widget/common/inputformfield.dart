import 'package:flutter/material.dart';

class BordedInput extends StatelessWidget {
  final String title;
  final Color borderColor;
  final IconData icon;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final double _fieldGap = 12;

  BordedInput(
      {@required this.title,
      this.borderColor,
      this.icon,
      this.focusNode,
      this.nextFocusNode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: _fieldGap),
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: this.borderColor,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: this.title,
          icon: Icon(
            icon,
            color: Theme.of(context).accentColor,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        textAlign: TextAlign.start,
        keyboardType: TextInputType.text,
        focusNode: this.focusNode,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(this.nextFocusNode);
        },
        validator: (value) {
          return null;
        },
        onSaved: (value) {
          print(value);
        },
      ),
    );
  }
}
