import 'package:accurate_doctor/navigation/NavigationPage.dart';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:flutter/material.dart';
// import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:fluttertoast/fluttertoast.dart';

class FilterBar extends StatefulWidget {
  String defaultText;
  Function searchCurrentItem;
  FilterBar({this.defaultText, this.searchCurrentItem});

  @override
  _FilterBarState createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  //GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  List<dynamic> result = [];
  String currentText = "";
  AjaxCall http;
  List<dynamic> suggestions = [];
  final _searchFilterController = TextEditingController();
  final TextEditingController _typeAheadController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      suggestions = [];
    });
    http = AjaxCall.getInstance;
  }

  Future<List<dynamic>> getFilteredResult(String text) async {
    print('Searching for: $text');
    this.suggestions = [];
    if (text.length > 0) {
      await http.post("AppointmentsCommon/GetSpecialityWithString_1_4",
          {"strspecialityName": text, "intCityId": 2}).then((value) {
        if (value != null) {
          result = json.decode(value);
          int index = 0;
          while (index < result.length) {
            this.suggestions.add(result.elementAt(index));
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
    return suggestions;
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
            /*child: SimpleAutoCompleteTextField(
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
              clearOnSubmit: true,
              textSubmitted: (text) {
                _searchFilterController.text = text;
                */ /*Navigator.of(context).pushNamed(NavigationPage.Appointment,
                    arguments: _searchFilterController.text);*/ /*
              },
            ),*/

            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: this._searchFilterController,
                decoration: InputDecoration(
                  hintText: 'Seach by Hospital/Doctor',
                  contentPadding: EdgeInsets.only(
                    bottom: 12,
                  ),
                  border: InputBorder.none,
                ),
              ),
              suggestionsCallback: (pattern) async {
                return await getFilteredResult(pattern);
              },
              hideOnEmpty: true,
              itemBuilder: (context, suggestion) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  child: Text(
                    suggestion['strSpecialityName'],
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 16,
                    ),
                  ),
                );
              },
              onSuggestionSelected: (value) {
                this._searchFilterController.text = value['strSpecialityName'];
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
            setState(() {
              _searchFilterController.text = _searchFilterController.text;
            });

            if (ModalRoute.of(context).settings.name !=
                NavigationPage.Appointment) {
              Navigator.of(context).pushNamed(NavigationPage.Appointment,
                  arguments: _searchFilterController.text);
            } else {
              widget.searchCurrentItem(this._searchFilterController.text);
            }
          },
        )
      ],
    ));
  }
}
