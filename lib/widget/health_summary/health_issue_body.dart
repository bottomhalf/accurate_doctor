import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class HealthIssueBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: EdgeInsets.all(Configuration.pagePadding),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.help),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.print),
                ),
              ],
            ),
            Container(
              width: Configuration.width,
              margin: EdgeInsets.only(bottom: Configuration.fieldGap),
              child: RichText(
                text: TextSpan(
                  style: new TextStyle(
                    fontSize: Theme.of(context).textTheme.headline1.fontSize,
                    color: Theme.of(context).primaryColor,
                  ),
                  children: [
                    TextSpan(
                        text:
                            'Please review your medications and verify that the List is up to date.'),
                    TextSpan(
                      text: 'Call 911 if you have an emergency.',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gastroesophageal Reflux Disease',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Added ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(Icons.info),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      const Text('Learn More'),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hypertriglyceridemia',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Added ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(Icons.info),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      const Text('Learn More'),
                    ],
                  )
                ],
              ),
            ),
            /*Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: OutlineButton(
                color: Theme.of(context).accentColor,
                borderSide: BorderSide(
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {},
                child: Text('Add health issue'),
              ),
            ),*/
            SizedBox(
              height: 15,
            ),
            Text('Personal notes about my health issues'),
            Container(
              margin: EdgeInsets.only(
                top: 15,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 0,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: TextFormField(
                maxLines: 4,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  hintText:
                      'Notes entered here will not be viewable by your doctor',
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: OutlineButton(
                color: Theme.of(context).accentColor,
                borderSide: BorderSide(
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {},
                child: Text('Add a Personal Note'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
