import '../widget/common/page_appbar.dart';
import '../widget/reschedule/my_orders.dart';
import '../widget/reschedule/order_history.dart';
import 'package:flutter/material.dart';

class ManageReschedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        pageTitle: 'Reschedule',
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
                      child: OrderHistory(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
