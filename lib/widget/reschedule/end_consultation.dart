import 'dart:convert';

import 'package:accurate_doctor/modal/order_consultation_model.dart';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../modal/Configuration.dart';
import '../../widget/common/circular_wizard_box.dart';
import '../../widget/reschedule/saveState.dart';
import '../../modal/RescheduleDataModal.dart';
import 'package:flutter/material.dart';

class EndConsultation extends StatefulWidget {
  Function onSave;
  Function onSaveAndPrint;
  Function MoveTo;

  EndConsultation({
    this.onSave,
    this.onSaveAndPrint,
    this.MoveTo,
  });

  @override
  _EndConsultationState createState() => _EndConsultationState();
}

class _EndConsultationState extends State<EndConsultation> {
  final _form = GlobalKey<FormState>();
  OrderConsultationModel orderConsultationModel;
  TextEditingController _service = TextEditingController();
  TextEditingController _patientComplaint = TextEditingController();
  AjaxCall http = AjaxCall.getInstance;

  @override
  void dispose() {
    _service.dispose();
    _patientComplaint.dispose();
    super.dispose();
  }

  void bindFormFields() {
    _service.text = this.orderConsultationModel.service;
    _patientComplaint.text = this.orderConsultationModel.feedbackCompliment;
  }

  void _onSave() {
    final state = _form.currentState.validate();
    if (state) {
      this.orderConsultationModel.service = _service.text;
      this.orderConsultationModel.feedbackCompliment = _patientComplaint.text;

      this.http.post("dynamicform/InsertFinishServicecvalues", {
        "strattdata1": ["done^1", "no^4", "Yes^2", "Yes^3"],
        "fldconsultationId": "2465",
        "fldcustomerid": "1"
      }).then((res) {
        if (res != null) {
          dynamic data = json.decode(res);
          print(res);
        } else {
          Fluttertoast.showToast(msg: "Server error. Please contact admin.");
        }
      });
    } else {
      Fluttertoast.showToast(msg: "Invalid form data. Please correct it.");
    }
    //this.widget.onSave();
  }

  void _onSaveAndPrint() {
    print('onsave called');
    _form.currentState.save();
    this.widget.onSaveAndPrint();
  }

  String notNullString(String data) {
    if (data == null) data = "";
    return data;
  }

  Widget endConsultationWidget() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: Configuration.pagePadding,
          ),
          child: Form(
            key: _form,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text('Finish Service'),
                ),
                Container(
                  child: Container(
                    margin: EdgeInsets.only(top: Configuration.fieldGap),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Service',
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
                      controller: _service,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.trim() == "")
                          return "Service is required field";
                        return null;
                      },
                    ),
                  ),
                ),
                Container(
                  child: Container(
                    margin: EdgeInsets.only(top: Configuration.fieldGap),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Was the patient complaint?',
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
                      controller: _patientComplaint,
                      validator: (value) {
                        if (value == null || value.trim() == "")
                          return "Patient complaint is required field";
                        return null;
                      },
                    ),
                  ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: Configuration.height * .58,
      child: SingleChildScrollView(
        child: Consumer<OrderConsultationModel>(
          builder: (ctx, model, _) {
            this.orderConsultationModel = model;
            bindFormFields();
            return endConsultationWidget();
          },
        ),
      ),
    );
  }
}
