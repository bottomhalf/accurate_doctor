import 'package:flutter/material.dart';

enum RadioOption { on, off }

class RadioButton extends StatefulWidget {
  final String title;
  final Function privacyPolicyStatus;

  RadioButton({this.title, this.privacyPolicyStatus});

  @override
  _RadioButtonState createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  RadioOption _value;
  RadioOption _selectedValue;

  @override
  void initState() {
    _value = RadioOption.on;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(this.widget.title),
        leading: Radio(
          value: RadioOption.on,
          groupValue: _value,
          toggleable: true,
          onChanged: (RadioOption val) {
            setState(() {
              _value = val;
            });
            widget.privacyPolicyStatus(_value == RadioOption.on ? true : false);
          },
        ),
      ),
    );
  }
}
