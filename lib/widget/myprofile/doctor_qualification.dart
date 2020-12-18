import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DoctorQualification extends StatefulWidget {
  @override
  _DoctorQualificationState createState() => _DoctorQualificationState();
}

class _DoctorQualificationState extends State<DoctorQualification> {
  final _form = GlobalKey<FormState>();
  final _qulification = FocusNode();
  final _specility = FocusNode();
  final _exprience = FocusNode();
  final _mcino = FocusNode();
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
                  'Qualification',
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
                    labelText: 'Qualification',
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
                  'Speciality',
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
                    labelText: 'Speciality',
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
                  'Experience',
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
                    labelText: 'Experience',
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
                  'MCI No.',
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
                    labelText: 'MCI No.',
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
