import 'package:flutter/material.dart';

class WalletsCard extends StatelessWidget {
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
                child: Column(
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
