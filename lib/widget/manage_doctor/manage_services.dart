import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:flutter/material.dart';

enum VideoConsultation { Yes, No }

class ManageServices extends StatefulWidget {
  Function onSave;
  Function onSaveAndPrint;
  Function MoveTo;
  ManageServices({this.onSave, this.onSaveAndPrint, this.MoveTo});

  @override
  _ManageServicesState createState() => _ManageServicesState();
}

class _ManageServicesState extends State<ManageServices> {
  final _form = GlobalKey<FormState>();
  final _qulification = FocusNode();
  final _specility = FocusNode();
  final _exprience = FocusNode();
  final _mcino = FocusNode();
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
                    'Branches',
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
                      labelText: 'Branches',
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
                  margin: EdgeInsets.only(top: Configuration.fieldGap),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Description.',
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
                            'Save',
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
