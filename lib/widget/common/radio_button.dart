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
    _value = RadioOption.off;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(this.widget.title),
        leading: InkWell(
          onTap: () {
            var flag = _value == RadioOption.on ? true : false;
            setState(() {
              _value =
                  _value == RadioOption.on ? RadioOption.off : RadioOption.on;
            });
            widget.privacyPolicyStatus(flag);
          },
          child: Radio(
            value: RadioOption.off,
            groupValue: _value,
          ),
        ),
      ),
    );
  }
}
