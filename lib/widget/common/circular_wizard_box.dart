import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:flutter/material.dart';

class CircularWizardBox extends StatelessWidget {
  final double radius;
  final String title;
  final double leftWing;
  final double righttWing;
  final int index;
  final bool isCompleted;
  final bool isInProgress;
  Function goToIndexedWizard;
  double stripSize;

  String _stateColor = '#ced7ed';
  String _stateTextColor = '#31216F';

  CircularWizardBox({
    @required this.radius,
    this.title,
    this.index,
    this.leftWing = 0,
    this.righttWing = 0,
    this.isInProgress = false,
    this.isCompleted = false,
    this.goToIndexedWizard,
  }) {
    stripSize = this.radius / 10 * .6;
    if (this.isCompleted) {
      _stateColor = '#5973b3';
      _stateTextColor = '#e3e3e3';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        this.goToIndexedWizard(this.index);
      },
      child: Container(
        /*decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
        ),*/
        width: this.radius * 2 + (this.leftWing + this.righttWing),
        //height: this.radius * 2 + 40,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: Stack(
          children: [
            Positioned(
              top: this.radius - this.stripSize,
              child: Container(
                height: stripSize,
                width: this.radius * 2 + (this.leftWing + this.righttWing),
                color: Configuration.ColorFromHex(_stateColor),
              ),
            ),
            Positioned(
              right: this.righttWing > 0 ? this.righttWing : 0,
              left: this.leftWing > 0 ? this.leftWing : 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: this.radius * 2,
                    height: this.radius * 2,
                    padding: EdgeInsets.all((this.radius * 2) / 4),
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        color: Configuration.ColorFromHex(_stateColor),
                        border: Border.all(
                          color: this.isInProgress
                              ? Configuration.ColorFromHex('#5973b3')
                              : Configuration.ColorFromHex('#ced7ed'),
                        ),
                        shape: BoxShape.circle),
                    child: FittedBox(
                      child: Text(
                        (this.index + 1).toString(),
                        style: TextStyle(
                          color: Configuration.ColorFromHex(_stateTextColor),
                          fontSize: this.radius,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        this.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
