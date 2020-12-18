import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/widget/common/expandable_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Payments extends StatelessWidget {
  Function onSave;
  Function onSaveAndPrint;
  Function MoveTo;
  Payments({this.onSave, this.onSaveAndPrint, this.MoveTo});

  final _form = GlobalKey<FormState>();
  final _mcino = FocusNode();
  TextEditingController selectedDate = TextEditingController();
  TextEditingController selectedGender = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Configuration.height * .6,
          child: Form(
            key: _form,
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: Configuration.fieldGap * 2,
                  ),
                  child: Text(
                    'UHID',
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
                      labelText: 'Select',
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
                    'Enter UHID',
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
                      labelText: 'Enter Text',
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
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: Configuration.fieldGap * 2,
                    bottom: 10,
                  ),
                  child: Text(
                    'Select Pending Invoice',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  child: ExpandableCard(
                    body: Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Total Bill Amount: ',
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text('-'),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Paid Amount: ',
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text('-'),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Amount Due: ',
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text('-'),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    cardTitle: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text('Invoice Type: '),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Pending invoice',
                                      style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Text('Date:'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '12th Dec, 2020 09:00 AM',
                                      style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Icon(FontAwesome.caret_down),
                            ),
                          )
                        ],
                      ),
                    ),
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
                            'Create Payment',
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
