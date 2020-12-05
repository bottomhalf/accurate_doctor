import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:accurate_doctor/widget/common/expandable_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class OrderHistoryCard extends StatelessWidget {
  dynamic orderHistory;
  OrderHistoryCard({this.orderHistory});
  bool isUpcomingApptAvailable = true;
  AjaxCall http = AjaxCall.getInstance;

  List<Widget> _bindOrderHistoryCards(BuildContext context) {
    List<Widget> cardWidgets = [];
    int index = 0;
    print('OrderHistory count: ${this.orderHistory.length}');
    if (this.orderHistory.length <= 0) {
      cardWidgets.add(Container(
        padding: EdgeInsets.only(
          top: 10,
        ),
        child: Text(
          'No history found',
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
      ));
    } else {
      while (index < this.orderHistory.length) {
        cardWidgets.add(Container(
          margin: EdgeInsets.symmetric(vertical: Configuration.fieldGap),
          child: ExpandableCard(
            cardTitle: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      Text(
                        'Patient name: ',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${this.orderHistory.elementAt(index)['strName']} [ ${this.orderHistory.elementAt(index)['strOrderNo']} #]',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Wrap(
                    children: [
                      Text(
                        'Service:',
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        '${this.orderHistory.elementAt(index)['strServiceType']}',
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Scheduled On:',
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        '${this.orderHistory.elementAt(index)['strScheduleDate']}',
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('View detail'),
                      SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(FontAwesome.caret_down),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: Card(
              elevation: 4,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Patient name',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          Text(
                            this.orderHistory.elementAt(index)['strName'],
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Patient name',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          Text(
                            this.orderHistory.elementAt(index)['strName'],
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Patient name',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          Text(
                            this.orderHistory.elementAt(index)['strName'],
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Patient name',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          Text(
                            this.orderHistory.elementAt(index)['strName'],
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
        index++;
      }
    }
    return cardWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return isUpcomingApptAvailable
        ? Container(
            padding: EdgeInsets.symmetric(vertical: Configuration.fieldGap * 2),
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    right: 10,
                    left: 10,
                  ),
                  child: CircularProgressIndicator(),
                ),
                Text(
                  'Getting appointments ...',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ],
            ),
          )
        : Column(
            children: this._bindOrderHistoryCards(context),
          );
  }
}
