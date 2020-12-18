import 'package:flutter/material.dart';
import 'package:upi_india/upi_india.dart';
import 'dart:convert';

class WalletsCard extends StatefulWidget {
  @override
  _WalletsCardState createState() => _WalletsCardState();
}

class _WalletsCardState extends State<WalletsCard> {
  Future<UpiResponse> _transaction;
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp> apps;
  bool isAppsReady = false;

  @override
  void initState() {
    _upiIndia
        .getAllUpiApps(mandatoryTransactionId: false)
        .then((List<UpiApp> value) {
      //print('Total: ${json.encode(value)}');
      setState(() {
        apps = value;
        isAppsReady = true;
      });
    }).catchError((e) {
      apps = [];
      isAppsReady = false;
    });
    super.initState();
  }

  Future<UpiResponse> openGooglePay(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "istiyaq.mi9@okaxis",
      receiverName: 'Md Istiyak',
      transactionRefId: 'UIP Testing',
      transactionNote: 'Not actual. Just an example.',
      amount: 1.00,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Wallets',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Card(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 10,
                ),
                child:
                    /*!this.isAppsReady
                    ? Text('Not found')
                    : Wrap(
                        children: apps.map<Widget>(
                          (UpiApp app) {
                            return ListTile(
                              leading: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor:
                                        Theme.of(context).backgroundColor,
                                    child:
                                        Image.asset("assets/img/googlepay.png"),
                                  ),
                                  Text(
                                    'Google Pay',
                                    style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: InkWell(
                                onTap: () {
                                  this.openGooglePay(app);
                                  setState(() {});
                                },
                                child: Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Pay now',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 8,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .color,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(),*/

                    Column(
                  children: [
                    ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Theme.of(context).backgroundColor,
                            child: Image.asset("assets/img/googlepay.png"),
                          ),
                          Text(
                            'Google Pay',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      trailing: InkWell(
                        onTap: () {},
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Pay now',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 8,
                                color:
                                    Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Theme.of(context).backgroundColor,
                            child: Image.asset("assets/img/applepay.png"),
                          ),
                          Text(
                            'Apple Pay',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      trailing: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Pay now',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 8,
                              color:
                                  Theme.of(context).textTheme.bodyText1.color,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text('More banks'),
                          padding: EdgeInsets.only(left: 20),
                        ),
                        Container(
                          child: Icon(Icons.keyboard_arrow_down),
                          padding: EdgeInsets.only(right: 20),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.lightBlueAccent,
                  blurRadius: 20.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
