import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/modal/user_detail.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class PageAppBar extends StatefulWidget implements PreferredSizeWidget {
  String pageTitle = 'No title';
  Widget bottomWidget;
  PageAppBar({Key key, this.pageTitle, this.bottomWidget})
      : preferredSize = Size.fromHeight(60.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _PageAppBarState createState() => _PageAppBarState();
}

class _PageAppBarState extends State<PageAppBar> {
  String dropdownValue = Configuration.currency;
  UserDetail userDetail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDetail = UserDetail.instance;
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: AppBar(
        title: Text(widget.pageTitle),
        backgroundColor: Theme.of(context).accentColor,
        actions: [
          Badge(
            position: BadgePosition.topEnd(top: 2, end: 4),
            badgeContent: Text(
              '0',
              style: TextStyle(color: Colors.white),
            ),
            child: IconButton(
              icon: Icon(Icons.chat_bubble_outline),
              onPressed: () {},
            ),
          ),
          Badge(
            position: BadgePosition.topEnd(top: 2, end: 4),
            badgeContent: Text(
              userDetail.notificationCount.toString(),
              style: TextStyle(color: Colors.white),
            ),
            child: IconButton(
              icon: Icon(Icons.notifications_none),
              onPressed: () {},
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            alignment: Alignment.bottomLeft,
            width: Configuration.width * .12,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: dropdownValue,
                iconSize: 0,
                elevation: 16,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                onChanged: (String newValue) {
                  if (newValue != null && newValue != "") {
                    Configuration.currency = newValue;
                    setState(() {
                      dropdownValue = newValue;
                    });
                  }
                },
                items: <String>['INR', 'USD']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: this.dropdownValue == value
                            ? Colors.white
                            : Theme.of(context).accentColor,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
        bottom: widget.bottomWidget,
      ),
    );
  }
}
