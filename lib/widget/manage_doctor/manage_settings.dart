import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';

enum VideoConsultation { Yes, No }

class ManageSettings extends StatefulWidget {
  Function onSave;
  Function onSaveAndPrint;
  Function MoveTo;
  ManageSettings({this.onSave, this.onSaveAndPrint, this.MoveTo});

  @override
  _ManageSettingsState createState() => _ManageSettingsState();
}

class _ManageSettingsState extends State<ManageSettings> {
  final _form = GlobalKey<FormState>();
  final _qulification = FocusNode();
  final _specility = FocusNode();
  final _exprience = FocusNode();
  final _mcino = FocusNode();
  final _orderDate = TextEditingController();
  final _scheduleDate = TextEditingController();
  TextEditingController selectedDate = TextEditingController();
  TextEditingController selectedGender = TextEditingController();

  VideoConsultation _videoConsultationState = VideoConsultation.No;

  @override
  void dispose() {
    _qulification.dispose();
    _specility.dispose();
    _exprience.dispose();
    _mcino.dispose();
    super.dispose();
  }

  Future<void> _getDatePicker(BuildContext context, bool isOrderDate) async {
    final selectedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 100 * 365)),
      lastDate: DateTime.now(),
    );

    if (selectedDateTime != null) {
      if (isOrderDate)
        this._orderDate.text =
            DateFormat('MM/dd/yyyy').format(selectedDateTime);
      else
        this._scheduleDate.text =
            DateFormat('MM/dd/yyyy').format(selectedDateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Configuration.height * .6,
          padding: EdgeInsets.all(Configuration.pagePadding),
          child: Form(
            key: _form,
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: Configuration.fieldGap * 2,
                  ),
                  child: Text(
                    'Service Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Configuration.fieldGap),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Service Name',
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    textAlign: TextAlign.start,
                    focusNode: _qulification,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(this._specility);
                    },
                    validator: (value) {
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: Configuration.fieldGap * 2,
                  ),
                  child: Text(
                    'Service Type',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Configuration.fieldGap),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Service Type',
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    textAlign: TextAlign.start,
                    focusNode: _specility,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(this._exprience);
                    },
                    validator: (value) {
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: Configuration.fieldGap * 2,
                  ),
                  child: Text(
                    'Branch Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Configuration.fieldGap),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Branch Name',
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    textAlign: TextAlign.start,
                    focusNode: _exprience,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(this._mcino);
                    },
                    validator: (value) {
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: Configuration.fieldGap * 2,
                  ),
                  child: Text(
                    'Service Mode',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Configuration.fieldGap),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Service Mode.',
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    textAlign: TextAlign.start,
                    focusNode: _mcino,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (_) {},
                    validator: (value) {
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: Configuration.fieldGap * 2,
                  ),
                  child: Text(
                    'Appointment Interval Minutes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Configuration.fieldGap),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Appointment Interval Minutes',
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    textAlign: TextAlign.start,
                    focusNode: _mcino,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (_) {},
                    validator: (value) {
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: Configuration.fieldGap,
                          bottom: Configuration.fieldGap,
                          right: 10,
                        ),
                        child: TextFormField(
                          readOnly: true,
                          onTap: () {
                            this._getDatePicker(context, true);
                          },
                          controller: _orderDate,
                          decoration: InputDecoration(
                            labelText: 'Order date',
                            isDense: true,
                            suffixIcon: IconButton(
                              icon: Icon(FontAwesome.calendar),
                              onPressed: () {},
                              iconSize: Configuration.width * .04,
                              color: Theme.of(context).accentColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                          ),
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (_) {},
                          validator: (value) {
                            if (value == null || value == "")
                              return "Order date is mandatory";
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: Configuration.fieldGap,
                          bottom: Configuration.fieldGap,
                          right: 10,
                        ),
                        child: TextFormField(
                          controller: _scheduleDate,
                          readOnly: true,
                          onTap: () {
                            this._getDatePicker(context, false);
                          },
                          decoration: InputDecoration(
                            labelText: 'Schedule date',
                            isDense: true,
                            suffixIcon: IconButton(
                              icon: Icon(FontAwesome.calendar),
                              onPressed: () {},
                              iconSize: Configuration.width * .04,
                              color: Theme.of(context).accentColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                          ),
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (_) {},
                          validator: (value) {
                            if (value == null || value == "")
                              return "Schedule date is mandatory";
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: Configuration.fieldGap * 2,
                  ),
                  child: Text(
                    'Enable For Video Consultation',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                Container(
                  width: Configuration.width,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(children: [
                          Radio(
                            value: VideoConsultation.Yes,
                            groupValue: _videoConsultationState,
                            onChanged: (VideoConsultation value) {
                              setState(() {
                                _videoConsultationState = value;
                              });
                            },
                          ),
                          Text(
                            'Yes',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ]),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                              value: VideoConsultation.No,
                              groupValue: _videoConsultationState,
                              onChanged: (VideoConsultation value) {
                                setState(() {
                                  _videoConsultationState = value;
                                });
                              },
                            ),
                            Text(
                              'No',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: Configuration.fieldGap * 2,
                  ),
                  child: Text(
                    'Enable For Face To Face Consultation',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                Container(
                  width: Configuration.width,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(children: [
                          Radio(
                            value: VideoConsultation.Yes,
                            groupValue: _videoConsultationState,
                            onChanged: (VideoConsultation value) {
                              setState(() {
                                _videoConsultationState = value;
                              });
                            },
                          ),
                          Text(
                            'Yes',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ]),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                              value: VideoConsultation.No,
                              groupValue: _videoConsultationState,
                              onChanged: (VideoConsultation value) {
                                setState(() {
                                  _videoConsultationState = value;
                                });
                              },
                            ),
                            Text(
                              'No',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Configuration.fieldGap * 2),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                          onPressed: () {},
                          child: Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
