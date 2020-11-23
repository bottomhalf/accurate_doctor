import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:flutter/material.dart';

class SaveState extends StatelessWidget {
  Function onSave;
  Function onSaveAndPrint;
  SaveState({@required this.onSave, @required this.onSaveAndPrint});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(
        top: 10,
      ),
      /*decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
      ),*/
      child: ButtonBar(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: Configuration.width * .4,
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
              onPressed: onSaveAndPrint,
            ),
          ),
          Container(
            width: Configuration.width * .4,
            //padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
              onPressed: onSave,
            ),
          ),
        ],
      ),
    );
  }
}
