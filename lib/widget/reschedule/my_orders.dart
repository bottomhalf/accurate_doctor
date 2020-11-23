import '../../widget/reschedule/end_consultation.dart';
import '../../widget/reschedule/feedback_rating.dart';
import '../../widget/reschedule/investigation.dart';
import '../../widget/reschedule/medical_history.dart';
import '../../widget/reschedule/medication.dart';
import '../../widget/reschedule/vital_history.dart';
import '../../widget/reschedule/start_consultation.dart';
import '../../modal/Configuration.dart';
import '../../widget/reschedule/patient_list.dart';
import '../../modal/RescheduleDataModal.dart';

import '../../widget/common/circular_wizard_box.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  int _currentPage = 0;
  List<RescheduleDataModal> rescheduleModal;

  @override
  void initState() {
    var rescheduleDataModal = RescheduleDataModal('', false, false);
    rescheduleModal = rescheduleDataModal.getBuildModal();
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
        return PatientList(
          onSave: _onSave,
          onSaveAndPrint: _onSaveAndPrint,
          MoveTo: _moveTo,
          rescheduleModal: rescheduleModal,
        );
      case 1:
        return StartConsultation(
          onSave: _onSave,
          onSaveAndPrint: _onSaveAndPrint,
          MoveTo: _moveTo,
          rescheduleModal: rescheduleModal,
        );
      case 2:
        return Investigation(
          onSave: _onSave,
          onSaveAndPrint: _onSaveAndPrint,
          MoveTo: _moveTo,
          rescheduleModal: rescheduleModal,
        );
      case 3:
        return Medication(
          onSave: _onSave,
          onSaveAndPrint: _onSaveAndPrint,
          MoveTo: _moveTo,
          rescheduleModal: rescheduleModal,
        );
      case 4:
        return VitalsHistory(
          onSave: _onSave,
          onSaveAndPrint: _onSaveAndPrint,
          MoveTo: _moveTo,
          rescheduleModal: rescheduleModal,
        );
      case 5:
        return PastMadicalHistory(
          onSave: _onSave,
          onSaveAndPrint: _onSaveAndPrint,
          MoveTo: _moveTo,
          rescheduleModal: rescheduleModal,
        );
      case 6:
        return EndConsultation(
          onSave: _onSave,
          onSaveAndPrint: _onSaveAndPrint,
          MoveTo: _moveTo,
          rescheduleModal: rescheduleModal,
        );
      case 7:
        return FeedbackAndRating(
          onSave: _onSave,
          onSaveAndPrint: _onSaveAndPrint,
          MoveTo: _moveTo,
          rescheduleModal: rescheduleModal,
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
