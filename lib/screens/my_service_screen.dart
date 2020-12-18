import 'package:accurate_doctor/widget/common/page_appbar.dart';
import 'package:accurate_doctor/widget/my_service/my_order.dart';
import 'package:accurate_doctor/widget/my_service/order_history.dart';
import 'package:flutter/material.dart';

class MyServicePage extends StatefulWidget {
  @override
  _MyServicePageState createState() => _MyServicePageState();
}

class _MyServicePageState extends State<MyServicePage> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        pageTitle: 'My Service',
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              child: TabBar(
                tabs: [
                  Tab(
                    text: 'My Order',
                  ),
                  Tab(
                    text: 'Order History',
                  ),
                ],
                labelColor: Theme.of(context).accentColor,
                labelStyle: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: TabBarView(
                  children: [
                    Container(
                      child: MyOrders(),
                    ),
                    Container(
                      child: ServiceOrderHistory(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
