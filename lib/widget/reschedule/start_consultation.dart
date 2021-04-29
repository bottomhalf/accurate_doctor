import 'dart:convert';
import 'dart:io';

import 'package:accurate_doctor/modal/order_consultation_model.dart';
import 'package:accurate_doctor/modal/user_detail.dart';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../widget/reschedule/saveState.dart';
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
  OrderConsultationModel orderConsultationModel;
  TextEditingController _chiefComplaint = TextEditingController();
  TextEditingController _historyOfPatientIllness = TextEditingController();
  TextEditingController _physicalExamination = TextEditingController();
  TextEditingController _treatmentPlan = TextEditingController();
  TextEditingController _isOneWeek = TextEditingController();
  int _documentType = -1;
  int _reportType = -1;
  TextEditingController _doctorName = TextEditingController();
  List<dynamic> documentType = [];
  List<dynamic> reports = [];
  final UserDetail userDetail = UserDetail.instance;
  String base64Data;
  File _filePath;
  AjaxCall http = AjaxCall.getInstance;

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

  void _submitForm() {
    if (_filePath != null) {
      /*Map<String, String> items = Map<String, dynamic>();
      items["strMrnNo"] = this.orderConsultationModel.strMrnNo;
      items["intAppointmentId"] = this.orderConsultationModel.intAppointmentId;
      items["strDiagnosis"] = "";
      items["strDiagnosisPlan"] = "";
      items["intBranchId"] = this.orderConsultationModel.intBranchId
      items["strInvestigationText"] = "";
      items["strInvestigationPlan"] = "";
      items["strTreatmentPlan"] = this.orderConsultationModel.strTreatmentPlan;
      items["strMedicationDetails"] = "";
      items["dtFollowUp"] = "4/2/2021"; //DateTime.now()
      items["strReferral"] = this.orderConsultationModel.strReferral;
      items["intCreatedBy"] = this.orderConsultationModel.intCreatedBy;
      items["strSourceOne"] = this.orderConsultationModel.strSourceOne;
      items["strPatientMedicalHistory"] = this.orderConsultationModel.strPatientMedicalHistory;
      items["strPresentIllnes"] = this.orderConsultationModel.strPresentIllnes;
      items["strPhyscalExamination"] = this.orderConsultationModel.strPhyscalExamination;
      items["strWeight"] = "";
      items["strHeight"] = "";
      items["strBMI"] = "";
      items["strTemp"] = "";
      items["strPulse"] = "";
      items["strBPMin"] = "";
      items["strBPMax"] = "";
      items["strReportAttachements"] = _filePath.path;
      items["strTimeStamp"] = this.orderConsultationModel.strTimeStamp;*/

      print("Submit form...");
      this.orderConsultationModel.strReportAttachements = _filePath.path;
      http.post("ConsultationDetails/InsertConsultation", {
        "strMrnNo": this.orderConsultationModel.strMrnNo,
        "intAppointmentId": this.orderConsultationModel.intAppointmentId,
        "strDiagnosis": this.orderConsultationModel.strDiagnosis,
        "strDiagnosisPlan": "",
        "intBranchId": "162",
        "strInvestigationText": "",
        "strInvestigationPlan": "",
        "strTreatmentPlan": this.orderConsultationModel.strTreatmentPlan,
        "strMedicationDetails": "",
        "dtFollowUp": DateFormat("dd/MM/yyyy").format(DateTime.now()),
        "strReferral": this.orderConsultationModel.strReferral,
        "intCreatedBy": this.orderConsultationModel.intCreatedBy,
        "strSourceOne": "M",
        "strPatientMedicalHistory":
            this.orderConsultationModel.strPatientMedicalHistory,
        "strPresentIllnes": this.orderConsultationModel.strPresentIllnes,
        "strPhyscalExamination":
            this.orderConsultationModel.strPhyscalExamination,
        "strWeight": "",
        "strHeight": "",
        "strBMI": "",
        "strTemp": "",
        "strPulse": "",
        "strBPMin": "",
        "strBPMax": "",
        "strReportAttachements": _filePath.path,
        "strTimeStamp": this.orderConsultationModel.strTimeStamp
      }).then((res) {
        if (res != null) {
          var data = json.decode(res);
          if (data["Status"].toString().indexOf("Successfully") != -1)
            Fluttertoast.showToast(msg: data["Status"]);
          else
            Fluttertoast.showToast(
                msg: "Fail to upload. Please contact admin.");
        } else {
          Fluttertoast.showToast(msg: "Fail to upload. Please contact admin.");
        }
      });
    }
  }

  Future<void> _getPicture() async {
    try {
      ImagePicker _picker = ImagePicker();
      PickedFile pickedFile =
          await _picker.getImage(source: ImageSource.gallery);
      pickedFile.readAsBytes().then((value) {
        List<int> imageBytes = value;
        this.base64Data = base64Encode(imageBytes);
      });

      setState(() {
        _filePath = File(pickedFile.path);
        this.orderConsultationModel.strReportAttachements = _filePath.path;
      });
    } catch (e) {
      print(e);
    }
  }

  void _onSave() {
    print('onsave called');
    _form.currentState.save();
    final state = _form.currentState.validate();
    if (state) {
      this.orderConsultationModel.strTreatmentPlan = _treatmentPlan.text;
      this.orderConsultationModel.strReferral = "General";
      this.orderConsultationModel.intCreatedBy = userDetail.UserId;
      this.orderConsultationModel.intBranchId =
          userDetail.strOrganization != null
              ? int.parse(userDetail.strOrganization)
              : 162;
      this.orderConsultationModel.strMrnNo = userDetail.customerId;
      this.orderConsultationModel.intAppointmentId = userDetail.appointmentId;
      this.orderConsultationModel.strSourceOne = "M";
      this.orderConsultationModel.strPatientMedicalHistory =
          _historyOfPatientIllness.text;
      this.orderConsultationModel.strPresentIllnes = _chiefComplaint.text;
      this.orderConsultationModel.strPhyscalExamination =
          _physicalExamination.text;
      this.orderConsultationModel.strTimeStamp =
          DateTime.now().millisecond.toString();

      this._submitForm();
    } else {
      Fluttertoast.showToast(
          msg: "Form contain missing field. Please correct it.");
    }
  }

  void _onSaveAndPrint() {
    print('onsave called');
    _form.currentState.save();
    //this.widget.onSaveAndPrint();
  }

  String radioButtonItem = 'ONE';

  int id = 1;

  Widget startConsultationBody() {
    return Container(
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
                  fontWeight: Theme.of(context).textTheme.headline2.fontWeight,
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
                    controller: _chiefComplaint,
                    onFieldSubmitted: (_) {},
                    validator: (value) {
                      if (value.trim() == "")
                        return "Chief Complaint is mandatory";
                      return null;
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
                    controller: _historyOfPatientIllness,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (_) {},
                    validator: (value) {
                      if (value.trim() == "")
                        return "History of present illness is mandatory";
                      return null;
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
                  fontWeight: Theme.of(context).textTheme.headline2.fontWeight,
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
                    controller: _physicalExamination,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (_) {},
                    validator: (value) {
                      if (value.trim() == "")
                        return "Physical Examination is mandatory";
                      return null;
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
                    controller: _treatmentPlan,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (_) {},
                    validator: (value) {
                      if (value.trim() == "")
                        return "Treatment Plan is mandatory";
                      return null;
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
                  fontWeight: Theme.of(context).textTheme.headline2.fontWeight,
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
                  fontWeight: Theme.of(context).textTheme.headline2.fontWeight,
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
                    value: _documentType,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    onChanged: (value) {
                      //FocusScope.of(context).requestFocus(_speciality);
                      if (value == -1)
                        this.orderConsultationModel.documentType = null;
                      else
                        this.orderConsultationModel.documentType = 'Some value';
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
                    value: _reportType,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    onChanged: (value) {
                      //FocusScope.of(context).requestFocus(_speciality);
                      if (value == -1)
                        this.orderConsultationModel.documentType = null;
                      else
                        this.orderConsultationModel.documentType = 'Some value';
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
                    controller: _doctorName,
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
                    onPressed: _getPicture,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderConsultationModel>(
      builder: (ctx, model, _) {
        this.orderConsultationModel = model;
        return Column(
          children: [
            startConsultationBody(),
          ],
        );
      },
    );
  }
}
