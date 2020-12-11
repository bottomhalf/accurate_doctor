class RescheduleDataModal {
  String title;
  bool isInProgress;
  bool isCompleted;
  List<RescheduleDataModal> _rescheduleModal;

  RescheduleDataModal(this.title, this.isInProgress, this.isCompleted);

  List<RescheduleDataModal> getBuildModal(bool flag) {
    _rescheduleModal = null;
    if (flag) {
      if (_rescheduleModal == null)
        _rescheduleModal = new List<RescheduleDataModal>();
      _rescheduleModal.addAll({
        RescheduleDataModal('Today\'s Patient List', true, false),
        RescheduleDataModal('Start Consultation', false, false),
        RescheduleDataModal('Investigation', false, false),
        RescheduleDataModal('Medication', false, false),
        RescheduleDataModal('Vitals History', false, false),
        RescheduleDataModal('Past Medical History', false, false),
        RescheduleDataModal('End Consultation', false, false),
        RescheduleDataModal('Feedback & Rating', false, false)
      });
    } else {
      _rescheduleModal = new List<RescheduleDataModal>();
      _rescheduleModal.addAll({
        RescheduleDataModal('Completed Appointment', true, false),
        RescheduleDataModal('Appointment Reports', false, false),
        RescheduleDataModal('Completed Assesments', false, false)
      });
    }

    return _rescheduleModal;
  }
}
