import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/modal/user_detail.dart';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class EmployerDetail extends StatefulWidget {
  dynamic personalDetail;
  EmployerDetail({this.personalDetail});
  @override
  _EmployerDetailState createState() => _EmployerDetailState();
}

class _EmployerDetailState extends State<EmployerDetail> {
  final _form = GlobalKey<FormState>();
  bool isSubmiting = false;
  bool isLoading = true;
  AjaxCall http;
  UserDetail userDetail;
  List<dynamic> employerDetail = [];

  @override
  void dispose() {
    employerDetail = null;
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    http = AjaxCall.getInstance;
    userDetail = UserDetail.instance;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      http.post("Registration/GetEmployeeDetails",
          {"intEmployeeId": userDetail.UserId}).then((result) {
        if (result != null) {
          List<dynamic> data = json.decode(result);
          setState(() {
            employerDetail = data;
            isLoading = false;
          });
        } else {
          setState(() {
            employerDetail = null;
            isLoading = false;
          });
          Fluttertoast.showToast(msg: "Fail to get employer detail.");
        }
      });
    });
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

  dynamic getValue(String fieldName) {
    if (this.employerDetail.length > 0) {
      return this.employerDetail[0][fieldName];
    }
    return "";
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
                          'Employee Name',
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
                            labelText: 'Employee Name',
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
                          initialValue: this.getValue('strEmployeeName'),
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (_) {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Employee Name is madatory field';
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
                          'Email Id',
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
                            labelText: 'Email Id',
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
                          initialValue: this.getValue('strEmployeeEmail'),
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (_) {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Email id is madatory field';
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
                          'Mobile No.#',
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
                            labelText: 'Mobile No.#',
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
                          initialValue: this.getValue('strEmployeeContactno'),
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (_) {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Mobile no. is madatory field';
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
                          'Address',
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
                            labelText: 'Address',
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
                          initialValue: this.getValue('strEmployeeAddress'),
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (_) {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Address is madatory field';
                            }
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
