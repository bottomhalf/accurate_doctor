import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:flutter/material.dart';

enum VideoConsultation { Yes, No }

class Profession extends StatefulWidget {
  @override
  _ProfessionState createState() => _ProfessionState();
}

class _ProfessionState extends State<Profession> {
  final _form = GlobalKey<FormState>();
  final _membership = FocusNode();
  final _recognition = FocusNode();
  final _videoconsultation = FocusNode();
  final _hospitalLocation = FocusNode();
  TextEditingController selectedDate = TextEditingController();
  TextEditingController selectedGender = TextEditingController();

  VideoConsultation _videoConsultationState = VideoConsultation.No;

  @override
  void dispose() {
    _membership.dispose();
    _recognition.dispose();
    _videoconsultation.dispose();
    _hospitalLocation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: Configuration.fieldGap * 2,
                ),
                child: Text(
                  'Membership',
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
                    labelText: 'Membership',
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
                  focusNode: _membership,
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(this._recognition);
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
                  'Recognition',
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
                    labelText: 'Recognition',
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
                  focusNode: _recognition,
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context)
                        .requestFocus(this._videoconsultation);
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
                padding: EdgeInsets.only(
                  top: Configuration.fieldGap * 2,
                ),
                child: Text(
                  'Video Consultation Fee',
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
                    labelText: 'Video Consultation Fee',
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
                  focusNode: _hospitalLocation,
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(this._hospitalLocation);
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
                  'Hospital Location',
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
                    labelText: 'Hospital Location',
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
                  focusNode: _hospitalLocation,
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
    );
  }
}
