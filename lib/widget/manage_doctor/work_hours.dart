import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';

class WorkHours extends StatefulWidget {
  Function onSave;
  Function onSaveAndPrint;
  Function MoveTo;
  WorkHours({this.onSave, this.onSaveAndPrint, this.MoveTo});

  @override
  _WorkHoursState createState() => _WorkHoursState();
}

class _WorkHoursState extends State<WorkHours> {
  final _form = GlobalKey<FormState>();
  final _qulification = FocusNode();
  final _specility = FocusNode();
  final _exprience = FocusNode();
  final _mcino = FocusNode();
  final _orderDate = TextEditingController();
  final _scheduleDate = TextEditingController();
  TextEditingController selectedDate = TextEditingController();
  TextEditingController selectedGender = TextEditingController();

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
                Card(
                  child: Container(
                    padding: EdgeInsets.all(Configuration.fieldGap),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Configuration.fieldGap,
                        ),
                        Row(
                          children: [
                            Text(
                              'Week Days - Sunday',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'Week Hours',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
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
                                    labelText: 'From',
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
                                    labelText: 'To',
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
                          margin: EdgeInsets.only(top: Configuration.fieldGap),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Healthygx-Gachibowli Hyderabad',
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
                          margin:
                              EdgeInsets.only(top: Configuration.fieldGap * 2),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: RaisedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Off Work',
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
                                    'Split',
                                    style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  elevation: 4,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
