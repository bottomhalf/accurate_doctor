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
    ItemList('My health', "assets/img/my_health.png", null),
    ItemList('Cover Plans', "assets/img/cover.png", null),
    ItemList(
        'Subscription', "assets/img/subs.png", NavigationPage.Subscription),
    ItemList('Health summery', "assets/img/summary.png",
        NavigationPage.HealthSummary),
    ItemList('Upload documents', "assets/img/upload.png", null),
  ];

  List<ItemList> getItems() {
    return [..._items];
  }
}
