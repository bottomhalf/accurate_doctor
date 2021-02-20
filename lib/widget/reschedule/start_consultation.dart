import 'package:flutter_icons/flutter_icons.dart';

import '../../widget/reschedule/saveState.dart';
import '../../modal/RescheduleDataModal.dart';
import '../../widget/common/circular_wizard_box.dart';

import '../../modal/Configuration.dart';
import 'package:flutter/material.dart';

class StartConsultation extends StatefulWidget {
  Function onSave;
  Function onSaveAndPrint;
  Function MoveTo;
  StartConsultation({
    this.onSave,
    this.onSaveAndPrint,
    this.MoveTo,
  });

  @override
  _StartConsultationState createState() => _StartConsultationState();
}

class _StartConsultationState extends State<StartConsultation> {
  final _form = GlobalKey<FormState>();
  List<dynamic> documentType = [];
  List<dynamic> reports = [];

  @override
  void initState() {
    setState(() {
      this.documentType = [
        {"text": "Select Document Type", "value": -1},
        {"text": "Consultation", "value": 1}
      ];
      this.reports = [
        {"text": "Select Report Type", "value": -1},
        {"text": "Medical Reports", "value": 1},
        {"text": "Lab Reports", "value": 2},
        {"text": "Shoulder Pain", "value": 3},
        {"text": "Back Pain", "value": 4}
      ];
    });

    super.initState();
  }

  final _illnessHistory = FocusNode();

  void _onSave() {
    print('onsave called');
    this.widget.onSave();
  }

  void _onSaveAndPrint() {
    print('onsave called');
    _form.currentState.save();
    this.widget.onSaveAndPrint();
  }

  void _pickFile() {}

  String radioButtonItem = 'ONE';

