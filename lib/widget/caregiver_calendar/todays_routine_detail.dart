import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:flutter/material.dart';

class TodaysRoutineDetail extends StatelessWidget {
  List<Widget> routine;
  TodaysRoutineDetail() {
    this.getTodaysList();
  }

  void getTodaysList() {
    routine = [];
    int i = 0;
    while (i < 5) {
      routine.add(Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Text(
                    '$i PM',
                    style: TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('Consultation'),
              ),
            )
          ],
        ),
      ));
      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: this.routine,
      ),
    );
  }
}
