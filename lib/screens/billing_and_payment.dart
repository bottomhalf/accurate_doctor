import 'package:fluttertoast/fluttertoast.dart';

import '../widget/billingAndPayment/net_banking.dart';
import '../modal/Configuration.dart';
import '../widget/billingAndPayment/wallets.dart';
import '../widget/billingAndPayment/add_cards.dart';
import '../navigation/Constants.dart';
import '../widget/common/bottom_navigation.dart';
import '../widget/common/page_appbar.dart';
import 'package:flutter/material.dart';

class BillingAndPayment extends StatelessWidget {
  String appointmentId = '';
  double payableAmount = 0;
  String doctorName;
  String date;
  String time;
  String location;
  double getAmount(BuildContext context) {
    var data = ModalRoute.of(context).settings?.arguments as dynamic;
    try {
      payableAmount = double.parse(data['fees']);
      appointmentId = data['appointmentId'];
      doctorName = data['doctor'];
      date = data['date'];
      time = data['time'];
      location = data['location'];
    } catch (ex) {
      Fluttertoast.showToast(msg: 'Invalid amount.');
    }

    return payableAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(pageTitle: 'Payment'),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).textTheme.headline1.color,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    'Amount Payable',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    'Rs. ${getAmount(context)}',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(Configuration.pagePadding),
            child: Column(
              children: [
                AddCards(),
                NetBankingCard(
                    amount: this.payableAmount,
                    appointmentId: this.appointmentId,
                    doctorName: this.doctorName,
                    date: this.date,
                    time: this.time,
                    location: this.location),
                WalletsCard(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(Tabs.TeleHealth.index),
    );
  }
}
