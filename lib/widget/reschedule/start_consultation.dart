import '../../widget/reschedule/saveState.dart';
import '../../modal/RescheduleDataModal.dart';
import '../../widget/common/circular_wizard_box.dart';

import '../../modal/Configuration.dart';
import 'package:flutter/material.dart';

class StartConsultation extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final _illnessHistory = FocusNode();
  Function onSave;
  Function onSaveAndPrint;
  Function MoveTo;
  List<RescheduleDataModal> rescheduleModal;
  StartConsultation({
    this.onSave,
    this.onSaveAndPrint,
    this.MoveTo,
    this.rescheduleModal,
  });

  void _onSave() {
    print('onsave called');
    this.onSave();
  }

  void _onSaveAndPrint() {
    print('onsave called');
    _form.currentState.save();
    this.onSaveAndPrint();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Configuration.height * .58,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: Configuration.height * .15,
              child: ListView.builder(
                itemCount: this.rescheduleModal.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return CircularWizardBox(
                    radius: 30,
                    goToIndexedWizard: MoveTo,
                    index: index,
                    title: this.rescheduleModal.elementAt(index).title,
                    righttWing:
                        (this.rescheduleModal.length - 1) == index ? 0 : 20,
                    leftWing: index == 0 ? 0 : 20,
                    isCompleted:
                        this.rescheduleModal.elementAt(index).isCompleted,
                    isInProgress:
                        this.rescheduleModal.elementAt(index).isInProgress,
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Configuration.pagePadding,
              ),
              alignment: Alignment.centerLeft,
              child: Text('Chief Complaint & History Of Present Illness'),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Configuration.pagePadding,
              ),
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    Container(
                      child: Container(
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
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_illnessHistory);
                          },
                          validator: (value) {
                            return null;
                          },
                          onSaved: (value) {
                            print(value);
                          },
                        ),
                      ),
                    ),
                    Container(
                      child: Container(
                        margin: EdgeInsets.only(top: Configuration.fieldGap),
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
                          focusNode: _illnessHistory,
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
                    ),
                    ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: Text(
                        'Physical Examination Treatment Plan',
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
                    ),
                    ExpansionTile(
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
                    ),
                    ExpansionTile(
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
                    ),
                    ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: Text(
                        'Follow up',
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
                    ),
                    ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: Text(
                        'Choose File',
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
        ),
      ),
    );
  }
}
