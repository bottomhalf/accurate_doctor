import '../widget/common/inputformfield.dart';
import 'package:flutter/material.dart';

class OTPVarification extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final _emailSecondValue = FocusNode();
  final _emailThirdValue = FocusNode();
  final _emailForthValue = FocusNode();

  final _mobileSecondValue = FocusNode();
  final _mobileThirdValue = FocusNode();
  final _mobileForthValue = FocusNode();

  final double _fieldGap = 12;
  bool privacyPolicyFlag = false;
  double pageHeight = 0;
  double boxSize = 50;

  void _varifyOTP() {}

  @override
  Widget build(BuildContext context) {
    pageHeight = MediaQuery.of(context).size.height - 10;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
          bottom: 10,
        ),
        child: Form(
          key: _form,
          child: Container(
            height: pageHeight,
            alignment: Alignment.center,
            width: double.infinity,
            child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Accurate Doctor',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '(Logo required)',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 2 * _fieldGap,
                ),
                Text(
                  'Enter Email OTP',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: boxSize,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: '',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_emailSecondValue);
                        },
                        validator: (value) {
                          return null;
                        },
                        onSaved: (value) {},
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: boxSize,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: '',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_emailSecondValue);
                        },
                        validator: (value) {
                          return null;
                        },
                        onSaved: (value) {},
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: boxSize,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: '',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_emailSecondValue);
                        },
                        validator: (value) {
                          return null;
                        },
                        onSaved: (value) {},
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: boxSize,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: '',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_emailSecondValue);
                        },
                        validator: (value) {
                          return null;
                        },
                        onSaved: (value) {},
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Enter Mobile OTP',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: boxSize,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: '',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_emailSecondValue);
                        },
                        validator: (value) {
                          return null;
                        },
                        onSaved: (value) {},
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: boxSize,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: '',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_emailSecondValue);
                        },
                        validator: (value) {
                          return null;
                        },
                        onSaved: (value) {},
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: boxSize,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: '',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_emailSecondValue);
                        },
                        validator: (value) {
                          return null;
                        },
                        onSaved: (value) {},
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: boxSize,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: '',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_emailSecondValue);
                        },
                        validator: (value) {
                          return null;
                        },
                        onSaved: (value) {},
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: _fieldGap,
                ),
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                  child: const Text(
                    'Verify',
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
                  onPressed: _varifyOTP,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
