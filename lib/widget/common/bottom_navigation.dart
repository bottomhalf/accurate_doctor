import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../navigation/NavigationPage.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  int currentTabIndex = 0;
  BottomNavigation(this.currentTabIndex);
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  void _onItemTap(int index) {
    if (Configuration.isDoctor) {
      switch (index) {
        case 0:
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.of(context).pushReplacementNamed(NavigationPage.Dashboard);
          break;
        case 1:
          Navigator.of(context).pushNamed(NavigationPage.EHR);
          break;
        case 2:
          Navigator.of(context).pushNamed(NavigationPage.MyReport);
          break;
        case 3:
          Navigator.of(context).pushNamed(NavigationPage.ManageDoctor);
          break;
      }
    } else {
      switch (index) {
        case 0:
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.of(context).pushReplacementNamed(NavigationPage.Dashboard);
          break;
        case 1:
          Navigator.of(context).pushNamed(NavigationPage.SecondOpinion);
          break;
        case 2:
          Navigator.of(context).pushNamed(NavigationPage.MyHealth);
          break;
        case 3:
          Navigator.of(context).pushNamed(NavigationPage.Manage);
          break;
      }
    }
  }

  List<BottomNavigationBarItem> bottomMenu() {
    List<BottomNavigationBarItem> bottomNavigationBarItem;
    if (Configuration.isDoctor) {
      bottomNavigationBarItem = <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).accentColor,
          icon: Icon(
            FontAwesome.tachometer,
            size: Configuration.width * .05,
          ),
          title: Text(
            'Tele Consult',
            style: TextStyle(
              fontSize: 12,
              height: 1.8,
            ),
          ),
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).accentColor,
          icon: Icon(
            FontAwesome.mobile_phone,
            size: Configuration.width * .05,
          ),
          title: Text(
            'EHR',
            style: TextStyle(
              fontSize: 12,
              height: 1.8,
            ),
          ),
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).accentColor,
          icon: Icon(
            FontAwesome.stethoscope,
            size: Configuration.width * .05,
          ),
          title: Text(
            'My Reports',
            style: TextStyle(
              fontSize: 12,
              height: 1.8,
            ),
          ),
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).accentColor,
          icon: Icon(
            Icons.perm_identity,
            size: Configuration.width * .05,
          ),
          title: Text(
            'Manage',
            style: TextStyle(
              fontSize: 12,
              height: 1.8,
            ),
          ),
        ),
      ];
    } else {
      bottomNavigationBarItem = <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).accentColor,
          icon: Icon(
            FontAwesome.tachometer,
            size: Configuration.width * .05,
          ),
          title: Text(
            'Tele Consult',
            style: TextStyle(
              fontSize: 12,
              height: 1.8,
            ),
          ),
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).accentColor,
          icon: Icon(
            FontAwesome.stethoscope,
            size: Configuration.width * .05,
          ),
          title: Text(
            'Second Opinion',
            style: TextStyle(
              fontSize: 12,
              height: 1.8,
            ),
          ),
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).accentColor,
          icon: Icon(
            FontAwesome.heartbeat,
            size: Configuration.width * .05,
          ),
          title: Text(
            'My Health',
            style: TextStyle(
              fontSize: 12,
              height: 1.8,
            ),
          ),
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).accentColor,
          icon: Icon(
            Icons.perm_identity,
            size: Configuration.width * .05,
          ),
          title: Text(
            'Manage',
            style: TextStyle(
              fontSize: 12,
              height: 1.8,
            ),
          ),
        ),
      ];
    }
    return bottomNavigationBarItem;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
        items: this.bottomMenu(),
        currentIndex: widget.currentTabIndex,
        unselectedItemColor: Colors.white30,
        selectedItemColor: Colors.white,
        backgroundColor: Theme.of(context).accentColor,
        onTap: _onItemTap,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
