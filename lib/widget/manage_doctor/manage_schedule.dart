import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/modal/RescheduleDataModal.dart';
import 'package:accurate_doctor/widget/common/circular_wizard_box.dart';
import 'package:accurate_doctor/widget/manage_doctor/manage_services.dart';
import 'package:accurate_doctor/widget/manage_doctor/manage_settings.dart';
import 'package:accurate_doctor/widget/manage_doctor/vacations.dart';
import 'package:accurate_doctor/widget/manage_doctor/work_hours.dart';
import 'package:accurate_doctor/widget/reschedule/widget_stepper.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ManageSchedule extends StatefulWidget {
  List<dynamic> items;
  ManageSchedule({@required this.items});

  @override
  _ManageScheduleState createState() => _ManageScheduleState();
}

class _ManageScheduleState extends State<ManageSchedule> {
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

  Widget manageScheduleWidget() {
    switch (this._currentPage) {
      case 0:
        return ManageServices(
          onSave: _onSave,
          onSaveAndPrint: _onSaveAndPrint,
          MoveTo: _moveTo,
        );
      case 1:
        return ManageSettings(
          onSave: _onSave,
          onSaveAndPrint: _onSaveAndPrint,
          MoveTo: _moveTo,
        );
      case 2:
        return WorkHours(
          onSave: _onSave,
          onSaveAndPrint: _onSaveAndPrint,
          MoveTo: _moveTo,
        );
      case 3:
        return Vacations(
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
          child: this.manageScheduleWidget(),
        )
      ],
    );
  }
}
