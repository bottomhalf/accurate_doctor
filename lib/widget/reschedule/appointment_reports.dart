import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/modal/RescheduleDataModal.dart';
import 'package:accurate_doctor/widget/common/circular_wizard_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AppointmentReports extends StatelessWidget {
  Function onSave;
  Function onSaveAndPrint;
  Function MoveTo;
  AppointmentReports({
    this.onSave,
    this.onSaveAndPrint,
    this.MoveTo,
  });

  int appointments = 4;

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
              Container(
                margin: EdgeInsets.only(top: Configuration.fieldGap),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Test Name',
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
                    //FocusScope.of(context).requestFocus(_testCode);
                  },
                  validator: (value) {
                    return null;
                  },
                  onSaved: (value) {
                    print(value);
                  },
                ),
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
                        'Patient Name',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text('L Sai Harsha Vardhan'),
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
                    child: Text('23 Yrs'),
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
                    child: Text('Male'),
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
                    child: Text('Fever'),
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
                        'Appointment Time',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text('09:00'),
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
                    child: Text(
                        'Consult | Prev Consultation | Reschedule | Cancel | Emr | Video Consultation'),
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
            onPressed: onSaveAndPrint,
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
            onPressed: onSave,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Configuration.height * .58,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: appointments + 1,
        itemBuilder: (ctx, index) {
          if ((index + 1) == (appointments + 1))
            return this.actionButtons(context);
          else {
            return this.getPatientDetail(context, index);
          }
        },
      ),
    );
  }
}
