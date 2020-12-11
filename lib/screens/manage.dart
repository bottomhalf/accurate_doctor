import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/modal/myHealthItems.dart';
import 'package:accurate_doctor/widget/common/bottom_navigation.dart';
import 'package:accurate_doctor/widget/common/page_appbar.dart';
import 'package:accurate_doctor/widget/drawer/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class Manage extends StatefulWidget {
  @override
  _ManageState createState() => _ManageState();
}

class _ManageState extends State<Manage> {
  List<ItemList> items = ManageItems().getItems();

  Widget getItemCard(BuildContext context, ItemList item) {
    return Container(
      //padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.lightBlueAccent,
            blurRadius: 20.0,
            spreadRadius: -16,
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          if (item.linkedPageName != null)
            Navigator.of(context).pushNamed(item.linkedPageName);
        },
        child: Card(
          elevation: 4,
          shadowColor: Colors.lightBlueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                item.iconName,
                width: 40,
              ),
              SizedBox(
                height: 6,
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  width: 100,
                  child: Text(
                    item.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        pageTitle: 'Manage',
      ),
      body: Container(
        padding: EdgeInsets.all(Configuration.pagePadding),
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return getItemCard(context, items.elementAt(index));
          },
          itemCount: items.length,
        ),
      ),
      bottomNavigationBar: BottomNavigation(3),
    );
  }
}
