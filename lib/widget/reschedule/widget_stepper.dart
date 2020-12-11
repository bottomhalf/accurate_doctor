import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/modal/RescheduleDataModal.dart';
import 'package:accurate_doctor/widget/common/circular_wizard_box.dart';
import 'package:accurate_doctor/widget/reschedule/appointment_reports.dart';
import 'package:accurate_doctor/widget/reschedule/completed_appointment.dart';
import 'package:accurate_doctor/widget/reschedule/completed_assesments.dart';
import 'package:accurate_doctor/widget/reschedule/end_consultation.dart';
import 'package:accurate_doctor/widget/reschedule/feedback_rating.dart';
import 'package:accurate_doctor/widget/reschedule/investigation.dart';
import 'package:accurate_doctor/widget/reschedule/medical_history.dart';
import 'package:accurate_doctor/widget/reschedule/medication.dart';
import 'package:accurate_doctor/widget/reschedule/patient_list.dart';
import 'package:accurate_doctor/widget/reschedule/start_consultation.dart';
import 'package:accurate_doctor/widget/reschedule/vital_history.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

const scrollDuration = Duration(milliseconds: 900);

class WidgetStepper extends StatefulWidget {
  List<dynamic> items;
  bool isMyOrder;
  WidgetStepper({@required this.items, @required this.isMyOrder});

  @override
  _WidgetStepperState createState() => _WidgetStepperState();
}

class _WidgetStepperState extends State<WidgetStepper> {
  int _currentPage = 0;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  List<RescheduleDataModal> itemModalDetail;

  @override
  void initState() {
    this.itemModalDetail = widget.items;
  }

  void moveNext() {
    if (_currentPage < itemModalDetail.length) {
      var updatedModal = itemModalDetail;
      updatedModal.elementAt(_currentPage).isCompleted = true;
      if ((_currentPage + 1) < itemModalDetail.length) {
        int updatedPage = _currentPage + 1;
        updatedModal.elementAt(updatedPage).isInProgress = true;
        setState(() {
          itemModalDetail = updatedModal;
          _currentPage = updatedPage;
        });
        this.scrollTo(updatedPage);
      }
    }
  }

  void movePrevious() {
    if (_currentPage > 0) {
      var updatedModal = itemModalDetail;
      updatedModal.elementAt(_currentPage).isInProgress = false;
      updatedModal.elementAt(_currentPage).isCompleted = false;
      int updatedPage = _currentPage - 1;
      updatedModal.elementAt(updatedPage).isCompleted = false;
      setState(() {
        itemModalDetail = updatedModal;
        _currentPage = updatedPage;
      });
      this.scrollTo(updatedPage);
    }
  }

  void _moveTo(int indexPosition) {
    int index = 0;
    var updatedModal = this.itemModalDetail;
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
      itemModalDetail = updatedModal;
      _currentPage = indexPosition;
    });
  }

  void _onSave() {
    this.moveNext();
  }

  void _onSaveAndPrint() {
    this.moveNext();
  }

  double alignment = 0;

  void scrollTo(int index) => itemScrollController.scrollTo(
      index: index,
      duration: scrollDuration,
      curve: Curves.easeInOutCubic,
      alignment: alignment);

  Widget orderHistory() {
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

  Widget getCurrentWizardWidget() {
    if (widget.isMyOrder)
      return myOrder();
    else
      return orderHistory();
  }

  Widget myOrder() {
    switch (this._currentPage) {
      case 0:
        return PatientList(
          onSave: _onSave,
          onSaveAndPrint: _onSaveAndPrint,
          MoveTo: _moveTo,
        );
      case 1:
        return StartConsultation(
          onSave: _onSave,
          onSaveAndPrint: _onSaveAndPrint,
          MoveTo: _moveTo,
        );
      case 2:
        return Investigation(
          onSave: _onSave,
          onSaveAndPrint: _onSaveAndPrint,
          MoveTo: _moveTo,
        );
      case 3:
        return Medication(
          onSave: _onSave,
          onSaveAndPrint: _onSaveAndPrint,
          MoveTo: _moveTo,
        );
      case 4:
        return VitalsHistory(
          onSave: _onSave,
          onSaveAndPrint: _onSaveAndPrint,
          MoveTo: _moveTo,
        );
      case 5:
        return PastMadicalHistory(
          onSave: _onSave,
          onSaveAndPrint: _onSaveAndPrint,
          MoveTo: _moveTo,
        );
      case 6:
        return EndConsultation(
          onSave: _onSave,
          onSaveAndPrint: _onSaveAndPrint,
          MoveTo: _moveTo,
        );
      case 7:
        return FeedbackAndRating(
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          height: Configuration.height * .15,
          child: ScrollablePositionedList.builder(
            itemCount: this.itemModalDetail.length,
            itemScrollController: itemScrollController,
            itemPositionsListener: itemPositionsListener,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              return CircularWizardBox(
                radius: 30,
                goToIndexedWizard: _moveTo,
                index: index,
                title: this.itemModalDetail.elementAt(index).title,
                righttWing: (this.itemModalDetail.length - 1) == index ? 0 : 20,
                leftWing: index == 0 ? 0 : 20,
                isCompleted: this.itemModalDetail.elementAt(index).isCompleted,
                isInProgress:
                    this.itemModalDetail.elementAt(index).isInProgress,
              );
            },
          ),
        ),
        Container(
          child: this.getCurrentWizardWidget(),
        )
      ],
    );
  }
}
