import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../navigation/Constants.dart';
import '../widget/common/bottom_navigation.dart';
import '../widget/common/page_appbar.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  List<Widget> messages = [];
  Messages() {
    this.getMessages();
  }

  void getMessages() {
    int i = 0;
    while (i < 10) {
      messages.add(Card(
        child: Container(
          padding: EdgeInsets.all(Configuration.pagePadding * .5),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                    child: Icon(FontAwesome.user_circle_o),
                    radius: 30,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Dr. Divya',
                            style: TextStyle(
                              color: Configuration.ColorFromHex('#31216F'),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            alignment: Alignment.topRight,
                            child: Text(
                              '18:00',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Hey there !!!. We are available online',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ));
      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        pageTitle: 'Messages',
      ),
      body: Container(
        padding: EdgeInsets.all(Configuration.pagePadding),
        child: messages.length == 0
            ? Center(
                child: Text(
                  'No messages available',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              )
            : ListView(
                children: this.messages,
              ),
      ),
      bottomNavigationBar: BottomNavigation(Tabs.TeleHealth.index),
    );
  }
}
