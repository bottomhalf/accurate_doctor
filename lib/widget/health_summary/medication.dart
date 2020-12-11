import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Medications extends StatelessWidget {
  double lineGap = 8;
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
                    const TextSpan(
                        text:
                            'Please review your medications and verify that the List is up to date:.'),
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
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Alburerol 900 mcg/actuation inhaler',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'Inhale 2 puffs into the lungs every 6 hrs as needed for wheezing',
                          style: TextStyle(
                            color: Theme.of(context).dividerColor,
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Icon(Icons.info),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            const Text('Learn More'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                      ),
                    ),
                    padding: EdgeInsets.all(Configuration.fieldGap),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Prescription Details'),
                            Text('Refill Details'),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: lineGap,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Prescribed ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                                style: TextStyle(
                                  color: Theme.of(context).dividerColor,
                                ),
                              ),
                              Text(
                                'Quantity: ',
                                style: TextStyle(
                                  color: Theme.of(context).dividerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: lineGap,
                          ),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Approved by: ',
                            style: TextStyle(
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: lineGap * 1.5,
                          ),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Pharmacy Details: ',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: lineGap / 2,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: Configuration.width * .5,
                                child: Text(
                                  'CVS/pharmacy #123, walpor, MA-929 main stret at downtown 929 Main street, Walpole MA - 0291 958-454-1212',
                                  style: TextStyle(
                                    color: Theme.of(context).dividerColor,
                                  ),
                                ),
                              ),
                              Spacer(
                                flex: 2,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Icon(Icons.location_on),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  const Text('Maps'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: lineGap),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: RaisedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Request Refill',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Theme.of(context).accentColor,
                                ),
                                width: Configuration.width * .4,
                              ),
                              /*Container(
                                child: OutlineButton(
                                  onPressed: () {},
                                  child: Text('Remove'),
                                ),
                                width: Configuration.width * .4,
                              ),*/
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 10,
              ),
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                onPressed: () {},
                child: Text(
                  'Add a Personal Note',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
