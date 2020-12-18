import 'package:accurate_doctor/navigation/NavigationPage.dart';
import 'package:flutter/foundation.dart';

class ItemList {
  final String title;
  final String iconName;
  final String linkedPageName;

  ItemList(this.title, this.iconName, this.linkedPageName);
}

class MyHealthItems {
  List<ItemList> _items = [
    ItemList('Test', "assets/img/test.png", null),
    ItemList('Medical history', "assets/img/my_health.png", null),
    //ItemList('Cover Plans', "assets/img/cover.png", null),
    //ItemList('Refill Rx', "assets/img/subs.png", NavigationPage.Subscription),
    ItemList('Health summary', "assets/img/summary.png",
        NavigationPage.HealthSummary),
    //ItemList('Upload documents', "assets/img/upload.png", null),
  ];

  List<ItemList> getItems() {
    return [..._items];
  }
}

class ManageItems {
  List<ItemList> _items = [
    ItemList('Subscription Plans', "assets/img/cover.png", null),
    ItemList('Refill Rx', "assets/img/subs.png", NavigationPage.Subscription),
    ItemList('Upload documents', "assets/img/upload.png", null),
  ];

  List<ItemList> getItems() {
    return [..._items];
  }
}
