import 'package:accurate_doctor/widget/reschedule/order_history_filter.dart';
import 'package:flutter/material.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RescheduleOrderHistoryFilter(),
          ],
        ),
      ),
    );
  }
}
