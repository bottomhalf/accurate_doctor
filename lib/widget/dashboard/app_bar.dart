import 'package:accurate_doctor/navigation/NavigationPage.dart';

import '../../widget/dashboard/filter_bar.dart';
import 'package:flutter/widgets.dart';
import '../../modal/user_detail.dart';
import '../../modal/Configuration.dart';
import '../../provider/dashboard_header_menu.dart';
import '..//dashboard/header_bar.dart';
import '../dashboard/header_navbar.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class DashboardAppBar extends StatefulWidget with PreferredSizeWidget {
  final String appBarHeader;
  bool isFocused;
  Function searchResult;
  String defaultSearchText;
  DashboardAppBar(
      {Key key,
      this.appBarHeader,
      this.searchResult,
      this.isFocused = false,
      this.defaultSearchText})
      : preferredSize = Size.fromHeight(
            Configuration.height * .20), // previous value = 0.25
        super(key: key);

  @override
  Size preferredSize;

  @override
  _DashboardAppBarState createState() => _DashboardAppBarState();
}

class _DashboardAppBarState extends State<DashboardAppBar> {
  final _searchBox = FocusNode();
  String currentPage;
  var headerMenuItem = [];
  int itemCount;
  UserDetail userDetail;
  String dropdownValue = Configuration.currency;

  @override
  void initState() {
    super.initState();
    userDetail = UserDetail.instance;
    var dashboardHeaderMenu = DashboardHeaderMenu();
    headerMenuItem = dashboardHeaderMenu.getMenu();
    if (headerMenuItem.length > 0)
      itemCount = headerMenuItem.length;
    else
      itemCount = 0;
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: AppBar(
        elevation: 0,
        title: Text(widget.appBarHeader),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.0, 1.0],
              colors: <Color>[
                Theme.of(context).accentColor,
                Theme.of(context).textTheme.headline1.color,
              ],
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20.0),
          child: Column(
            children: [
              Container(
                height: 34,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: FilterBar(
                  defaultText: widget.defaultSearchText,
                  searchCurrentItem: widget.searchResult,
                ),
              ),
              HeaderBar(this.userDetail?.firstName, 'India'),
              // Material(
              //   elevation: 4,
              //   child: Container(
              //     height: Configuration.height * .06,
              //     decoration: BoxDecoration(
              //       border: Border.all(
              //         width: 0,
              //       ),
              //     ),
              //     width: Configuration.width,
              //     child: ListView.builder(
              //       itemCount: itemCount,
              //       scrollDirection: Axis.horizontal,
              //       itemBuilder: (ctx, index) {
              //         return HeaderNavBar(
              //           headerMenuItem[index]['key'],
              //           headerMenuItem[index]['value'],
              //         );
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        actions: [
          Badge(
            position: BadgePosition.topEnd(top: 2, end: 4),
            badgeContent: Text(
              '0',
              style: TextStyle(color: Colors.white),
            ),
            child: IconButton(
              icon: Icon(Icons.chat_bubble_outline),
              onPressed: () {
                Navigator.of(context).pushNamed(NavigationPage.Messages);
              },
            ),
          ),
          Badge(
            position: BadgePosition.topEnd(top: 2, end: 4),
            badgeContent: Text(
              this.userDetail.notificationCount.toString(),
              style: TextStyle(color: Colors.white),
            ),
            child: IconButton(
              icon: Icon(Icons.notifications_none),
              onPressed: () {
                Navigator.of(context).pushNamed(NavigationPage.Notification);
              },
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
                  fontSize: 18,
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
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }
}
