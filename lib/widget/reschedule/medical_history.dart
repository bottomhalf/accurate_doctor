import '../../modal/Configuration.dart';
import '../../widget/common/circular_wizard_box.dart';
import '../../widget/reschedule/saveState.dart';
import '../../modal/RescheduleDataModal.dart';
import 'package:flutter/material.dart';

class PastMadicalHistory extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  Function onSave;
  Function onSaveAndPrint;
  Function MoveTo;
  List<RescheduleDataModal> rescheduleModal;

  final _testCode = FocusNode();
  final _description = FocusNode();
  final _associateTestCode = FocusNode();
  final _department = FocusNode();

  PastMadicalHistory({
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
                      margin: EdgeInsets.only(
                        top: 20,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text('Diseases'),
                    ),
                    Container(
                      child: Container(
                        margin: EdgeInsets.only(top: Configuration.fieldGap),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Enter Description',
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
                    Container(
                      child: Container(
                        margin: EdgeInsets.only(top: Configuration.fieldGap),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Enter Code',
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
                          focusNode: _testCode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_department);
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
                          decoration: InputDecoration(
                            labelText: 'Enter From',
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
                          focusNode: _department,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_associateTestCode);
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
                          decoration: InputDecoration(
                            labelText: 'Enter To',
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
                    Container(
                      child: Container(
                        margin: EdgeInsets.only(top: Configuration.fieldGap),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Enter Remarks',
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
                          focusNode: _testCode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_department);
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
                      margin: EdgeInsets.only(
                        top: 20,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text('Medication'),
                    ),
                    Container(
                      child: Container(
                        margin: EdgeInsets.only(top: Configuration.fieldGap),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Generic Name',
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
                    Container(
                      child: Container(
                        margin: EdgeInsets.only(top: Configuration.fieldGap),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Brand Name',
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
                          focusNode: _testCode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_department);
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
                      margin: EdgeInsets.only(
                        top: 20,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text('Dosage'),
                    ),
                    Container(
                      child: Container(
                        margin: EdgeInsets.only(top: Configuration.fieldGap),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Select',
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
                          focusNode: _testCode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_department);
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
                      margin: EdgeInsets.only(
                        top: 20,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text('Duration'),
                    ),
                    Container(
                      child: Container(
                        margin: EdgeInsets.only(top: Configuration.fieldGap),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Select',
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
                          focusNode: _testCode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_department);
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
                          decoration: InputDecoration(
                            labelText: 'Instructions',
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
                          focusNode: _testCode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_department);
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
                      margin: EdgeInsets.only(
                        top: 20,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text('Allergies'),
                    ),
                    Container(
                      child: Container(
                        margin: EdgeInsets.only(top: Configuration.fieldGap),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Allergy Type',
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
                          focusNode: _testCode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_department);
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
                          decoration: InputDecoration(
                            labelText: 'Observed Date',
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
                          focusNode: _testCode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_department);
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
                          decoration: InputDecoration(
                            labelText: 'End Date',
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
                          focusNode: _testCode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_department);
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
                          decoration: InputDecoration(
                            labelText: 'Reactions',
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
                          focusNode: _testCode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_department);
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
                          decoration: InputDecoration(
                            labelText: 'Source info',
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
                          focusNode: _testCode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_department);
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
                          decoration: InputDecoration(
                            labelText: 'Comments',
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
                          focusNode: _testCode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_department);
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
