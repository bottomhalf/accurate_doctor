import 'package:flutter/material.dart';

class HeaderNavBar extends StatefulWidget {
  final String selectedKey;
  final List<String> values;

  HeaderNavBar(this.selectedKey, this.values);

  @override
  _HeaderNavBarState createState() => _HeaderNavBarState();
}

class _HeaderNavBarState extends State<HeaderNavBar> {
  String selectedValue;
  List<String> itemValues;

  @override
  Widget build(BuildContext context) {
    selectedValue = widget.selectedKey;
    itemValues = widget.values;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 6,
      ),
      child: Row(
        children: [
          Container(
            height: 25,
            padding: EdgeInsets.only(
              left: 6,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedValue,
                icon: Icon(Icons.keyboard_arrow_down),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 0,
                    ),
                  ),
                ),
                onChanged: (String newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                },
                items: itemValues.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
