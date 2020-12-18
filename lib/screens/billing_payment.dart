import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/modal/RescheduleDataModal.dart';
import 'package:accurate_doctor/widget/billing_payment_page/billing_payment_wizard.dart';
import 'package:accurate_doctor/widget/common/bottom_navigation.dart';
import 'package:accurate_doctor/widget/common/circular_wizard_box.dart';
import 'package:accurate_doctor/widget/common/page_appbar.dart';
import 'package:flutter/material.dart';

class BillingAndPaymentPage extends StatelessWidget {
  RescheduleDataModal rescheduleDataModal =
      RescheduleDataModal('', false, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        pageTitle: 'Billing & Payment',
      ),
      body: Container(
        padding: EdgeInsets.all(Configuration.pagePadding),
        child: BillingAngPaymentWizard(
          items: rescheduleDataModal.getBilling(),
          isMyOrder: true,
        ),
      ),
      bottomNavigationBar: BottomNavigation(0),
    );
  }
}
