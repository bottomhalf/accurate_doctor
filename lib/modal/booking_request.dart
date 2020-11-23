class BookingSlotModal {
  int intDoctorId;
  int intPatientId;
  String ConsultationFee;
  DateTime dBookDate;
  int intSlotNo;
  String strBookTime;
  String strReasonForVisit;
  int intAppointmentStatus;
  String strEmail;
  String strName;
  String strAge;
  String strGender;
  String strBookedBy;
  String strDoctorEmailId;
  String strDoctorName;
  String strSourceOne;
  int intCreatedBy;
  int intBranchId;
  String strOrganizationName;
  int intCategoryId;
  String WorkDetails;

  @override
  String toString() {}

  BookingSlotModal();

  init(
      {intDoctorId,
      intPatientId,
      ConsultationFee,
      dBookDate,
      intSlotNo,
      strBookTime,
      strReasonForVisit,
      intAppointmentStatus,
      strEmail,
      strName,
      strAge,
      strGender,
      strBookedBy,
      strDoctorEmailId,
      strDoctorName,
      strSourceOne,
      intCreatedBy,
      intBranchId,
      strOrganizationName,
      intCategoryId,
      WorkDetails}) {
    this.WorkDetails = WorkDetails;
    this.intDoctorId = intDoctorId;
    this.intPatientId = intPatientId;
    this.ConsultationFee = ConsultationFee;
    this.dBookDate = dBookDate;
    this.intSlotNo = intSlotNo;
    this.strBookTime = strBookTime;
    this.strReasonForVisit = strReasonForVisit;
    this.intAppointmentStatus = intAppointmentStatus;
    this.strEmail = strEmail;
    this.strName = strName;
    this.strAge = strAge;
    this.strGender = strGender;
    this.strBookedBy = strBookedBy;
    this.strDoctorEmailId = strDoctorEmailId;
    this.strDoctorName = strDoctorName;
    this.strSourceOne = strSourceOne;
    this.intCreatedBy = intCreatedBy;
    this.intBranchId = intBranchId;
    this.strOrganizationName = strOrganizationName;
    this.intCategoryId = intCategoryId;
  }
}
