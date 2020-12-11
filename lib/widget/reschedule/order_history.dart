import 'package:accurate_doctor/widget/reschedule/appointment_reports.dart';
import 'package:accurate_doctor/widget/reschedule/completed_appointment.dart';
import 'package:accurate_doctor/widget/reschedule/completed_assesments.dart';
import '../../modal/Configuration.dart';
import '../../modal/RescheduleDataModal.dart';
import 'package:flutter/material.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  int _currentPage = 0;
  List<RescheduleDataModal> rescheduleModal;

  @override
  void initState() {
    var rescheduleDataModal = RescheduleDataModal('', false, false);
    rescheduleModal = rescheduleDataModal.getBuildModal(false);
    if (rescheduleModal == null) rescheduleModal = List<RescheduleDataModal>();
  }

  void moveNext() {
    if (_currentPage < rescheduleModal.length) {
      var updatedModal = rescheduleModal;
      updatedModal.elementAt(_currentPage).isCompleted = true;
      if ((_currentPage + 1) < rescheduleModal.length) {
        int updatedPage = _currentPage + 1;
        updatedModal.elementAt(updatedPage).isInProgress = true;
        setState(() {
          rescheduleModal = updatedModal;
          _currentPage = updatedPage;
        });
      }
    }
  }

  void _moveTo(int indexPosition) {
    int index = 0;
    var updatedModal = this.rescheduleModal;
    while (index < updatedModal.length) {
      if (index < indexPosition) {
        updatedModal.elementAt(index).isInProgress = false;
        updatedModal.elementAt(index).isCompleted = true;
      } else if (index == indexPosition) {
        updatedModal.elementAt(index).isInProgress = true;
        updatedModal.elementAt(index).isCompleted = false;
      } else {
        updatedModal.elementAt(index).isInProgress = false;
        updatedModal.elementAt(index).isCompleted = false;
      }
      index++;
    }

    setState(() {
      rescheduleModal = updatedModal;
      _currentPage = indexPosition;
    });
  }

  void _onSave() {
    this.moveNext();
  }

  void _onSaveAndPrint() {
    this.moveNext();
  }

  Widget getCurrentWizardWidget() {
    switch (this._currentPage) {
      case 0:
        return CompletedAppointment(
          onSave: _onSave,
          onSaveAndPrint: _onSaveAndPrint,
          MoveTo: _moveTo,
        );
      case 1:
        return AppointmentReports(
          onSave: _onSave,
          onSaveAndPrint: _onSaveAndPrint,
          MoveTo: _moveTo,
        );
      case 2:
        return CompletedAssesment(
          onSave: _onSave,
          onSaveAndPrint: _onSaveAndPrint,
          MoveTo: _moveTo,
        );
    }
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
            onPressed: _onSaveAndPrint,
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
            onPressed: _onSave,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: this.getCurrentWizardWidget(),
    );
  }
}
