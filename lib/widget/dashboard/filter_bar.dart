import 'package:accurate_doctor/navigation/NavigationPage.dart';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';

class FilterBat extends StatefulWidget {
  String defaultText;
  FilterBat({this.defaultText});

  @override
  _FilterBatState createState() => _FilterBatState();
}

class _FilterBatState extends State<FilterBat> {
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  List<dynamic> result = [];
  String currentText = "";
  AjaxCall http;
  List<String> suggestions = [];
  final _searchFilterController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchFilterController.text = widget.defaultText;
    setState(() {
      suggestions = [];
    });
    http = AjaxCall.getInstance;
  }

  void getFilteredResult(String text) {
    if (text.length > 0) {
      print('SearchString: ${text}');
      http.post("AppointmentsCommon/GetSpecialityWithString_1_4",
          {"strspecialityName": text, "intCityId": 2}).then((value) {
        if (value != null) {
          result = json.decode(value);
          int index = 0;
          while (index < result.length) {
            this.suggestions.add(result.elementAt(index)['strSpecialityName']);
            index++;
          }
          setState(() {
            suggestions = suggestions;
          });
        } else {
          print('No result found');
          Fluttertoast.showToast(msg: 'No result found');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Form(
            child: SimpleAutoCompleteTextField(
              key: key,
              decoration: InputDecoration(
                hintText: 'Seach by Hospital/Doctor',
                isDense: true,
                contentPadding: EdgeInsets.only(
                  top: 0,
                ),
                filled: true,
                border: InputBorder.none,
                fillColor: Colors.white,
              ),
              suggestions: suggestions,
              textChanged: (text) {
                _searchFilterController.text = text;
                getFilteredResult(_searchFilterController.text);
              },
              clearOnSubmit: false,
              textSubmitted: (text) {
                _searchFilterController.text = text;
                /*Navigator.of(context).pushNamed(NavigationPage.Appointment,
                    arguments: _searchFilterController.text);*/
              },
            ),

            /*TextFormField(
                          controller: _searchFilterController,
                          focusNode: widget.isFocused ? _searchBox : null,
                          maxLines: 2,
                          style: TextStyle(
                            height: 1.2,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Seach by Hospital/Doctor',
                            isDense: true,
                            contentPadding: EdgeInsets.only(
                              top: 10,
                            ),
                            filled: true,
                            border: InputBorder.none,
                            fillColor: Colors.white,
                          ),
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (_) {
                            print('submitting');
                            Navigator.of(context).pushNamed(
                                NavigationPage.Appointment,
                                arguments: _searchFilterController.text);
                          },
                        ),*/
          ),
        ),
        IconButton(
          alignment: Alignment.centerRight,
          icon: Icon(
            Icons.search,
            size: 16,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(NavigationPage.Appointment,
                arguments: _searchFilterController.text);
          },
        )
      ],
    ));
  }
}