  int id = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Configuration.height * .50,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Configuration.pagePadding,
              ),
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      initiallyExpanded: true,
                      title: Text(
                        'Chief Complaint & History Of Present illness',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight:
                              Theme.of(context).textTheme.headline2.fontWeight,
                        ),
                      ),
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: Configuration.fieldGap),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Chief Complaint',
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
                            keyboardType: TextInputType.text,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_illnessHistory);
                            },
                            validator: (value) {
                              return null;
                            },
                            onSaved: (value) {
                              print(value);
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: Configuration.fieldGap,
                            bottom: Configuration.fieldGap,
                          ),
                          child: TextFormField(
                            maxLines: 4,
                            decoration: InputDecoration(
                              labelText: 'History of present illness',
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
                            focusNode: _illnessHistory,
                            keyboardType: TextInputType.text,
                            onFieldSubmitted: (_) {},
                            validator: (value) {
                              return null;
                            },
                            onSaved: (value) {
                              print(value);
                            },
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: Text(
                        'Physical Examination Treatment Plan',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight:
                              Theme.of(context).textTheme.headline2.fontWeight,
                        ),
                      ),
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: Configuration.fieldGap,
                            bottom: Configuration.fieldGap,
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Physical Examination',
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
                            focusNode: _illnessHistory,
                            keyboardType: TextInputType.text,
                            onFieldSubmitted: (_) {},
                            validator: (value) {
                              return null;
                            },
                            onSaved: (value) {
                              print(value);
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: Configuration.fieldGap,
                            bottom: Configuration.fieldGap,
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Treatment Plan',
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
                            focusNode: _illnessHistory,
                            keyboardType: TextInputType.text,
                            onFieldSubmitted: (_) {},
                            validator: (value) {
                              return null;
                            },
                            onSaved: (value) {
                              print(value);
                            },
                          ),
                        ),
                      ],
                    ),
                    /* ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: Text(
                        'Vitals',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight:
                              Theme.of(context).textTheme.headline2.fontWeight,
                        ),
                      ),
                      children: [
                        Text('sample - 1'),
                        Text('sample - 1'),
                        Text('sample - 1'),
                      ],
                    ),*/
                    /* ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: Text(
                        'Diagnosis',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight:
                              Theme.of(context).textTheme.headline2.fontWeight,
                        ),
                      ),
                      children: [
                        Text('sample - 1'),
                        Text('sample - 1'),
                        Text('sample - 1'),
                      ],
                    ),*/
                    ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: Text(
                        'Follow up',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight:
                              Theme.of(context).textTheme.headline2.fontWeight,
                        ),
                      ),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                              value: 1,
                              groupValue: id,
                              onChanged: (val) {
                                setState(() {
                                  radioButtonItem = 'One Week';
                                  id = 1;
                                });
                              },
                            ),
                            const Text(
                              'One Week',
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                            Radio(
                              value: 2,
                              groupValue: id,
                              onChanged: (val) {
                                setState(() {
                                  radioButtonItem = '15 Days';
                                  id = 2;
                                });
                              },
                            ),
                            const Text(
                              '15 Days',
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                              value: 3,
                              groupValue: id,
                              onChanged: (val) {
                                setState(() {
                                  radioButtonItem = 'One Month';
                                  id = 3;
                                });
                              },
                            ),
                            const Text(
                              'One Month',
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                            Radio(
                              value: 4,
                              groupValue: id,
                              onChanged: (val) {
                                setState(() {
                                  radioButtonItem = 'Specific Date';
                                  id = 4;
                                });
                              },
                            ),
                            const Text(
                              'Specific Date',
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      onExpansionChanged: (bool status) {
                        print('Changed State: $status');
                      },
                      title: Text(
                        'Choose File',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight:
                              Theme.of(context).textTheme.headline2.fontWeight,
                        ),
                      ),
                      children: [
                        Container(
                          height: 48,
                          margin: EdgeInsets.only(top: Configuration.fieldGap),
                          child: DropdownButtonFormField<dynamic>(
                            decoration: InputDecoration(
                              isDense: true,
                              prefixIcon: Icon(
                                FontAwesome.file_word_o,
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
                            value: -1,
                            onTap: () {
                              FocusScope.of(context).unfocus();
                            },
                            onChanged: (value) {
                              //FocusScope.of(context).requestFocus(_speciality);
                            },
                            items: this
                                .documentType
                                .map((e) => DropdownMenuItem(
                                      child: Text(
                                        e['text'],
                                        style: TextStyle(
                                          color: e['value'] == -1
                                              ? Theme.of(context).dividerColor
                                              : Colors.black,
                                        ),
                                      ),
                                      value: e['value'],
                                    ))
                                .toList(),
                            validator: (value) {
                              return null;
                            },
                            onSaved: (value) {
                              //FocusScope.of(context).requestFocus(_speciality);
                            },
                          ),
                        ),
                        Container(
                          height: 48,
                          margin: EdgeInsets.only(
                            top: Configuration.fieldGap,
                          ),
                          child: DropdownButtonFormField<dynamic>(
                            decoration: InputDecoration(
                              isDense: true,
                              prefixIcon: Icon(
                                FontAwesome.file_image_o,
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
                            value: -1,
                            onTap: () {
                              FocusScope.of(context).unfocus();
                            },
                            onChanged: (value) {
                              //FocusScope.of(context).requestFocus(_speciality);
                            },
                            items: this
                                .reports
                                .map((e) => DropdownMenuItem(
                                      child: Text(
                                        e['text'],
                                        style: TextStyle(
                                          color: e['value'] == -1
                                              ? Theme.of(context).dividerColor
                                              : Colors.black,
                                        ),
                                      ),
                                      value: e['value'],
                                    ))
                                .toList(),
                            validator: (value) {
                              return null;
                            },
                            onSaved: (value) {
                              //FocusScope.of(context).requestFocus(_speciality);
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: Configuration.fieldGap,
                            bottom: Configuration.fieldGap,
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Enter Doctor Name',
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
                            focusNode: _illnessHistory,
                            keyboardType: TextInputType.text,
                            onFieldSubmitted: (_) {},
                            validator: (value) {
                              return null;
                            },
                            onSaved: (value) {
                              print(value);
                            },
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            top: Configuration.fieldGap,
                            bottom: Configuration.fieldGap,
                          ),
                          child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            textColor: Colors.white,
                            child: const Text(
                              'Browser file',
                            ),
                            padding: EdgeInsets.only(
                              top: 15,
                              bottom: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: BorderSide(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            onPressed: _pickFile,
                          ),
                        ),
                      ],
                    ),
                    SaveState(
                      onSave: _onSave,
                      onSaveAndPrint: _onSaveAndPrint,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
