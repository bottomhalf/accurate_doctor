import '../../modal/Configuration.dart';
import '../../widget/common/circular_wizard_box.dart';
import '../../widget/reschedule/saveState.dart';
import '../../modal/RescheduleDataModal.dart';
import 'package:flutter/material.dart';

class FeedbackAndRating extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  Function onSave;
  Function onSaveAndPrint;
  Function MoveTo;
  List<RescheduleDataModal> rescheduleModal;

  final _testCode = FocusNode();
  final _description = FocusNode();
  final _associateTestCode = FocusNode();
  final _department = FocusNode();

  FeedbackAndRating({
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
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    Container(
                      child: Container(
                        margin: EdgeInsets.only(top: Configuration.fieldGap),
                        child: TextFormField(
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: 'Give a Compliment',
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
                            FocusScope.of(context).requestFocus(_testCode);
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
