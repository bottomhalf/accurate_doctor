import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/navigation/Constants.dart';
import 'package:flutter/material.dart';

enum Gender { male, female, other }

class GenderModal extends StatefulWidget {
  Function handleGender;
  GenderModal(this.handleGender);

  @override
  _GenderModalState createState() => _GenderModalState();
}

class _GenderModalState extends State<GenderModal> {
  Gender _character;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Configuration.height * .4,
      child: Column(
        children: [
          Text('Please select your gender'),
          ListTile(
            title: const Text("Male"),
            leading: Radio(
              value: Gender.male,
              groupValue: _character,
              onChanged: (Gender value) {
                widget.handleGender(MappedGender.Male.index);
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Female'),
            leading: Radio(
              value: Gender.female,
              groupValue: _character,
              onChanged: (Gender value) {
                widget.handleGender(MappedGender.Female.index);
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Other'),
            leading: Radio(
              value: Gender.other,
              groupValue: _character,
              onChanged: (Gender value) {
                widget.handleGender(MappedGender.Other.index);
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
