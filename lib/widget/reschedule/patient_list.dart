import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/modal/RescheduleDataModal.dart';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class PatientList extends StatefulWidget {
  Function onSave;
  Function onSaveAndPrint;
  Function MoveTo;
  List<RescheduleDataModal> rescheduleModal;
  PatientList({
    this.onSave,
    this.onSaveAndPrint,
    this.MoveTo,
    this.rescheduleModal,
  });

  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  List<dynamic> orders;
  AjaxCall http;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    http = AjaxCall.getInstance;
    setState(() {
      this.isLoading = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      this.http.post("Common/GetAppointmentDetails", {
        "Start_Date": "2020-12-17",
        "EndDate": "2020-12-17",
        "DocId": 1,
        "intBranchId": 171
      }).then((value) {
        if (value != null) {
          orders = json.decode(value);
          Fluttertoast.showToast(msg: 'Order feteched successfully');
          setState(() {
            this.orders = orders;
            this.isLoading = false;
          });
        } else {
          setState(() {
            this.orders = orders;
            this.isLoading = false;
          });
        }
      });
    });
  }

  Widget getPatientDetail(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 14,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Container(
                      width: Configuration.width * .25,
                      margin: EdgeInsets.only(
                        right: 10,
                        bottom: 8,
                      ),
                      child: Text(
                        'Patient Name',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(this.orders.elementAt(index)['PatientName']),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Container(
                      width: Configuration.width * .25,
                      margin: EdgeInsets.only(
                        right: 10,
                        bottom: 8,
                      ),
                      child: Text(
                        'Age',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text('${this.orders.elementAt(index)['Age']}'),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: Configuration.width * .25,
                    margin: EdgeInsets.only(
                      right: 10,
                      bottom: 8,
                    ),
                    child: Text(
                      'Gender',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(this.orders.elementAt(index)['Gender']),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Container(
                      width: Configuration.width * .25,
                      margin: EdgeInsets.only(
                        right: 10,
                        bottom: 8,
                      ),
                      child: Text(
                        'Reason For Visit',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(this.orders.elementAt(index)['ReasonforVisit']),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Container(
                      width: Configuration.width * .25,
                      margin: EdgeInsets.only(
                        right: 10,
                        bottom: 8,
                      ),
                      child: Text(
                        'Appt. Time',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(this.orders.elementAt(index)['BookTime']),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Container(
                      width: Configuration.width * .25,
                      margin: EdgeInsets.only(
                        right: 10,
                        bottom: 8,
                      ),
                      child: Text(
                        'Action',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Wrap(
                      children: [
                        Text('Consult | '),
                        Text('Prev Consultation | '),
                        Text('Reschedule | '),
                        Text('Cancel | '),
                        Text('Emr | '),
                        Text('Video Consultation'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget actionButtons(BuildContext context) {
    return ButtonBar(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: Configuration.width * .4,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: RaisedButton(
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            child: const Text(
              'Save',
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
            onPressed: widget.onSaveAndPrint,
          ),
        ),
        Container(
          width: Configuration.width * .4,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: RaisedButton(
            color: Colors.white,
            textColor: Theme.of(context).accentColor,
            child: const Text(
              'Save & Print',
            ),
            padding: EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: BorderSide(
                color: Theme.of(context).accentColor,
              ),
            ),
            onPressed: widget.onSave,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return this.isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Container(
                height: Configuration.height * .58,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: this.orders.length + 1,
                  itemBuilder: (ctx, index) {
                    if ((index + 1) == (this.orders.length + 1))
                      return this.actionButtons(context);
                    else {
                      return this.getPatientDetail(context, index);
                    }
                  },
                ),
              )
            ],
          );
  }
}
