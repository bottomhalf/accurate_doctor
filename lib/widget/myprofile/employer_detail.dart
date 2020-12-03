import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:flutter/material.dart';

class EmployerDetail extends StatefulWidget {
  dynamic personalDetail;
  EmployerDetail({this.personalDetail});
  @override
  _EmployerDetailState createState() => _EmployerDetailState();
}

class _EmployerDetailState extends State<EmployerDetail> {
  final _form = GlobalKey<FormState>();
  bool isSubmiting = false;
  bool isLoading = false;
  AjaxCall http;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> getDatePicker() async {
    final selectedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 100 * 365)),
      lastDate: DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          )
        : Container(
            child: Form(
              key: _form,
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: Configuration.fieldGap),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Insurance Company License No.#',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Insurance Company License No.#',
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
                          initialValue: '',
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (_) {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Full name is madatory field';
                            }
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Configuration.fieldGap),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Policy Number',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Policy Number',
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
                          initialValue: '',
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (_) {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Full name is madatory field';
                            }
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Configuration.fieldGap),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Policy Type',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Policy Type',
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
                          initialValue: '',
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (_) {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Policy Type is madatory field';
                            }
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Configuration.fieldGap),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Policy Id',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Policy Id',
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
                          initialValue: '',
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (_) {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Policy Id is madatory field';
                            }
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Configuration.fieldGap),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Secondary Policy Indicator',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Secondary Policy Indicator',
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
                          initialValue: '',
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (_) {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Madatory field';
                            }
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Configuration.fieldGap),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Insurance Company Name',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Insurance Company Name',
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
                          initialValue: '',
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (_) {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Madatory field';
                            }
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Configuration.fieldGap),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Member Name',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Member Name',
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
                          initialValue: '',
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (_) {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Madatory field';
                            }
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Configuration.fieldGap),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Health Plan Type',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Health Plan Type',
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
                          initialValue: '',
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (_) {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Madatory field';
                            }
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Configuration.fieldGap),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Source of Payment',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Source of Payment',
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
                          initialValue: '',
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (_) {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Madatory field';
                            }
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Configuration.fieldGap),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Secondary Policy Id',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Secondary Policy Id',
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
                          initialValue: '',
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (_) {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Madatory field';
                            }
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Configuration.fieldGap),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: RaisedButton(
                      onPressed: () {},
                      color: Theme.of(context).accentColor,
                      child: isSubmiting
                          ? Center(
                              child: Container(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                            )
                          : Text(
                              'Update',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
