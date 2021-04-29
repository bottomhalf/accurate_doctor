import 'package:flutter/cupertino.dart';

class OrderConsultationModel extends ChangeNotifier {
  String _strMrnNo;
  int _intAppointmentId;
  String _strDiagnosis;
  String _strDiagnosisPlan;
  int _intBranchId;
  String _strInvestigationText;
  String _strInvestigationPlan;
  String _strTreatmentPlan;
  String _strMedicationDetails;
  DateTime _dtFollowUp;
  String _strReferral;
  int _intCreatedBy;
  String _strSourceOne;
  String _strPatientMedicalHistory;
  String _strPresentIllnes;
  String _strPhyscalExamination;
  String _strWeight;
  String _strHeight;
  String _strBMI;
  String _strTemp;
  String _strPulse;
  String _strBPMin;
  String _strBPMax;
  String _strReportAttachements;
  String _strTimeStamp;
  String _documentType;
  String _reportType;
  String _service;
  String _patientComplaint;
  String _feedbackCompliment;

  void notifyChanges() {
    notifyListeners();

    /*
    * to listen changes use below code:
    * --------------------------------------------
    *
    * final data = context.watch<OrderConsultation>();
    *
    * */
  }

  String get service => _service;

  String get feedbackCompliment => _feedbackCompliment;

  set feedbackCompliment(String value) {
    _feedbackCompliment = value;
  }

  set service(String value) {
    _service = value;
  }

  String get documentType => _documentType;

  set documentType(String value) {
    _documentType = value;
  }

  String get strMrnNo => _strMrnNo;

  set strMrnNo(String value) {
    _strMrnNo = value;
  }

  int get intAppointmentId => _intAppointmentId;

  String get strTimeStamp => _strTimeStamp;

  set strTimeStamp(String value) {
    _strTimeStamp = value;
  }

  String get strReportAttachements => _strReportAttachements;

  set strReportAttachements(String value) {
    _strReportAttachements = value;
  }

  String get strBPMax => _strBPMax;

  set strBPMax(String value) {
    _strBPMax = value;
  }

  String get strBPMin => _strBPMin;

  set strBPMin(String value) {
    _strBPMin = value;
  }

  String get strPulse => _strPulse;

  set strPulse(String value) {
    _strPulse = value;
  }

  String get strTemp => _strTemp;

  set strTemp(String value) {
    _strTemp = value;
  }

  String get strBMI => _strBMI;

  set strBMI(String value) {
    _strBMI = value;
  }

  String get strHeight => _strHeight;

  set strHeight(String value) {
    _strHeight = value;
  }

  String get strWeight => _strWeight;

  set strWeight(String value) {
    _strWeight = value;
  }

  String get strPhyscalExamination => _strPhyscalExamination;

  set strPhyscalExamination(String value) {
    _strPhyscalExamination = value;
  }

  String get strPresentIllnes => _strPresentIllnes;

  set strPresentIllnes(String value) {
    _strPresentIllnes = value;
  }

  String get strPatientMedicalHistory => _strPatientMedicalHistory;

  set strPatientMedicalHistory(String value) {
    _strPatientMedicalHistory = value;
  }

  String get strSourceOne => _strSourceOne;

  set strSourceOne(String value) {
    _strSourceOne = value;
  }

  int get intCreatedBy => _intCreatedBy;

  set intCreatedBy(int value) {
    _intCreatedBy = value;
  }

  String get strReferral => _strReferral;

  set strReferral(String value) {
    _strReferral = value;
  }

  DateTime get dtFollowUp => _dtFollowUp;

  set dtFollowUp(DateTime value) {
    _dtFollowUp = value;
  }

  String get strMedicationDetails => _strMedicationDetails;

  set strMedicationDetails(String value) {
    _strMedicationDetails = value;
  }

  String get strTreatmentPlan => _strTreatmentPlan;

  set strTreatmentPlan(String value) {
    _strTreatmentPlan = value;
  }

  String get strInvestigationPlan => _strInvestigationPlan;

  set strInvestigationPlan(String value) {
    _strInvestigationPlan = value;
  }

  String get strInvestigationText => _strInvestigationText;

  set strInvestigationText(String value) {
    _strInvestigationText = value;
  }

  int get intBranchId => _intBranchId;

  set intBranchId(int value) {
    _intBranchId = value;
  }

  String get strDiagnosisPlan => _strDiagnosisPlan;

  set strDiagnosisPlan(String value) {
    _strDiagnosisPlan = value;
  }

  String get strDiagnosis => _strDiagnosis;

  set strDiagnosis(String value) {
    _strDiagnosis = value;
  }

  set intAppointmentId(int value) {
    _intAppointmentId = value;
  }

  String get reportType => _reportType;

  set reportType(String value) {
    _reportType = value;
  }

  String get patientComplaint => _patientComplaint;

  set patientComplaint(String value) {
    _patientComplaint = value;
  }

  @override
  String toString() {
    return 'OrderConsultationModel{_strMrnNo: $_strMrnNo, _intAppointmentId: $_intAppointmentId, _strDiagnosis: $_strDiagnosis, _strDiagnosisPlan: $_strDiagnosisPlan, _intBranchId: $_intBranchId, _strInvestigationText: $_strInvestigationText, _strInvestigationPlan: $_strInvestigationPlan, _strTreatmentPlan: $_strTreatmentPlan, _strMedicationDetails: $_strMedicationDetails, _dtFollowUp: $_dtFollowUp, _strReferral: $_strReferral, _intCreatedBy: $_intCreatedBy, _strSourceOne: $_strSourceOne, _strPatientMedicalHistory: $_strPatientMedicalHistory, _strPresentIllnes: $_strPresentIllnes, _strPhyscalExamination: $_strPhyscalExamination, _strWeight: $_strWeight, _strHeight: $_strHeight, _strBMI: $_strBMI, _strTemp: $_strTemp, _strPulse: $_strPulse, _strBPMin: $_strBPMin, _strBPMax: $_strBPMax, _strReportAttachements: $_strReportAttachements, _strTimeStamp: $_strTimeStamp, _documentType: $_documentType, _reportType: $_reportType, _service: $_service, _patientComplaint: $_patientComplaint, _feedbackCompliment: $_feedbackCompliment}';
  }
}
